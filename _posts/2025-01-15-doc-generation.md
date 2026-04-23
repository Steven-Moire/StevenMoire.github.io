---
layout: post
title: "AI Document Generation Pipeline"
date: 2025-01-15 09:00:00 +0100
categories: [Projet_Data, Professionnel]
tags: [Python, FastAPI, Docker, Kubernetes, LLM, CI-CD, Microservices, Scraping, GxP, Rigueur, Itération, Communication]
permalink: /projects/doc-generation/
---

# 🟢 AI Document Generation Pipeline
**International pharmaceutical group · CAC 40 · On-premise regulated environment**

> Source code is confidential (regulated industrial environment). This document covers architecture, methodology, and results.

---

## Context

An industrial pharmaceutical site (~60 employees) needed to transform complex DOCX documents into structured Excel tables — a process previously done manually and prone to inconsistency. The hard constraint: **all processing had to happen on an internal AI platform with zero external data exposure** (GxP compliance, no cloud, no external LLM calls).

The project was built, deployed, and iterated in production over several months, with real business teams as end users from day one.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        INPUT                                │
│              DOCX files (authenticated source)              │
└──────────────────────────┬──────────────────────────────────┘
                           │  Scraping + cookie-based auth
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                   PREPROCESSING SERVICE                     │
│         Extract structure · Clean content · Chunk           │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                  INTERNAL LLM (on-premise)                  │
│         Structured extraction · Table generation            │
│              Zero external data exposure                    │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                   POST-PROCESSING                           │
│        Validation · Formatting · Excel generation           │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                        OUTPUT                               │
│              Structured Excel tables                        │
└─────────────────────────────────────────────────────────────┘
```

**Microservices architecture** — each stage is an independent FastAPI service, containerized and orchestrated via Kubernetes with a full CI/CD pipeline.

---

## Stack

| Layer | Technology |
|---|---|
| API | FastAPI (Python) |
| Containerization | Docker · Kubernetes |
| CI/CD | pylint · pytest · SonarQube · ArgoCD |
| LLM | Internal on-premise model (REST interface) |
| Document ingestion | Python scraping with cookie-based authentication |
| Output | openpyxl / Excel generation |

---

## Results

| Metric | Value |
|---|---|
| Performance (before) | 58% |
| Performance (after iterations) | **74%** |
| Gain | **+16 points** |
| Deployment | Production |
| End users | Real business teams, daily use |

The +16-point gain came entirely from structured feedback loops with business users — not from model changes. The prompt architecture and output schema were iterated based on qualitative feedback sessions.

---

## Lessons Learned

**Authenticated scraping in a closed environment** — handling session-based authentication across multiple service restarts required maintaining cookie state in a stateless microservices architecture. Not covered by standard scraping documentation.

**User feedback is a feature** — the jump from 58% to 74% had nothing to do with the LLM. It came from understanding how business users read the output and what "correct" actually meant to them.

**Regulated production is a different discipline** — in a GxP environment, every change to a deployed system triggers a validation cycle. Learning to scope changes tightly — to minimize validation overhead without sacrificing quality — was a key engineering constraint.
