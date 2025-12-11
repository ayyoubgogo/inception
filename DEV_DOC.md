# DEV_DOC — Developer Documentation

## 🧰 Introduction

This document is intended for developers who need to understand, maintain, or extend the Inception project. It explains how to set up the environment from scratch, build the Docker images, manage the stack, and understand where all persistent data is stored.

---

# ⚙️ 1. Environment Setup

## 📦 Prerequisites

Before running the project, ensure the following tools are installed on your system:

* **Docker** (latest stable version)
* **Docker Compose** (v2+)
* **Make** (GNU Make)
* A Unix-like terminal (Linux or macOS)

---

## 📁 Required Files

At the root of the repository, you must have:

* `docker-compose.yml`
* `Makefile`
* `.env` — your environment variables
* `/requirements` — directory containing Nginx, WordPress, and MariaDB
* `README.md`, `USER_DOC.md`, `DEV_DOC.md`

---

## 🔐 .env File (Secrets & Config)

The `.env` file contains all variables needed by the containers, such as:

* Database credentials
* WordPress admin credentials
* Domain name

Example:

```env
MYSQL_DATABASE=wordpress
MYSQL_USER=user
MYSQL_PASSWORD=pass
MYSQL_ROOT_PASSWORD=rootpass
WORDPRESS_ADMIN_USER=admin
WORDPRESS_ADMIN_PASS=adminpass
DOMAINE=yourdomain.com
```

> ⚠️ Never push this file to Git.

---

# 🛠️ 2. Build & Launch the Project

The full project is controlled using the **Makefile**.

## ▶️ Build and Start All Containers

```sh
make up
```

This will:

* Build the three custom Docker images (nginx, wordpress, mariadb)
* Create and start all containers
* Initialize WordPress automatically

---

## ⏹️ Stop All Containers

```sh
make down
```

Stops the infrastructure without deleting volumes.

---

## 🔄 Rebuild the Full Stack

```sh
make re
```

Equivalent to `down` + rebuild + `up`.

---

## ❌ Remove All Containers, Images, Volumes

```sh
make fclean
```

> ⚠️ This deletes all persistent data.

---

# 🐳 3. Useful Docker Commands

## View Running Containers

```sh
docker ps
```

## View All Containers (including stopped)

```sh
docker ps -a
```

## View Logs

```sh
docker logs wordpress
```

(or nginx, mariadb)

## Access a Container Shell

```sh
docker exec -it mariadb bash
```

or:

```sh
docker exec -it wordpress sh
```

---

# 🗄️ 4. Managing Docker Volumes

Two volumes store your persistent data:

* **mariadb_data** → MariaDB database files
* **wordpress_data** → WordPress files/uploads

## List Volumes

```sh
docker volume ls
```

## Inspect a Volume

```sh
docker volume inspect mariadb_data
```

## Delete All Volumes

(Handled by `make fclean`)

---

# 🌐 5. Project Architecture (Technical Overview)

## Services

### **MariaDB Container**

* Custom image built from `/requirements/mariadb`
* Initializes database, users, privileges
* Stores data in `mariadb_data`

### **WordPress Container**

* Runs PHP-FPM on port 9000
* Automatically downloads and configures WordPress via WP-CLI
* Stores site files in `wordpress_data`

### **Nginx Container**

* HTTPS reverse proxy
* Serves WordPress using PHP-FPM upstream
* Uses a self-signed SSL certificate

---

# 🔌 6. Networking

The stack uses a **custom bridge network** defined in docker-compose:

* Each container can communicate using its hostname
* External access is allowed only through Nginx (port 443)

---

# 💾 7. Data Persistence

## What data persists?

* WordPress uploads & core files → inside `wordpress_data`
* MariaDB database → inside `mariadb_data`

## What does *not* persist?

* Containers
* Images (unless custom tagged)
* Logs
* Cache files

This ensures your website survives restarts, rebuilds, and crashes.

---

# 🧪 8. Debugging Tips

### WordPress not loading?

* Check Nginx container logs
* Ensure WordPress container is running
* Verify that `php-fpm` is listening on port 9000

### Database connection error?

* Check MariaDB logs
* Ensure `MYSQL_*` environment variables match

### SSL issues?

* Ensure certificate paths match in nginx config
* Confirm port 443 is exposed

---

# ✔️ Summary

This document covered:

* Environment setup
* Running & managing the stack
* Docker commands for debugging
* Network architecture
* Persistent data handling