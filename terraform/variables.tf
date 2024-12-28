variable "location" {
  default = "East US"
}
# variables.tf
variable "subscription_id" {
  description = "The subscription ID for Azure."
  type        = string
}

variable "client_id" {
  description = "The client ID for Azure."
  type        = string
}

variable "client_secret" {
  description = "The client secret for Azure."
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID for Azure."
  type        = string
}
