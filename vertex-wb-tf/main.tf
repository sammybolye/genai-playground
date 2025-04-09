variable "user_metadata" {
  type    = map(string)
  default = {}
}

# Fetch the current project ID
data "google_project" "current" {}

# Retrieve only the tag from project metadata
data "external" "container_tag_metadata" {
  program = ["bash", "-c", "echo '{\"value\": \"'$(gcloud compute project-info describe --format='value(commonInstanceMetadata.items.dl-custom-container-tag)')'\"}'"]
}

locals {
  container_repository = "us-central1-docker.pkg.dev/vertex-421211/vertex-docker-repo/dl-vscode"
  container_tag        = data.external.container_tag_metadata.result.value
}

resource "google_workbench_instance" "instance" {
  name     = "sin"
  location = "us-central1-a"

  gce_setup {
    machine_type = "e2-standard-2"

    container_image {
      repository = local.container_repository
      tag        = local.container_tag
    }

    shielded_instance_config {
      enable_secure_boot          = true
      enable_vtpm                 = true
      enable_integrity_monitoring = true
    }

    metadata = merge(
      {
        terraform                  = "true"
        notebook-disable-terminal  = "false"
        notebook-disable-root      = "false"
        post-startup-script        = "gs://vertex-421211/setroot.sh"
        idle-timeout-seconds       = "600"
      },
      var.user_metadata
    )

    tags = ["egress"]
  }

  labels = {
    owner = "shyamn"
  }
}

output "container_repository" {
  value = local.container_repository
}

output "container_tag" {
  value = local.container_tag
}
