#!/bin/bash

# Step 1: Initialize Terraform
echo "Initializing Terraform..."
terraform init

# Step 2: Apply Terraform configuration to create Docker container
echo "Applying Terraform configuration..."
terraform apply -auto-approve

# Step 3: Initialize Vagrant VM
echo "Initializing Vagrant VM..."
vagrant up

# Step 4: Wait for VM to be ready and Jenkins to be up
echo "Waiting for Jenkins to be up (this may take a few minutes)..."
sleep 60  # Adjust this based on your VM speed

# Step 5: Output Jenkins URL
echo "Jenkins should now be available at: http://localhost:8081"
