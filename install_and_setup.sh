#!/bin/bash

set -e

echo "🔧 Checking and installing required tools..."

# Function to install a package if not already installed
install_if_missing() {
    if ! command -v "$1" &> /dev/null; then
        echo "Installing $1..."
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            sudo apt-get update
            sudo apt-get install -y "$2"
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            brew install "$2"
        else
            echo "Please install $1 manually"
            exit 1
        fi
    else
        echo "$1 is already installed."
    fi
}

# Install tools
install_if_missing virtualbox virtualbox
install_if_missing vagrant vagrant
install_if_missing terraform terraform
install_if_missing git git

echo "📁 Cloning project from GitHub..."
git clone https://github.com/YOUR_USERNAME/tiktok-java-local-cicd.git
cd tiktok-java-local-cicd

echo "🚀 Initializing Terraform VM provisioning..."
cd terraform
terraform init
terraform apply -auto-approve

echo "⌛ Waiting for VM to finish provisioning..."
sleep 30

echo "🔐 SSH into VM and print Jenkins admin password:"
vagrant ssh -c "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"

echo "📦 Setup complete!"
echo "🧪 Open Jenkins at: http://localhost:8081"
echo "📽 Access TikTok app at: http://localhost:8080/videos"
