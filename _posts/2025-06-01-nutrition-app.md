---
layout: post
title: "Nutrition App — Meal Planning & Nutritional Tracking"
date: 2025-06-01 09:00:00 +0100
categories: [Projet_Data, Personnel]
tags: [Python, Flask, JSON, CIQUAL, Débrouillardise, Auto-formation]
permalink: /projects/nutrition-app/
---

# 🟡 Nutrition App — Meal Planning & Nutritional Tracking
**Personal project · Flask prototype · In development**

---

## Context

A personal project built from a practical need: planning meals for the week, tracking nutritional intake without an app that sells your data, and building on a real reference dataset (CIQUAL — the French national food composition database published by ANSES).

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
  └── computed_nutritional_profile

MealPlan
  ├── week
  ├── days: { monday: [recipe_id, ...], ... }
  └── weekly_nutritional_summary
```

---

## Stack

| Layer | Technology |
|---|---|
| Backend | Flask (Python) |
| Frontend | Jinja2 templates |
| Data | CIQUAL JSON · Recipe JSON (64 recipes) |
