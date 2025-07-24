resource "google_service_account_iam_member" "impersonation" {
  service_account_id = var.app_service_account
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${var.app_service_account}"
}
