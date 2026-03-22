# 🐳 Docker Installation Script (Debian)

This repository contains a reusable script to install Docker on Debian-based systems in a consistent and debuggable way.

---

## 📦 What This Script Does

* Installs required dependencies (`curl`, `ca-certificates`, etc.)
* Adds Docker’s official GPG key
* Configures the Docker APT repository
* Installs Docker Engine + CLI + plugins
* Enables and starts the Docker service
* Verifies that Docker is running

---

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/<your-username>/<repo>.git
cd <repo>
```

### 2. Make Script Executable

```bash
chmod +x scripts/install-docker.sh
```

### 3. Run the Script

```bash
sudo ./scripts/install-docker.sh
```

---

## ⚡ Alternative: Run Without Cloning

```bash
curl -O https://raw.githubusercontent.com/<your-username>/<repo>/main/scripts/install-docker.sh
less install-docker.sh   # inspect before running
sudo bash install-docker.sh
```

---

## ✅ Verify Installation

Check Docker status:

```bash
systemctl status docker
```

Run a test container:

```bash
docker run hello-world
```

If successful, Docker is installed correctly 🎉

---

## 🔧 Optional: Run Docker Without `sudo`

Add your user to the Docker group:

```bash
sudo usermod -aG docker $USER
newgrp docker
```

---

## 🧪 Debugging & Troubleshooting

### ❌ Script fails early

Because the script uses `set -e`, it stops immediately on errors.

👉 Re-run with debug mode:

```bash
bash -x scripts/install-docker.sh
```

This prints each command before execution.

---

### ❌ `permission denied`

Make sure:

```bash
chmod +x scripts/install-docker.sh
```

And run with:

```bash
sudo ./scripts/install-docker.sh
```

---

### ❌ Docker service not starting

Check logs:

```bash
journalctl -u docker --no-pager
```

Try restarting:

```bash
sudo systemctl restart docker
```

---

### ❌ `docker: command not found`

Reload shell:

```bash
exec $SHELL
```

Or log out and back in.

---

### ❌ Network / repo issues

Check if the Docker repo exists:

```bash
cat /etc/apt/sources.list.d/docker.sources
```

Update manually:

```bash
sudo apt update
```

---

### ❌ GPG key issues

Re-fetch key:

```bash
sudo rm -f /etc/apt/keyrings/docker.asc
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```
