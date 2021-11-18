# Copyright (c) 2021 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
# 

resource "kubernetes_namespace" "goof_app_namespace" {
  metadata {
    name = "goof"
  }

  depends_on = [data.oci_containerengine_cluster_kube_config.oke]
}