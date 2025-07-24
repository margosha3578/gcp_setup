resource "google_storage_bucket" "bucket_one" {
  name     = "user_images"
  location = "us-central1"
  storage_class = "STANDARD"
  force_destroy = true
}

resource "google_storage_bucket" "bucket_two" {
  name     = "user_files"
  location = "us-central1"
  storage_class = "STANDARD"
  force_destroy = true
}

resource "google_storage_bucket_iam_member" "bucket_one_access" {
  bucket = google_storage_bucket.bucket_one.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${var.app_service_account}"
}

resource "google_storage_bucket_iam_member" "bucket_two_access" {
  bucket = google_storage_bucket.bucket_two.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${var.app_service_account}"
}
