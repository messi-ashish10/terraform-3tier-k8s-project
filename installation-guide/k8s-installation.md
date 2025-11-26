# ☸️ Kubernetes Tools Installation Guide (kubectl, Minikube, Helm)

This file contains everything I used to install the core Kubernetes tools inside **WSL2 (Ubuntu 22.04)**:  
- kubectl  
- Minikube  
- Helm  

---

# 1. Install kubectl

## Step 1: Download kubectl
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
```

## Step 2: Make it executable
```bash
chmod +x kubectl
```

## Step 3: Move it to /usr/local/bin
```bash
sudo mv kubectl /usr/local/bin/kubectl
```

## Step 4: Verify installation
```bash
kubectl version --client
```

---

# 2. Install Minikube

## Step 1: Download Minikube
```bash
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
```

## Step 2: Install it
```bash
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

## Step 3: Verify Minikube
```bash
minikube version
```

## Step 4: Start Minikube
```bash
minikube start --driver=docker
```

## Step 5: Stop Minikube
```bash
minikube stop
```


---

# 3. Install Helm

## Step 1: Install Helm script
```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

## Step 2: Verify Helm
```bash
helm version
```


---
