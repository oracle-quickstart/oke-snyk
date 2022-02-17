# Copyright (c) 2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
# 

variable "snyk_integration_id" {
  default     = ""
  description = "Snyk Integration Id"
}

variable "snyk_deploy_goof_sample" {
  default     = false
  description = "Deploy Snyk's Goof Sample"
}