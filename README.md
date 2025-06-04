# Weatherapp

A simple weather application with containerized deployment, cloud hosting, and automated infrastructure provisioning.

## What Has Been Added to the Original Template

The original repository contained basic frontend and backend code. This solution adds a complete production-ready infrastructure:

### Docker and Docker Compose

- Multi-stage Dockerfiles for both frontend and backend with development and production targets  
- Docker Compose configurations for both development and production environments  
- Hot reload support for development with volume mounting  
- Optimized builds using Alpine Linux and multi-stage builds  

### Infrastructure

- Terraform modules  
- EC2 instance with security groups  
- SSH key management  

### Nginx

- Nginx reverse proxy for secure external access  
- Container isolation  

### Ansible

- Docker and Docker Compose v2 installation playbook  
- Application deployment playbook  
- Additional admin user management for task evaluation  

---

## Prerequisites

Before running the app, ensure you have:

1. Docker and Docker Compose installed on your local machine  
2. OpenWeatherMap API key  
3. AWS account  
4. Terraform installed on your system  
5. Ansible installed  
6. SSH key pair for AWS access  

---

## Quick Start

### 1. Local Development Setup

#### Step 1: Clone and Configure

```bash
# Clone the repository
git clone https://github.com/igorkaw7/recruitment-2025.git
cd recruitment-2025-main

# Create backend environment file
cp backend/.env.example backend/.env.local
```

#### Step 2: Configure Environment Variables

Edit `backend/.env.local`:

```env
APPID=your_openweathermap_api_key_here
MAP_ENDPOINT=http://api.openweathermap.org/data/2.5
TARGET_CITY=Helsinki,fi
PORT=9000
```

#### Step 3: Run the Application Locally in Development Mode

```bash
# Start development environment with hot reload
docker compose up --build
```

Access the application:

- Frontend: http://localhost:8000  
- Backend API: http://localhost:9000/api/weather

---

### 2. Production Deployment on AWS

#### Step 1: Infrastructure Provisioning

```bash
cd terraform

# Initialize Terraform
terraform init

# Review the infrastructure plan
terraform plan

# Deploy infrastructure
terraform apply
```

Note the output IP address for next steps or run:

```bash
terraform output
```

#### Step 2: Configure Ansible Inventory

Update `host.ini` with your EC2 instance IP:

```ini
[weatherapp]
weatherapp ansible_host=YOUR_EC2_PUBLIC_IP ansible_user=ec2-user

[all:vars]
ansible_python_interpreter=/usr/bin/python3
```

#### Step 3: Install Docker and Deploy Application

```bash
cd ansible

# Install Docker on the remote server
ansible-playbook playbooks/install_docker.yml

# Deploy the application
ansible-playbook playbooks/deploy_app.yml
```

#### Step 4: Access the Application

- HTTP: http://YOUR_EC2_PUBLIC_IP  
- API: http://YOUR_EC2_PUBLIC_IP/api/weather  

---

## Local Development Workflow

1. Make code changes in `backend/src` or `frontend/src`  
2. Changes automatically reload in development containers  
3. Test changes at http://localhost:8000  

---

## Possible Improvements

### Enable communication over HTTPS
- Obtain a domain name  
- Configure DNS to resolve the domain to the EC2 public IP using Route 53  
- Add Let's Encrypt certificates  
- Enable port 443 access  
- Create an SSL-enhanced Nginx configuration  

### Health Checks

- Add basic Docker Compose health checks  
  - Use `wget --quiet --tries=1 --spider` for API and frontend  
  - Use `nginx -t` for Nginx validation  

### Certbot Integration

- Add a Certbot service to Docker Compose for SSL certificate management  

### SSL Setup Playbook

- Automate SSL certificate generation and management  
- Connect certificate to updated Nginx config and Certbot  
- Setup certificate renewal cron job  
- Test API over HTTPS  

### CI/CD

- Automate deployment with GitHub Actions  
- Deploy jobs executed on deploy agents  

### AWS Secrets Manager Integration

- Store the API key securely  
- Use IAM-based permissions to control access by deploy agents  
