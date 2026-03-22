#!/usr/bin/env bash

set -e  # exit on error
set -o pipefail

echo "🚀 Starting Docker installation..."

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run as root (use sudo)"
  exit 1
fi

echo "Updating system packages..."
apt update

echo "Installing dependencies..."
apt install -y ca-certificates curl gnupg

echo "Setting up Docker GPG key..."
install -m 0755 -d /etc/apt/keyrings

if [ ! -f /etc/apt/keyrings/docker.asc ]; then
  curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
  chmod a+r /etc/apt/keyrings/docker.asc
fi

echo "Adding Docker repository..."
DOCKER_SOURCE_FILE="/etc/apt/sources.list.d/docker.sources"

if [ ! -f "$DOCKER_SOURCE_FILE" ]; then
  tee "$DOCKER_SOURCE_FILE" > /dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF
fi

echo "Updating package index with Docker repo..."
apt update

echo "Installing Docker..."
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo " Enabling and starting Docker..."
systemctl enable docker
systemctl start docker

echo "Verifying Docker installation..."
if systemctl is-active --quiet docker; then
  echo "Docker is running!"
else
  echo "Docker failed to start"
  exit 1
fi

echo "Docker installation complete!"
