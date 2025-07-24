variable "project_id" {
  type        = string
  description = "neural-sunup-460717-v7"
}

variable "region" {
  type        = string
  description = "us-central1"
  default     = "GCP region"
}

variable "image_name" {
  type        = string
  description = "App name"
  default = "university-app"
}

variable "app_service_account" {
  type        = string
  description = "Service account used by Cloud Run to access resources"
}

variable "db_user_name" {
  type        = string
  description = "Database user name for app access"
  default     = "appuser"
}

variable "db_user_password" {
  type        = string
  description = "Password for the database user"
  sensitive   = true
}


