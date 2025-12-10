# Advanced PKI Lab on Kali Linux

This project is a hands-on PKI lab designed for Kali Linux (or any Debian-like system).  
It demonstrates:

- Root CA and Intermediate/Sub CA hierarchy
- Server, client, and mTLS certificates with SAN & Key Usage
- CRL-based revocation
- mTLS with Nginx
- Certificate rotation (renewal)
- Clean, reproducible Bash scripts

> Perfect as a portfolio project for roles in Cybersecurity, PKI, IAM, DevSecOps, IoT Security, etc.

---

## 🧩 Architecture

```text
Root CA (offline/secure)
   └── Intermediate/Sub CA
          ├── Server certificates (HTTPS / mTLS)
          ├── Client certificates (mTLS)
          └── CRL (revocation list)
All PKI artifacts are stored under ~/pki-lab:
~/pki-lab/
  ├── root/
  └── sub/
🛠 Prerequisites
sudo apt update
sudo apt install openssl nginx curl -y
🚀 Quickstar

cd scripts

# 1) Prepare directory structure
./01_init_env.sh

# 2) Create Root CA
./02_create_root_ca.sh

# 3) Create Sub / Intermediate CA
./03_create_sub_ca.sh

# 4) Issue server certificate
./04_issue_server_cert.sh

# 5) Issue client certificate
./05_issue_client_cert.sh

# 6) Configure Nginx for mTLS and start it
sudo ./06_setup_nginx_mtls.sh

Revocation & Rotation

Revoke the client certificate and generate a CRL:

./07_revoke_client_cert.sh
sudo systemctl restart nginx


Rotate/renew the server certificate:./08_rotate_server_cert.sh
sudo systemctl restart nginx

Files overview

config/openssl-root.cnf – OpenSSL config for the Root CA

config/openssl-sub.cnf – OpenSSL config for the Sub/Intermediate CA

scripts/*.sh – Automation scripts for each step

nginx/default.conf.example – Nginx site configuration with mTLS

Disclaimer

This lab is for educational purposes only and must not be used as-is for production PKI.
It is intended to demonstrate concepts of PKI, certificate lifecycle and mTLS.

