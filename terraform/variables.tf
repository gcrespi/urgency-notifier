variable "environment" {
  description = "Environment that is being used"
  default     = "dev"
}

variable "profile" {
  description = "Profile of the aws profile to use for the deployment (should correspond to the environment)"
  default     = "default"
}

variable "region" {
  description = "Region where the resources are going to be created"
  default     = "us-east-1"
}
