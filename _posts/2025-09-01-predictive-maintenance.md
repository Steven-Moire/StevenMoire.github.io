---
layout: post
title: "Predictive Maintenance — Industrial Cold Chain"
date: 2025-09-01 09:00:00 +0100
categories: [Projet_Data, Professionnel]
tags: [Python, Scikit-learn, MLflow, DVC, FastAPI, Docker, Kubernetes, Grafana, Prometheus, Evidently, Isolation-Forest, GxP, Rigueur, Démarche-scientifique, Autonomie]
permalink: /projects/predictive-maintenance/
---

# 🟢 Predictive Maintenance — Industrial Cold Chain
**International pharmaceutical group · CAC 40 · Real-time anomaly detection**

> Source code is confidential (regulated industrial environment). This document covers architecture, model decisions, and results.

---

## Context

15 industrial thermal enclosures (cold-chain equipment) required continuous monitoring to detect anomalies before equipment failure. In a pharmaceutical environment, cold-chain failures can cause product degradation — the business case for early detection is direct and measurable.

The equipment naturally split into **3 behavioral families** requiring distinct models:
- **CYCLES** — periodic temperature patterns (regular oscillation)
- **FROID** — continuous cold storage (stable low temperature)
- **ISOTHERME** — isothermal stability (minimal variation)

---

## Architecture — Hybrid Rules + ML

```
┌─────────────────────────────────────────────────────────────┐
│           DATA INGESTION (temperature readings)             │
│                  15 thermal enclosures                      │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                    PREPROCESSING                            │
│        Resampling · Feature engineering · Windowing         │
└──────────┬────────────────────────────────┬─────────────────┘
           │                                │
           ▼                                ▼
┌─────────────────────┐      ┌──────────────────────────────┐
│   BUSINESS RULES    │      │     ISOLATION FOREST (ML)    │
│ (domain thresholds) │      │  3 models × 3 equipment      │
│                     │      │  families                    │
└──────────┬──────────┘      └──────────────┬───────────────┘
           │                                │
           └────────────────┬───────────────┘
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                  ANOMALY CLASSIFICATION                     │
│  NORMAL · ANOMALIE_CYCLE · ANOMALIE_INSTABLE                │
│  ANOMALIE_FRANCHE · ML_SUSPECT                              │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│               ALERTING + MONITORING                         │
│          Grafana dashboard · Prometheus metrics             │
└─────────────────────────────────────────────────────────────┘
```

---

## Why Isolation Forest — Not Deep Learning

The dataset contained ~10,000 readings. At that scale, deep learning approaches (LSTM, Autoencoders) carry real risks:

- **Overfitting** — small dataset with inherently rare labeled anomalies
- **Interpretability loss** — in a regulated environment, "the neural network flagged this" is not an acceptable root cause for a maintenance alert
- **Maintenance overhead** — a retrained LSTM requires revalidation; Isolation Forest hyperparameters are stable, auditable, and explainable to non-technical stakeholders

Isolation Forest is statistically well-suited for anomaly detection on tabular data at this scale. It makes no distributional assumptions and naturally handles multivariate temperature signals. The choice was deliberate, documented, and defensible to QA teams.

---

## Stack

| Layer | Technology |
|---|---|
| ML | Scikit-learn · Isolation Forest |
| Experiment tracking | MLflow |
| Data versioning | DVC |
| Monitoring | Grafana · Prometheus |
| Drift detection | Evidently |
| API | FastAPI |
| Infrastructure | Docker · Kubernetes · CI/CD |

---

## Results

| Parameter | Value |
|---|---|
| Equipment monitored | 15 thermal enclosures |
| Behavioral families | 3 (CYCLES, FROID, ISOTHERME) |
| Dataset size | ~10,000 readings |
| Best F1 score | **0.778** |
| Best config | `contamination=0.10` · `max_features=0.5` · `n_estimators=200` |
| Deployment | Production |

---

## MLOps Stack

| Tool | Role |
|---|---|
| **MLflow** | Full experiment tracking, model registry, artifact storage |
| **DVC** | Data and model versioning, reproducible training pipelines |
| **Evidently** | Automated drift detection on incoming temperature distributions |
| **Grafana / Prometheus** | Real-time monitoring, alerting on anomaly rate spikes |
