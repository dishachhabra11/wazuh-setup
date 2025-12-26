terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }

  }
}

provider "google" {
  project = var.project_id   # GCP project ID
  region  = var.region       # default region
}

provider "random" {
  # Configuration options
}
