# 🖥️ Connecting WSL with VS Code

This file explains the steps I followed to connect my WSL (Ubuntu) environment with Visual Studio Code.

---

## 1. Install VS Code on Windows
Download and install Visual Studio Code from:

https://code.visualstudio.com/

---

## 2. Install the "Remote - WSL" Extension
In VS Code, go to **Extensions** → search for:

```
Remote - WSL
```

Install the extension.

This allows VS Code to open folders directly from WSL.

---

## 3. Open VS Code from WSL Terminal
Inside your Ubuntu terminal, go to any folder you want, for example:

```bash
cd ~
```

Then run:

```bash
code .
```

This opens VS Code connected to your WSL environment.

---

## 4. Verify the Connection
When VS Code opens, check the bottom-left corner.  
It should display:

```
WSL: Ubuntu
```

This means VS Code is fully connected to WSL.

---

## 5. Use the VS Code Terminal
Press:

```
Ctrl + Shift + `
```

The terminal that opens will be running inside WSL, not Windows.

You can confirm this using:

```bash
lsb_release -a
```

---
