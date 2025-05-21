
# Java TikTok Application with Local CI/CD

This project sets up a Java Spring Boot TikTok-like API and deploys it with a local CI/CD pipeline using Jenkins, Terraform, VirtualBox, and Docker.

## Requirements
- VirtualBox
- Vagrant
- Terraform
- Git

## Setup Steps

### 1. Provision VM
```
cd terraform
terraform init
terraform apply
```

### 2. SSH into VM
```
vagrant ssh
```

### 3. Open Jenkins
Visit: http://localhost:8081

### 4. Run CI/CD Pipeline
- Push code to GitHub
- Trigger Jenkins build
- Access app at: http://localhost:8080/videos
