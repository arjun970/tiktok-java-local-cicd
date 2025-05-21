terraform {
  required_providers {
    docker = {
      source = "hashicorp/docker"
      version = "~> 2.0"
    }
  }

  required_version = ">= 0.12"
}

# Create Docker container using the previously built TikTok image
resource "docker_image" "tiktok_image" {
  name = "tiktokapp"
  build {
    context = "./docker"
  }
}

# Run the Docker container with the TikTok application
resource "docker_container" "tiktok_container" {
  name  = "tiktokapp"
  image = docker_image.tiktok_image.latest
  ports {
    internal = 8080
    external = 8080
  }
  restart = "always"
}

# Output container IP or status
output "container_ip" {
  value = docker_container.tiktok_container.ip_address
}
