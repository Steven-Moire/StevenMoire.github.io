---
layout: post
title: "Développer une plateforme d’E-learning gamifiée"
date: 2023-10-19 09:00:00 +0300
categories:
  - Projet
  - Data
  - Ecole
tags:
  - Développement WEB
---

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>PDF Viewer</title>
  <!-- Ajoute le lien vers le fichier PDF.js -->
  <script type="text/javascript" src="https://mozilla.github.io/pdf.js/build/pdf.js"></script>
</head>
<body>
  <!-- Crée une balise canvas pour afficher le PDF -->
  <canvas id="pdf-viewer" style="border:1px solid black;"></canvas>

  <script>
    // Définit le chemin vers ton fichier PDF sur Google Drive
    var pdfUrl = "TON_LIEN_GOOGLE_DRIVE";

    // Charge le PDF avec PDF.js
    pdfjsLib.getDocument(pdfUrl).then(function(pdfDoc) {
      // Affiche la première page du PDF
      pdfDoc.getPage(1).then(function(page) {
        var canvas = document.getElementById("pdf-viewer");
        var context = canvas.getContext("2d");

        // Définis la taille du canvas pour correspondre à la taille de la page PDF
        canvas.height = page.view[3];
        canvas.width = page.view[2];

        // Dessine la première page du PDF sur le canvas
        page.render({ canvasContext: context, viewport: page.view });
      });
    });
  </script>
</body>
</html>
