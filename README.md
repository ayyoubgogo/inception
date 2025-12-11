*This project has been created as part of the 42 curriculum by agaougao*

# Inception — README

## 📝 Description

Inception is a system-administration and containerization project. Its goal is to introduce students to container-based infrastructures using **Docker**, and to build a small but complete web stack composed of:

* **Nginx** (HTTPS reverse proxy)
* **WordPress** (PHP-FPM application)
* **MariaDB** (database)

All services run inside **isolated Docker containers** communicating through a dedicated network. No external images are allowed except the base OS images.

This project teaches:

* Building custom Docker images
* Container orchestration with Docker Compose
* Service isolation & networking
* Data persistence using volumes
* Basic web architecture design

---

## 🚀 Instructions

### **1. Compilation / Installation**

The project uses a Makefile to manage the complete stack.

#### **Build the project**

```sh
make
```

#### **Start the containers**

```sh
make up
```

#### **Stop the containers**

```sh
make down
```

#### **Clean volumes and rebuild everything**

```sh
make fclean
make
```

### **2. Accessing the Website**

* Open your browser and go to:

```
https://agaougao.42.fr
```

### **3. WordPress Admin Panel**

Go to:

```
https://agaougao.42.fr/wp-admin
```

Use the admin credentials from your `.env` file.

---

## 📚 Resources

### Docker & Containers

* Docker Documentation — [https://docs.docker.com/](https://docs.docker.com/)
* Docker Compose — [https://docs.docker.com/compose/](https://docs.docker.com/compose/)
* Understanding Volumes — [https://docs.docker.com/storage/volumes/](https://docs.docker.com/storage/volumes/)
* Nginx Docs — [https://nginx.org/en/docs/](https://nginx.org/en/docs/)

### WordPress & PHP-FPM

* WordPress Codex — [https://developer.wordpress.org/](https://developer.wordpress.org/)
* PHP-FPM Pools — [https://www.php.net/manual/en/install.fpm.configuration.php](https://www.php.net/manual/en/install.fpm.configuration.php)

### AI Use Disclosure

Artificial intelligence (ChatGPT) was used to:

* Explain technical concepts (Docker volumes, networks, PHP-FPM, Nginx configuration)
* Help structure documentation and provide examples
* Assist in debugging during development
* Generate readable documentation templates

All final implementations, scripts, and infrastructure decisions were manually validated.

---

# 🧩 Project Description — Design Choices

## 🐳 Use of Docker

Docker is used to isolate services into lightweight containers instead of running everything directly on the host. Each service has:

* its own Dockerfile
* its own container
* its own role

This provides:

* Isolation
* Reproducibility
* Easy deployment
* Maintainability

## 📁 Sources included

The project contains:

* Custom Dockerfiles for each service
* Nginx configuration
* WordPress setup scripts
* MariaDB configuration
* Docker Compose configuration
* A Makefile to orchestrate everything

---

# 🔎 Comparisons (Required by subject)

## 🖥️ **Virtual Machines vs Docker**

| Virtual Machines    | Docker                  |
| ------------------- | ----------------------- |
| Full OS per VM      | Shared host kernel      |
| Heavy (GBs)         | Lightweight (MBs)       |
| Slow startup        | Instant startup         |
| Strong isolation    | Process-level isolation |
| Hard to replicate   | Easy to replicate       |
| More resource usage | Very efficient          |

Docker is preferred here because it is **faster, lighter, and easier to deploy**.

---

## 🔐 **Secrets vs Environment Variables**

| Environment Variables | Secrets               |
| --------------------- | --------------------- |
| Stored in plain text  | Encrypted / protected |
| Easy to use           | More secure           |
| Fine for local dev    | Better for production |
| Visible in container  | Hidden from logs      |

For this educational project, **environment variables in a `.env` file** are used.

---

## 🌐 **Docker Network vs Host Network**

| Docker Network                | Host Network             |
| ----------------------------- | ------------------------ |
| Containers isolated           | Shares host network      |
| Safer                         | Less secure              |
| Named networks                | No isolation             |
| Custom DNS between containers | Must use localhost/ports |

The stack uses a **Docker bridge network** to let containers communicate cleanly.

---

## 💾 **Docker Volumes vs Bind Mounts**

| Docker Volumes      | Bind Mounts                 |
| ------------------- | --------------------------- |
| Managed by Docker   | Direct host path            |
| Safer & cleaner     | Depends on local filesystem |
| Ideal for databases | Convenient for development  |
| Persistent          | Persistent                  |

This project uses **named volumes** because they are stable, portable, and protected.
