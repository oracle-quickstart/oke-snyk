# Copyright (c) 2021 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
# 

# Namespace
resource "kubernetes_namespace" "snyk_monitor_namespace" {
  metadata {
    name = "snyk-monitor"
  }

  depends_on = [data.oci_containerengine_cluster_kube_config.oke]
}

# Helm Charts
## https://github.com/snyk/kubernetes-monitor/tree/staging/snyk-monitor
resource "helm_release" "snyk_monitor" {
  name       = "snyk-monitor"
  repository = local.helm_repository.snyk_charts
  chart      = "snyk-monitor"
  namespace  = kubernetes_namespace.snyk_monitor_namespace.id
  wait       = true

  set {
    name  = "clusterName"
    value = yamldecode(data.oci_containerengine_cluster_kube_config.oke.content)["users"][0]["user"]["exec"]["args"][4]
  }
  set {
    name  = "sysdig.enabled"
    value = var.snyk_sysdig_integration
  }
}

locals {
  # Helm repos
  helm_repository = {
    snyk_charts = "https://snyk.github.io/kubernetes-monitor"
  }
}

# Secrets
resource "kubernetes_secret" "snyk_monitor" {
  metadata {
    name      = "snyk-monitor"
    namespace = kubernetes_namespace.snyk_monitor_namespace.id
  }
  data = {
    integrationId    = var.snyk_integration_id
    "dockercfg.json" = jsonencode({})
  }
  type = "Opaque"
}

# resource "kubernetes_secret" "snyk_docker_cfg" {
#   metadata {
#     name = "docker-cfg"
#   }

#   data = {
#     ".dockerconfigjson" = jsonencode({})
#   }

#   type = "kubernetes.io/dockerconfigjson"
# }

data "kubernetes_secret" "sysdig_eve" {
  metadata {
    name      = var.sysdig_eve_secret_name
    namespace = var.sysdig_agent_namespace
  }

  count = var.snyk_sysdig_integration ? 1 : 0
}

resource "kubernetes_secret" "sysdig_eve" {
  metadata {
    name      = var.sysdig_eve_secret_name
    namespace = kubernetes_namespace.snyk_monitor_namespace.id
  }
  data = data.kubernetes_secret.sysdig_eve.0.data
  type = data.kubernetes_secret.sysdig_eve.0.type

  count = var.snyk_sysdig_integration ? 1 : 0
}