---
layout: page
title: "COVID X-Ray Classification — MLOps Pipeline"
permalink: /projects/covid-xray/
---

# 🟢 COVID X-Ray Classification — MLOps Pipeline
**Academic project · École Liora · Deep learning + full MLOps infrastructure**

![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=flat-square)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)
![PyTorch](https://img.shields.io/badge/PyTorch-EE4C2C?style=flat-square&logo=pytorch&logoColor=white)
![Keras](https://img.shields.io/badge/Keras-D00000?style=flat-square&logo=keras&logoColor=white)
![Streamlit](https://img.shields.io/badge/Streamlit-FF4B4B?style=flat-square&logo=streamlit&logoColor=white)
![DVC](https://img.shields.io/badge/DVC-945DD6?style=flat-square&logo=dvc&logoColor=white)

> GitHub: [Data-Team-DST/docker_covid](https://github.com/Data-Team-DST/docker_covid) (public)

---

## Context

4-class classification of chest X-rays using deep learning, then industrialized into a production-grade MLOps pipeline with 9 containerized microservices, CI/CD, experiment tracking, and data versioning.

This project started as a data science exercise and was pushed all the way to a deployable, monitored infrastructure — which is the point.

---

## Dataset

| Class | Description |
|---|---|
| COVID-19 | X-rays positive for COVID-19 |
| Lung Opacity | Pulmonary opacity (non-COVID) |
| Normal | Healthy chest X-rays |
| Viral Pneumonia | Viral pneumonia (non-COVID) |

- **Total images:** 42,330
- **Volume:** ~806 MB (tracked via DVC)
- **Source:** Kaggle (public dataset)

---

## ML Pipeline

```
Raw images
    → Preprocessing (normalization, resize)
    → Data augmentation (rotation, flip, zoom)
    → CNN training (Keras / PyTorch)
    → Hyperparameter optimization
    → Grad-CAM interpretability maps
    → Streamlit demo interface
```

---

## MLOps Infrastructure — 9 Containerized Services

```
┌───────────────────────────────────────────────────────────────┐
│                   CLIENT (Streamlit :8501)                    │
└────────────────────────┬──────────────────────────────────────┘
                         │ REST
                         ▼
┌───────────────────────────────────────────────────────────────┐
│               FastAPI Backend (:8000)                         │
│           Keras model inference · predictions                 │
└────┬──────────────────┬──────────────────────┬───────────────┘
     │                  │                      │
     ▼                  ▼                      ▼
┌─────────┐   ┌──────────────────┐   ┌──────────────────┐
│ MLflow  │   │  DVC Service     │   │  MinIO Storage   │
│ (:5000) │   │   (:5001)        │   │   (:9001)        │
└─────────┘   └──────────────────┘   └──────────────────┘
     │
     ▼
┌─────────┐   ┌──────────────────┐
│ Log Svc │   │   Dashboard      │
│ (:5002) │   │   (:5050)        │
└─────────┘   └──────────────────┘
```

---

## Grad-CAM — Interpretability

Grad-CAM generates heatmaps highlighting which regions of the X-ray drove the model's prediction. In a medical imaging context, interpretability is not a nice-to-have — it's the difference between a tool a clinician can interrogate and a black box they won't trust.

The maps let a practitioner verify that the model is "looking at" pathologically relevant zones (lung consolidation, ground-glass opacities) rather than image artifacts or scanner metadata.

---

## Stack

| Layer | Technology |
|---|---|
| Deep Learning | PyTorch · TensorFlow/Keras · OpenCV |
| Interpretability | Grad-CAM |
| Frontend | Streamlit (multi-page) |
| Backend API | FastAPI |
| Experiment tracking | MLflow |
| Data versioning | DVC |
| Object storage | MinIO |
| CI/CD | GitHub Actions · Ruff · Black · isort |
| Infrastructure | Docker · Docker Compose · Kubernetes |

---

## Results

> Detailed metrics (accuracy, F1 per class, confusion matrix) are available in `evaluation_report.json` in the repository.

*[To be updated with final model metrics once available]*

---

## Development Phases

| Phase | Status | Scope |
|---|---|---|
| 1 — Baseline | ✅ Done | Env setup · preprocessing · baseline CNN · FastAPI · unit tests |
| 2 — Tracking | ✅ Done | MLflow · DVC · microservices decomposition |
| 3 — Infrastructure | 🔄 In progress | Kubernetes · full CI/CD · end-to-end orchestration |
| 4 — Monitoring | 📋 Planned | Prometheus · Grafana · Evidently drift detection |
