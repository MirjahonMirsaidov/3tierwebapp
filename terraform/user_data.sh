#!/bin/bash

# Update the package manager and install necessary packages
sudo yum update -y

# Install Docker
sudo amazon-linux-extras install docker -y

# Start Docker service
sudo service docker start

# Add the ec2-user to the docker group so you can run docker without sudo
sudo usermod -a -G docker ec2-user

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Apply executable permissions to the Docker Compose binary
sudo chmod +x /usr/local/bin/docker-compose

# Create a symbolic link for docker-compose (optional)
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Enable Docker service to start on boot
sudo systemctl enable docker
#
## Create a directory for the project
#mkdir -p /home/ec2-user/myapp
#cd /home/ec2-user/myapp
#
## Create the Docker Compose file
#cat <<EOF > docker-compose.yml
#version: '3.9'
#
#services:
#  web:
#    image: public.ecr.aws/a8p1y2a7/wr:latest
#    platform: linux/amd64
#    command: python manage.py runserver 0.0.0.0:8000
#    ports:
#      - "80:8000"
#    environment:
#      - DEBUG=True
#EOF



# Install Cloudwatch Agent
sudo yum install -y amazon-cloudwatch-agent

# Configure
sudo cat <<EOF > config.json
{
  "logs": {
    "logs_collected": {
      "files": {
        "collect_list": [
          {
            "file_path": "/var/log/docker/containers/*.log",
            "log_group_name": "/prod/webapp",
            "log_stream_name": "api"
          }
        ]
      }
    }
  }
}
EOF
# Start CloudWatch agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/home/ec2-user/config.json -s


## Change ownership of the directory to ec2-user
#chown -R ec2-user:ec2-user /home/ec2-user/myapp
#
## Run the Docker Compose up command
#sudo -u ec2-user docker-compose up -d
