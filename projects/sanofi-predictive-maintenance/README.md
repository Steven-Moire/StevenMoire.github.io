---
layout: page
title: "Predictive Maintenance — Industrial Cold Chain"
permalink: /projects/predictive-maintenance/
---

# 🟢 Predictive Maintenance — Industrial Cold Chain
**International pharmaceutical group · CAC 40 · Real-time anomaly detection**

![Status](https://img.shields.io/badge/Status-Production-brightgreen?style=flat-square)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)
![Scikit-learn](https://img.shields.io/badge/Scikit--learn-F7931E?style=flat-square&logo=scikit-learn&logoColor=white)
![MLflow](https://img.shields.io/badge/MLflow-0194E2?style=flat-square&logo=mlflow&logoColor=white)
![Grafana](https://img.shields.io/badge/Grafana-F46800?style=flat-square&logo=grafana&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

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

The full MLOps instrumentation ensures that model degradation (drift in equipment behavior over time or after maintenance) is detected automatically — not discovered retrospectively after a missed alert.
