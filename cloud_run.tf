resource "google_cloud_run_service" "app" {
  name     = "university-app"
  location = var.region

  template {
    metadata {
      annotations = {
        "run.googleapis.com/cloudsql-instances" = google_sql_database_instance.default.connection_name
      }
    }

    spec {
      containers {
        image = "${var.region}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.app_repo.repository_id}/${var.image_name}"

        env {
          name  = "DEBUG"
          value = "false"
        }

        env {
          name  = "REDIS_HOST"
          value = "redis"
        }

        env {
          name  = "REDIS_PORT"
          value = "6379"
        }

        env {
          name  = "BUCKER_ONE"
          value = google_storage_bucket.bucket_one.name
        }

        env {
          name  = "BUCKET_TWO"
          value = google_storage_bucket.bucket_two.name
        }

        env {
          name  = "DB_HOST"
          value = "/cloudsql/${google_sql_database_instance.default.connection_name}"
        }

        resources {
          limits = {
            cpu    = "500m"
            memory = "256Mi"
          }
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
}

data "google_iam_policy" "cloud_run_public_invoker" {
  binding {
    role    = "roles/run.invoker"
    members = ["allUsers"]
  }
}

resource "google_cloud_run_service_iam_policy" "public" {
  location    = google_cloud_run_service.app.location
  project     = var.project_id
  service     = google_cloud_run_service.app.name
  policy_data = data.google_iam_policy.cloud_run_public_invoker.policy_data
}

output "cloud_run_url" {
  value       = google_cloud_run_service.app.status[0].url
  description = "Public URL for the deployed Cloud Run service"
}

resource "google_project_iam_member" "cloudrun_deploy" {
  project = var.project_id
  role    = "roles/run.admin"
  member  = "serviceAccount:${var.app_service_account}"
}

