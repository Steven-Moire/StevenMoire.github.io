---
layout: page
title: "ms-template — Reusable Microservices Boilerplate"
permalink: /projects/ms-template/
---

# 🔵 ms-template — Reusable Microservices Boilerplate
**Personal project · Architecture template · Active use**

![Status](https://img.shields.io/badge/Status-Template-blue?style=flat-square)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)
![Flask](https://img.shields.io/badge/Flask-000000?style=flat-square&logo=flask&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white)

---

## What This Is

Every new project starts the same way: set up logging, add a dashboard, wire the services together, write the same Bash scripts again. `ms-template` is the answer to that repetition.

```bash
git clone ms-template my-new-project
# Cross-cutting concerns are already wired. Start building domain logic.
```

**Philosophy:** Don't Repeat Yourself at the architecture level. Common infrastructure lives here once. Domain logic lives in the project that clones this. Each service has one responsibility and one reason to change — SOLID applied to the project scaffold, not just to individual classes.

---

## Services

### `ms-dashboard` — Project Dashboard · Flask · port 5050

Centralized view of all running services: status, key metrics, aggregated logs. A development-time project management tool, not a production monitoring tool.

| Endpoint | Description |
|---|---|
| `GET /` | Dashboard overview |
| `GET /services` | Service registry and health status |
| `GET /logs` | Aggregated log stream |

---

### `ms-architecture` — SOLID Compliance Checker · Flask · port 5051

Statically analyzes inter-module dependencies in Python projects and flags violations of SOLID principles — primarily Single Responsibility and Dependency Inversion. Runs as a CI gate.

| Endpoint | Description |
|---|---|
| `POST /analyze` | Analyze a Python module |
| `GET /report` | Last analysis report |

---

### `ms-logging` — Centralized Logging · port 5052

Dual-write logging: every service writes to the central log service **and** to a local fallback file. If the central service goes down, no log is lost.

```
Service A ──► ms-logging (central) ──► central log store
         └──► local/service_a.log  ──► local fallback
```

The resilience is by design: a logging infrastructure that can itself become a point of failure defeats the purpose.

---

### `ms-scripts` — Bash Utility Scripts

Transversal scripts that every project needs, written once:

| Script | What it does |
|---|---|
| `setup_venv.sh` | Virtual environment setup with pinned deps |
| `build_docker.sh` | Standardized Docker build + tag |
| `deploy.sh` | Deployment to target environment |
| `lint.sh` | Ruff + Black + isort in one command |

---

## Architecture

```
┌───────────────────────────────────────────────────────────────┐
│                        YOUR PROJECT                           │
│          (git clone ms-template, add domain services)         │
└─────┬─────────────────┬─────────────────────┬────────────────┘
      │                 │                     │
      ▼                 ▼                     ▼
┌───────────┐   ┌──────────────┐   ┌──────────────────────┐
│ms-dashboard│  │  ms-logging  │   │   ms-architecture    │
│  (:5050)  │   │   (:5052)    │   │      (:5051)         │
└───────────┘   └──────────────┘   └──────────────────────┘
      │                 │
      └────────┬────────┘
               ▼
┌───────────────────────────────────────────────────────────────┐
│                       ms-scripts/                             │
│            setup_venv · build_docker · deploy · lint          │
└───────────────────────────────────────────────────────────────┘
```

---

## Getting Started

```bash
# 1. Clone the template
git clone https://github.com/Steven-Moire/ms-template my-project
cd my-project

# 2. Remove template history, start fresh
rm -rf .git && git init

# 3. Start cross-cutting services
docker compose up ms-dashboard ms-logging

# 4. Build your domain services on top
# Point LOG_SERVICE_URL=http://ms-logging:5052 in your service env
# Register in ms-dashboard/registry.json with name and port
# Your service appears in the dashboard automatically
```

---

## Adding a New Service

1. Create `my-service/` with a Flask or FastAPI app
2. Set `LOG_SERVICE_URL` env var → logs go to `ms-logging` automatically
3. Add an entry to `ms-dashboard/registry.json` (name, port, health endpoint)
4. Add a `docker-compose` service block
5. Done — no changes to the template services required
