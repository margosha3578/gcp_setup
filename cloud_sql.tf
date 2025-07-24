resource "google_sql_database_instance" "default" {
  name             = "university-db"
  database_version = "POSTGRES_13"
  region           = var.region

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_database" "app_db" {
  name     = "appdb"
  instance = google_sql_database_instance.default.name
}

resource "google_sql_user" "app_user" {
  name     = var.db_user_name
  password = var.db_user_password
  instance = google_sql_database_instance.default.name
}

resource "google_project_iam_member" "cloudsql_access" {
  project = var.project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${var.app_service_account}"
}
