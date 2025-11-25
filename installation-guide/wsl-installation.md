# 🖥️ Installing WSL on Windows

These are the steps I followed to install and set up WSL with Ubuntu on my Windows machine.

---

## 1. Install WSL
Open **PowerShell as Administrator** and run:

```powershell
wsl --install
```

Restart your computer when prompted.

---

## 2. Set Up Ubuntu
After the reboot, Ubuntu opens automatically.  
Create your Linux username and password when asked.

---

## 3. Verify WSL Version
Run:

```powershell
wsl -l -v
```

You should see Ubuntu listed with **Version 2**.

---
