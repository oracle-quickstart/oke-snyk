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
variable "snyk_private_registry" {
  default     = false
  description = "Enter credentials to scan private registry. If need more than one, update the created secret with the new credentials."
}
variable "snyk_private_registry_url" {
  default     = ""
  description = "Enter private registry url. i.e. iad.ocir.io"
}
variable "snyk_private_registry_username" {
  default     = ""
  description = "Enter private registry username. i.e. <tenancy-namespace>/oracleidentitycloudservice/<username>"
}
variable "snyk_private_registry_password" {
  default     = ""
  description = "Enter private registry password or auth token. Note: For ocir.io, the password is the auth token generated for the user."
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