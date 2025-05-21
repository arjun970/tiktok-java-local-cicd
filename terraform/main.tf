terraform {
  required_providers {
    vagrant = {
      source = "terra-farm/vagrant"
      version = "~> 0.3"
    }
  }

  required_version = ">= 0.12"
}

# Configure Vagrant provider
provider "vagrant" {}

# Provision VM with Vagrant
resource "vagrant_vm" "tikvm" {
  name = "tik-tok-vm"  # VM name
  box  = "ubuntu/bionic64"  # Box type (Ubuntu)

  # Sync project directory with VM
  synced_folder {
    host_path  = "../"    # Path to the local project folder
    guest_path = "/home/vagrant/tiktok"  # VM directory
  }

  # Provision the VM with necessary software
  provisioner "shell" {
    inline = [
      # Update and install required packages
      "sudo apt-get update",
      "sudo apt-get install -y openjdk-11-jdk maven git docker.io curl gnupg2",
      "sudo systemctl enable docker",
      "sudo usermod -aG docker vagrant",
      
      # Install Jenkins repository and Jenkins
      "curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null",
      "echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
      "sudo apt-get update",
      "sudo apt-get install -y jenkins",
      
      # Start Jenkins service
      "sudo systemctl enable jenkins",
      "sudo systemctl start jenkins"
    ]
  }
}

# Output the VM's IP address
output "vm_ip" {
  value = vagrant_vm.tikvm.ipv4_address
}
