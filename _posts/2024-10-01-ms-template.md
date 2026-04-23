---
layout: post
title: "ms-template — Reusable Microservices Boilerplate"
date: 2024-10-01 09:00:00 +0100
categories: [Projet_Data, Personnel]
tags: [Python, Flask, Docker, Bash, Architecture-logicielle, SOLID, Débrouillardise, Rigueur, Pédagogie]
permalink: /projects/ms-template/
---

# 🔵 ms-template — Reusable Microservices Boilerplate
**Personal project · Architecture template · Active use**

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

Centralized view of all running services: status, key metrics, aggregated logs.

| Endpoint | Description |
|---|---|
| `GET /` | Dashboard overview |
| `GET /services` | Service registry and health status |
| `GET /logs` | Aggregated log stream |

### `ms-architecture` — SOLID Compliance Checker · Flask · port 5051

Statically analyzes inter-module dependencies in Python projects and flags SOLID violations. Runs as a CI gate.

| Endpoint | Description |
|---|---|
| `POST /analyze` | Analyze a Python module |
| `GET /report` | Last analysis report |

### `ms-logging` — Centralized Logging · port 5052

Dual-write logging: every service writes to the central log service **and** to a local fallback file.

```
Service A ──► ms-logging (central) ──► central log store
         └──► local/service_a.log  ──► local fallback
```

### `ms-scripts` — Bash Utility Scripts

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
               └─────────────────────────────────────────┘
                              ms-scripts/
```

---

## Getting Started

```bash
git clone https://github.com/Steven-Moire/ms-template my-project
cd my-project
rm -rf .git && git init
docker compose up ms-dashboard ms-logging
```
