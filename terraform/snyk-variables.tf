# Copyright (c) 2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.
# 

variable "snyk_integration_id" {
  default     = ""
  description = "Snyk Integration Id"
}

variable "snyk_deploy_goof_sample" {
  default     = false
  description = "NOTE: DO NOT deploy the sample application in a production environment. This application is used for demo purposes and contains a number of vulnerabilities. It is highly recommended that you promptly uninstall the application after you've completed the tutorial."
}

variable "snyk_sysdig_integration" {
  default     = false
  description = "Enrich the issues detected by Snyk for workloads with runtime data provided by Sysdig. NOTE: The Sysdig agent must be installed and running on the same cluster."
}

variable "sysdig_eve_secret_name" {
  default     = "sysdig-eve-secret"
  description = "Sysdig Eve Secret Name"
}

variable "sysdig_agent_namespace" {
  default     = "sysdig-agent"
  description = "Sysdig Agent Namespace"
}