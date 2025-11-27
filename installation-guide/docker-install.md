# 🐳 Docker Installation Guide (WSL2 - Ubuntu)

This file contains all the steps I followed to install Docker inside **WSL2 (Ubuntu 22.04)** on Windows.

---

# 1. Update System Packages

```bash
sudo apt update && sudo apt upgrade -y
```

---

# 2. Install Docker Engine

```bash
sudo apt install docker.io -y
```

---

# 3. Enable Docker Service (WSL)

```bash
sudo service docker start
```

(Optional) To start Docker automatically when a new WSL session opens:

```bash
sudo systemctl enable docker
```

---

# 4. Add User to Docker Group

To run Docker without `sudo`:

```bash
sudo usermod -aG docker $USER
```

Restart your terminal after this step.

---

# 5. Verify Docker Installation

Check Docker version:

```bash
docker --version
```

Run a test container:

```bash
docker run hello-world
```

If it prints a welcome message → Docker is working.

---
