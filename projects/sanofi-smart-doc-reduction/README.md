---
layout: page
title: "Smart Doc Reduction — GxP RAG Pipeline"
permalink: /projects/smart-doc-reduction/
---

# 🟢 Smart Doc Reduction — GxP Document RAG Pipeline
**International pharmaceutical group · CAC 40 · On-premise NLP in a closed network**

![Status](https://img.shields.io/badge/Status-Production-brightgreen?style=flat-square)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)
![HuggingFace](https://img.shields.io/badge/HuggingFace-FFD21E?style=flat-square&logo=huggingface&logoColor=black)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)

> Source code is confidential (regulated industrial environment). This document covers pipeline architecture and technical decisions.

---

## Context

A regulated industrial site had accumulated ~500 Standard Operating Procedures (SOPs) and Work Instructions (WINs) across multiple GxP document management systems. Over time, documents had diverged, duplicated, and become inconsistent — both a compliance risk and a maintenance burden.

**Objective:** identify redundant documents, surface clusters of similar procedures, and generate a rationalization proposal that quality teams could act on.

**The hard constraint: 100% on-premise.** No document could leave the closed network. Every model had to run on local infrastructure — no OpenAI API, no HuggingFace Inference Endpoints, no external calls of any kind.

Running a full RAG pipeline under these constraints is uncommon engineering.

---

## Architecture — On-Premise RAG Pipeline

```
┌─────────────────────────────────────────────────────────────┐
│            SOURCE DOCUMENTS (~500 SOPs & WINs)              │
│       GxP document management systems (extraction)          │
└──────────────────────────┬──────────────────────────────────┘
                           │  PDF / DOCX extraction
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                    TEXT PREPROCESSING                       │
│        Chunking · Cleaning · Language normalization         │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│              MULTILINGUAL EMBEDDINGS                        │
│      intfloat/multilingual-e5-large (local inference)       │
│           All models run on-premise — no API calls          │
└──────────────────────────┬──────────────────────────────────┘
                           │  Vector similarity matrix
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                  HDBSCAN CLUSTERING                         │
│     Density-based · No fixed k · Handles noise natively     │
│     Discovers natural document clusters automatically       │
└──────────────────────────┬──────────────────────────────────┘
                           │  Cluster summaries
                           ▼
┌─────────────────────────────────────────────────────────────┐
│             LLM SYNTHESIS (Mistral 7B Instruct)             │
│    Quantized · Local inference · Rationalization report     │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                     OUTPUT REPORT                           │
│    Cluster map · Duplicate candidates · Merge proposals     │
└─────────────────────────────────────────────────────────────┘
```

---

## Technical Decisions

### Why HDBSCAN over K-Means

K-Means requires you to specify `k` — the number of clusters — upfront. In a document rationalization context, the number of meaningful topic groups is unknown and should emerge from the data, not be imposed on it.

HDBSCAN:
- Discovers clusters of arbitrary shape and density
- Explicitly marks outliers (noise) rather than forcing them into a cluster
- Scales well to embedding spaces with ~500 documents
- Requires no assumption about the number of procedure families

K-Means would have imposed a structure. HDBSCAN let the corpus reveal its own.

### Why `multilingual-e5-large`

The document corpus mixed French technical procedures with English standards (ISO references, supplier specifications). A monolingual embedding model would have failed to cluster semantically similar content written in different languages. `multilingual-e5-large` is state-of-the-art for cross-lingual semantic similarity and runs efficiently on a standard local GPU.

### Why Mistral 7B Instruct (quantized)

Generating a rationalization report requires language — not just similarity scores. Mistral 7B in 4-bit quantization fits comfortably in the available local GPU memory while producing coherent, structured synthesis. The quantization tradeoff (minor quality degradation vs. feasibility on local hardware) was the right call given the infrastructure constraint.

---

## Stack

| Layer | Technology |
|---|---|
| Embeddings | `intfloat/multilingual-e5-large` (local HuggingFace inference) |
| Clustering | HDBSCAN |
| LLM synthesis | Mistral 7B Instruct (quantized, local) |
| Document extraction | Python (PDF/DOCX parsing) |
| API | FastAPI |
| Infrastructure | Docker |

---

## GxP Compliance & On-Premise Constraints

- **Zero data exfiltration** — all models run on local GPU infrastructure, no document ever left the network
- **Audit trail** — every extraction, embedding, and classification step is logged for compliance traceability
- **Validated environment** — pipeline changes required a qualification cycle before deployment

This is one of the rare cases where a full RAG pipeline (embedding → clustering → LLM synthesis) operates entirely in a closed, regulated environment. The engineering constraints forced real optimization decisions that a cloud-first approach would never surface.
