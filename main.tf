# Create new storage bucket in the EU multi-region
# and settings for web pages
resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "lagcloud-solutions" {
  name          = "${random_id.bucket_prefix.hex}-lagcloud-solutions-bucket"
  location      = "EU"
  storage_class = "STANDARD"
  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

resource "google_storage_bucket_object" "home_page" {
  name         = "index.html"
  source       = "index.html"
  content_type = "text/html"
  bucket       = google_storage_bucket.lagcloud-solutions.id
}

resource "google_storage_bucket_object" "error_page" {
  name         = "404.html"
  source       = "404.html"
  content_type = "text/html"
  bucket       = google_storage_bucket.lagcloud-solutions.id
}

resource "google_storage_bucket_object" "services_page" {
  name         = "services.html"
  source       = "services.html"
  content_type = "text/html"
  bucket       = google_storage_bucket.lagcloud-solutions.id
}

resource "google_storage_bucket_object" "styles_css" {
  name         = "styles.css"
  source       = "style/styles.css"
  content_type = "text/css"
  bucket       = google_storage_bucket.lagcloud-solutions.id
}

resource "google_storage_bucket_object" "lagcloud_logo" {
  name         = "lagcloud_logo.png"
  source       = "images/lagcloud-removebg-preview.png"
  content_type = "image/png"
  bucket       = google_storage_bucket.lagcloud-solutions.id
}

resource "google_storage_bucket_object" "large_image" {
  name         = "lagcloudimage.jpg"
  source       = "images/lagcloudimage.jpg"
  content_type = "image/jpg"
  bucket       = google_storage_bucket.lagcloud-solutions.id
}

# Make bucket public by granting allUsers READER access
resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.lagcloud-solutions.id
  role   = "READER"
  entity = "allUsers"
}
