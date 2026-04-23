---
layout: page
title: "Nutrition App — Meal Planning"
permalink: /projects/nutrition-app/
---

# 🟡 Nutrition App — Meal Planning & Nutritional Tracking
**Personal project · Flask prototype · In development**

![Status](https://img.shields.io/badge/Status-Prototype-yellow?style=flat-square)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)
![Flask](https://img.shields.io/badge/Flask-000000?style=flat-square&logo=flask&logoColor=white)

---

## Context

A personal project built from a practical need: planning meals for the week, tracking nutritional intake without an app that sells your data, and building on a real reference dataset (CIQUAL — the French national food composition database published by ANSES).

The stack is deliberately simple — Flask backend and frontend. The point is the data model and the planning logic, not the framework.

---

## Features

| Feature | Status |
|---|---|
| CIQUAL ingredient database (345 items · full nutritional values) | ✅ Implemented |
| Recipe library (64 historical recipes encoded in JSON) | ✅ Implemented |
| Weekly batch cooking planner | 🔄 In progress |
| Per-meal nutritional tracking | 🔄 In progress |
| Shopping list generation | 📋 Planned |

---

## Data Model

```
Ingredient
  ├── id (CIQUAL code)
  ├── name
  ├── calories  (kcal / 100g)
  ├── proteins  (g / 100g)
  ├── carbs     (g / 100g)
  ├── fat       (g / 100g)
  └── fiber     (g / 100g)

Recipe
  ├── id
  ├── name
  ├── ingredients: [{ ingredient_id, quantity_g }]
  └── computed_nutritional_profile  (derived on load)

MealPlan
  ├── week
  ├── days: { monday: [recipe_id, ...], tuesday: [...], ... }
  └── weekly_nutritional_summary    (aggregated)
```

---

## Stack

| Layer | Technology |
|---|---|
| Backend | Flask (Python) |
| Frontend | Jinja2 templates |
| Data | CIQUAL JSON · Recipe JSON (64 recipes) |

---

> *README to be expanded once the batch cooking and meal tracking features reach stable state.*
