# USER_DOC — User Documentation

## 🏁 Introduction

This document explains, in simple terms, how an end user or administrator can start, access, and manage the Inception project stack. No technical expertise is required.

---

## ⭐ What Services Does the Stack Provide?

Your infrastructure includes **three main services**, each running inside its own Docker container:

### **1. Nginx**

* Acts as a secure reverse proxy
* Serves WordPress over **HTTPS (port 443)**

### **2. WordPress (PHP-FPM)**

* The actual website and CMS
* Includes admin dashboard for managing content

### **3. MariaDB**

* Database storing all WordPress data (posts, users, settings…)

All services run automatically and communicate through a private Docker network.

---

## 🚀 Starting and Stopping the Project

All interactions are done using the **Makefile**.

### ▶️ **Start the full stack**

```sh
make up
```

* Builds missing images
* Starts all containers
* Initializes WordPress on first launch

### ⏹️ **Stop all services**

```sh
make down
```

* Stops all containers without deleting data

### ❌ **Reset everything (including volumes)**

```sh
make fclean
```

> ⚠️ This will erase your WordPress site and database.

### 🔄 Full rebuild

```sh
make re
```

---

## 🌐 Accessing the Website

Once the stack is running, open your browser and go to:

```
https://agaougao.42.fr
```

This is your public WordPress website.

---

## 🔑 Accessing the WordPress Admin Panel

The admin dashboard (back-office) is located at:

```
https://agaougao.42.fr/wp-admin
```

Enter the credentials defined in your **.env** file:

* `WORDPRESS_ADMIN_USER`
* `WORDPRESS_ADMIN_PASS`

> If login fails, double‑check your `.env` file values.

---

## 🔐 Where Are Credentials Stored?

All credentials are located in your **.env** file at the project root.

Typical credentials include:

* `MYSQL_DATABASE`
* `MYSQL_USER`
* `MYSQL_PASSWORD`
* `WORDPRESS_ADMIN_USER`
* `WORDPRESS_ADMIN_PASS`
* `WORDPRESS_USER`

> ⚠️ Never commit your `.env` file to GitHub.

---

## 🩺 Checking That Services Are Running

Use Docker commands to check container status.

### **List all running containers**

```sh
docker ps
```

You should see:

* `nginx`
* `wordpress`
* `mariadb`

### **Check logs for a specific service**

```sh
docker logs nginx
```

(or wordpress, mariadb)

### **Check WordPress is responding**

Open:

```
https://agaougao.42.fr/wp-admin
```

If you see the login page, everything is working.

---

## 📂 Where is the Data Stored?

Two persistent Docker volumes store your site and database:

* `wordpress_data` → WordPress files
* `mariadb_data` → Database files

These volumes survive:

* `docker compose down`
* Container rebuilds

They only disappear if you run **make fclean**.

---

## ✔️ Summary

| What you want to do | Command or URL                   |
| ------------------- | -------------------------------- |
| Start the stack     | `make up`                        |
| Stop the stack      | `make down`                      |
| Rebuild everything  | `make re`                        |
| Wipe everything     | `make fclean`                    |
| Check containers    | `docker ps`                      |
| View container logs | `docker logs <name>`             |

