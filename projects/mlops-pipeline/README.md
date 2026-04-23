---
layout: page
title: "MLOps Pipeline — Full Stack from Scratch"
permalink: /projects/mlops-pipeline/
---

# 🟡 MLOps Pipeline — Full Stack from Scratch
**Personal project · Structured self-training · Work in Progress**

![Status](https://img.shields.io/badge/Status-Phase%203%2F4-yellow?style=flat-square)
![WIP](https://img.shields.io/badge/WIP-In%20Progress-orange?style=flat-square)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=flat-square&logo=fastapi&logoColor=white)
![MLflow](https://img.shields.io/badge/MLflow-0194E2?style=flat-square&logo=mlflow&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=flat-square&logo=kubernetes&logoColor=white)

---

## Why This Project

MLOps is not a tool — it's a discipline. The best way to understand it is to build the full stack from scratch, making real engineering decisions at each layer rather than following a tutorial that makes them for you.

This project is structured self-training: starting from a data science notebook, building layer by layer toward a fully monitored, drift-detecting, production-grade system. Each phase introduces the complexity that gets glossed over in courses.

---

## Roadmap

| Phase | Status | Goal | Key Tools |
|---|---|---|---|
| **1 — Baseline** | ✅ Done | Reproducible env · preprocessing · ML model · FastAPI · unit tests | FastAPI · pytest · venv |
| **2 — Tracking** | ✅ Done | Experiment tracking · data versioning · microservices split | MLflow · DVC |
| **3 — Infrastructure** | 🔄 In Progress | Containerization · Kubernetes · end-to-end CI/CD | Docker · K8s · GitHub Actions |
| **4 — Monitoring** | 📋 Planned | Drift detection · real-time metrics · automated model updates | Evidently · Prometheus · Grafana |

---

## Target Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                          CI/CD PIPELINE                         │
│          GitHub Actions · Ruff · pytest · SonarQube             │
└──────────────────────────┬──────────────────────────────────────┘
                           │ on merge to main
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│                      KUBERNETES CLUSTER                         │
│                                                                 │
│  ┌─────────────────┐  ┌──────────────┐  ┌──────────────────┐  │
│  │   FastAPI API   │  │  ML Service  │  │   Data Service   │  │
│  │    (:8000)      │  │  (inference) │  │  (DVC + MinIO)   │  │
│  └─────────────────┘  └──────────────┘  └──────────────────┘  │
│                                                                 │
│  ┌─────────────────┐  ┌──────────────┐  ┌──────────────────┐  │
│  │     MLflow      │  │   Evidently  │  │  Prometheus      │  │
│  │   (tracking)    │  │   (drift)    │  │  + Grafana       │  │
│  └─────────────────┘  └──────────────┘  └──────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

---

## What Each Phase Actually Teaches

**Phase 1 → 2:** the gap between "it runs on my machine" and "it's trackable and reproducible by anyone on the team."

**Phase 2 → 3:** the gap between "it's reproducible" and "it deploys reliably in any environment."

**Phase 3 → 4:** the gap between "it's deployed" and "we know when it starts to degrade."

Each transition is a real engineering problem. The point of this project is to hit each wall deliberately, understand why it exists, and engineer through it.

---

## Stack

| Layer | Technology |
|---|---|
| ML | Scikit-learn (baseline) |
| Experiment tracking | MLflow |
| Data versioning | DVC |
| API | FastAPI |
| Containerization | Docker · Kubernetes |
| CI/CD | GitHub Actions |
| Monitoring | Prometheus · Grafana *(Phase 4)* |
| Drift detection | Evidently *(Phase 4)* |
