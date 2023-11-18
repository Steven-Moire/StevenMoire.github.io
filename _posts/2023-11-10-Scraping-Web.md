---
layout: post
title: Scraping Web
date: 2023-11-10 9:00:00 +0300
categories: [Projet_Data, Ecole]
tags: [HTML, Python, Scraping_WEB, CSV]
---

# Scraping Web pour créer un Clone de Waalaxy

## Introduction

Pour notre deuxième projet, notre professionnel enseignant a décidé de nous plonger dans le monde du scraping web en nous donnant pour mission de créer un clone de Waalaxy. Ce projet revêt une importance particulière, car plus de la moitié d'entre nous recherche activement une alternance.

## Description de Waalaxy

Avant de plonger dans le projet, définissons brièvement ce qu'est Waalaxy.

## Problématique 

Comment intégrer efficacement le Scraping Web, le Stockage de Données, et les Requêtes SQL pour créer un système cohérent et utilisable dans un Projet de Clone de Waalaxy ?

## Étapes Principales du Projet

Le professionnel nous a guidés à travers les étapes clés du projet, qui sont les suivantes :

1. **Scraping Web avec Beautiful Soup**
   - Comprendre les bases du scraping web.
   - Utiliser Beautiful Soup pour extraire les données nécessaires.

2. **Stockage des Données dans un Fichier CSV**
   - Organiser le scrap dans un fichier CSV pour une manipulation ultérieure.

3. **Création d'une Base de Données pour le Scrap**
   - Établir une base de données capable de stocker nos données scrapées.

4. **Requêtes SQL pour l'Utilisateur**
   - Développer des requêtes SQL permettant aux utilisateurs d'obtenir les informations souhaitées.

## Début du projet, apprentissage préliminaire

Au début du projet, une après-midi a été consacrée à la compréhension du scraping web, de l'HTML, de Python et au démarrage du processus de scraping. Nous nous sommes appuyés sur un ensemble de vidéos pour acquérir les connaissances nécessaires, et le professionnel nous a partagé un tutoriel détaillé lors de la deuxième journée de travail.

## Code Python pour le Scraping de JobbyJobba

Le professionnel nous a guidés à travers un exemple concret en nous fournissant un tutoriel pas à pas pour scraper le site JobbyJobba. Voici un extrait du code Python que j'ai développé :

```python
import requests
import re
from bs4 import BeautifulSoup
import csv

headers = {'User-Agent': "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246"}
URL = "https://www.jobijoba.com/fr/query/?what=Data+analyst"

r = requests.get(url=URL, headers=headers)

quotes = []

soup = BeautifulSoup(r.content, 'html5lib')
table = soup.find('div', attrs = {'class':'right-column col-12 col-lg-8'})

all_quotes = []
all_quotes = table.findAll('div', attrs = {'class':'offer'})

index = 0
for row in all_quotes:
    quote = {}
    quote['offer'] = row.h3.text
    quote['url'] = row.a['href']
    quote['date_parution'] = row.find('span', class_='text-primary publication_date').get_text(strip=True)
    quote['ville'] = row.find('span', class_='icon-map-marker').find_previous('span', class_='feature').get_text(strip=True) if row.find('span', class_='icon-map-marker') else "pas-de-donnée"
    quotes.append(quote)
    index += 1

filename = 'jobijoba.csv'

with open(filename, 'w', newline='') as f:
    w = csv.DictWriter(f,['offer','url','date_parution','ville'])
    w.writeheader()
    for quote in quotes:
        w.writerow(quote)
```

                                          [EN CONSTRUCTION / PROJET EN COURS]