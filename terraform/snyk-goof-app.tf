# Copyright (c) 2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
# 

#=======================================================================================
# DO NOT deploy the following sample application in a production environment.
# This application is used for demo purposes and contains a number of vulnerabilities.
# It is highly recommended that you promptly uninstall the application after
# you've completed the test.
#=======================================================================================

resource "kubernetes_namespace" "goof_app_namespace" {
  metadata {
    name = "goof"
  }

  depends_on = [data.oci_containerengine_cluster_kube_config.oke]

  count = var.snyk_deploy_goof_sample ? 1 : 0
}

resource "kubernetes_deployment" "goof" {
  metadata {
    name      = "goof"
    namespace = kubernetes_namespace.goof_app_namespace.0.id
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app  = "goof"
        tier = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app  = "goof"
          tier = "frontend"
        }
      }

      spec {
        container {
          image = "snyklabs/goof"
          name  = "goof"

          resources {
            requests = {
              cpu    = "100m"
              memory = "100Mi"
            }
          }
          port {
            container_port = 3001
          }
          port {
            container_port = 9229
          }
          env {
            name  = "DOCKER"
            value = "1"
          }

        }
      }
    }
  }

  count = var.snyk_deploy_goof_sample ? 1 : 0
}

resource "kubernetes_deployment" "goof_mongo" {
  metadata {
    name      = "goof-mongo"
    namespace = kubernetes_namespace.goof_app_namespace.0.id
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app  = "goof"
        tier = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app  = "goof"
          tier = "backend"
        }
      }

      spec {
        container {
          image = "mongo"
          name  = "goof-mongo"
          port {
            container_port = 27017
          }
        }
      }
    }
  }

  count = var.snyk_deploy_goof_sample ? 1 : 0
}

resource "kubernetes_service" "goof" {
  metadata {
    name      = "goof"
    namespace = kubernetes_namespace.goof_app_namespace.0.id
  }
  spec {
    selector = {
      app  = "goof"
      tier = "frontend"
    }
    port {
      protocol    = "TCP"
      port        = 80
      target_port = 3001
      name        = "http"
    }
    port {
      protocol    = "TCP"
      port        = 9229
      target_port = 9229
      name        = "debug"
    }

    type = "clusterIP"
  }

  count = var.snyk_deploy_goof_sample ? 1 : 0
}

resource "kubernetes_service" "goof_mongo" {
  metadata {
    name      = "goof-mongo"
    namespace = kubernetes_namespace.goof_app_namespace.0.id
  }
  spec {
    selector = {
      app  = "goof"
      tier = "backend"
    }
    port {
      protocol    = "TCP"
      port        = 27017
      target_port = 27017
      name        = "mongo"
    }

    type = "clusterIP"
  }

  count = var.snyk_deploy_goof_sample ? 1 : 0
}

output "snyk_goof_sample_access" {
  value       = "kubectl proxy svc/goof --port=3001"
  description = "If using deployed the goof app, this command will allow you to access the app locally"
}

output "snyk_goof_sample_mongodb_access" {
  value       = "kubectl proxy svc/goof-mongo --port=27017"
  description = "If using deployed the goof app, this command will allow you to access the mongodb locally"
}