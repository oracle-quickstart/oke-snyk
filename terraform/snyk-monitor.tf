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

# Secrets
resource "kubernetes_secret" "snyk_monitor" {
  metadata {
    name      = "snyk-monitor"
    namespace = kubernetes_namespace.snyk_monitor_namespace.id
  }
  data = {
    integrationId = var.snyk_integration_id
  }
  type = "Opaque"
}
resource "kubernetes_secret" "snyk_docker_cfg" {
  metadata {
    name = "docker-cfg"
  }

  data = {
    ".dockerconfigjson" = jsonencode({})
  }

  type = "kubernetes.io/dockerconfigjson"
}

# Helm Charts
## https://snyk.github.io/kubernetes-monitor/
resource "helm_release" "snyk_monitor" {
  name       = "snyk-monitor"
  repository = local.helm_repository.snyk_charts
  chart      = "snyk-monitor"
  namespace  = kubernetes_namespace.snyk_monitor_namespace.id
  wait       = true

  set {
    name  = "clusterName"
    value = "Test cluster"
  }
}

locals {
  # Helm repos
  helm_repository = {
    snyk_charts = "https://snyk.github.io/kubernetes-monitor"
  }
}