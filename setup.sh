#!/bin/bash

# Step 1: Ensure the script is being run from the correct directory
echo "Starting setup process..."

# Ensure we're in the project root directory (adjust if necessary)
PROJECT_ROOT="$(pwd)"
TERRAFORM_DIR="${PROJECT_ROOT}/terraform"
VAGRANT_DIR="${PROJECT_ROOT}/vagrant"
DOCKER_DIR="${PROJECT_ROOT}/docker"

# Check if Terraform config files exist
if [ ! -d "$TERRAFORM_DIR" ] || [ ! -f "${TERRAFORM_DIR}/main.tf" ]; then
    echo "Terraform configuration files not found. Please check the directory structure."
    exit 1
fi

# Step 2: Initialize Terraform
echo "Initializing Terraform..."
cd "$TERRAFORM_DIR" || exit 1
terraform init

# Step 3: Apply Terraform configuration (this will manage Docker containers or other resources)
echo "Applying Terraform configuration..."
terraform apply -auto-approve

# Step 4: Initialize Vagrant VM
echo "Initializing Vagrant VM..."
cd "$VAGRANT_DIR" || exit 1
vagrant up

# Step 5: Wait for VM to be ready and Jenkins to be up
echo "Waiting for Jenkins to be up (this may take a few minutes)..."
sleep 60  # Adjust this based on your VM speed

# Step 6: Output Jenkins URL
echo "Jenkins should now be available at: http://localhost:8081"

# Step 7: Build and run Docker containers (optional based on Terraform configuration)
if [ -d "$DOCKER_DIR" ]; then
    echo "Building Docker image and running container from the Dockerfile..."
    cd "$DOCKER_DIR" || exit 1
    docker-compose up -d
fi

echo "Setup completed successfully!"
