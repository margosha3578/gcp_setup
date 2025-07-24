resource "google_artifact_registry_repository" "app_repo" {
  location       = var.region
  repository_id  = "university-app-repo"
  format         = "DOCKER"
  description    = "Docker repo for Cloud Run app"
}

resource "google_project_iam_member" "artifact_push" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${var.app_service_account}"
}
