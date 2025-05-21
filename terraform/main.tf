terraform {
  required_providers {
    vagrant = {
      source = "hashicorp/vagrant"
      version = "~> 0.1"
    }
  }

  required_version = ">= 0.12"
}
provider "vagrant" {}

resource "vagrant_vm" "tikvm" {
  name = "tik-tok-vm"
  box  = "ubuntu/bionic64"

  synced_folder {
    host_path  = "../"
    guest_path = "/home/vagrant/tiktok"
  }

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y openjdk-11-jdk maven git docker.io curl gnupg2",
      "sudo systemctl enable docker",
      "sudo usermod -aG docker vagrant",
      "curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null",
      "echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
      "sudo apt-get update",
      "sudo apt-get install -y jenkins",
      "sudo systemctl enable jenkins",
      "sudo systemctl start jenkins"
    ]
  }
}
