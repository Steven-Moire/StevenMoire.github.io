---
layout: post
title: Script VBA
date: 2023-11-03 9:00:00 +0300
categories: [Projet_Data, Personnel]
tags: [Excel, VBA, Création_de_visuel_adapté, Questionnaire]
---

# Introduction

Pour notre deuxième projet data, nous avions initialement envisagé une approche Lean Business avec pour sujet le gaspillage alimentaire. Cependant, au fil de notre progression, nous avons choisi une orientation différente. Dans cette présentation, je vous invite à découvrir ce que j'avais préalablement concrétisé.

# Problématique

L'efficacité étant ma priorité, j'ai mis en place un questionnaire afin de recueillir des données pertinentes. Pour éviter des réponses trop simplistes, j'ai permis aux participants de moduler leurs réponses, allant du "pas du tout" à "énormément". Ces données, bien que riches, étaient sous forme de texte, ce qui compliquait leur utilisation.

Le besoin s'est alors fait ressentir de transformer ces réponses en données numériques pour une analyse plus précise. J'ai opté pour l'attribution de notes de 0 à 4 en fonction des réponses, facilitant ainsi le calcul de moyennes par question.

# Méthodologie

Face à la volumétrie des données, j'ai développé un script VBA dans Excel pour automatiser cette conversion. Initialement, le script ne répondait pas entièrement à mes attentes, notamment en termes de gestion du nombre de lignes.



Ci-dessous, vous trouverez une courte vidéo montrant le script en fonctionnement:

<iframe width="100%" height="600px" src="https://www.youtube.com/embed/m_pqsI5dJKA" frameborder="0" allowfullscreen></iframe>

Voici un document permettant l'utilisation du script:

<iframe src="https://drive.google.com/file/d/1j_y38dIXWFhNJ9uqTblYzGKxkLdNEcneJoHR9gDof6Y/preview" width="100%" height="600px"></iframe>

Vous découvrirez ci-après le script VBA que j'ai adapté et utilisé :

```vba
function main(workbook: ExcelScript.Workbook) {
	let selectedSheet = workbook.getActiveWorksheet();
	// Delete range A:A on selectedSheet
	selectedSheet.getRange("A:A").delete(ExcelScript.DeleteShiftDirection.left);
	// Replace "beaucoup" with "3" on selectedSheet
	selectedSheet.replaceAll("beaucoup", "3", { completeMatch: false, matchCase: false });
	// Replace "Enormément" with "4" on selectedSheet
	selectedSheet.replaceAll("Enormément", "4", { completeMatch: false, matchCase: false });
	// Replace "Moyennement" with "2" on selectedSheet
	selectedSheet.replaceAll("Moyennement", "2", { completeMatch: false, matchCase: false });
	// Replace "Légèrement" with "1" on selectedSheet
	selectedSheet.replaceAll("Légèrement", "1", { completeMatch: false, matchCase: false });
	// Replace "Pas du tout" with "0" on selectedSheet
	selectedSheet.replaceAll("Pas du tout", "0", { completeMatch: false, matchCase: false });
	// Set range J8 on selectedSheet
	selectedSheet.getRange("J8").setFormulaLocal("=AVERAGE(A2:A100)");
	// Auto fill range
	selectedSheet.getRange("J8").autoFill("J8:Q8", ExcelScript.AutoFillType.fillDefault);
	// Set format for range 8:8 on selectedSheet
	selectedSheet.getRange("J8:Q8").setNumberFormatLocal("0.00");
	// Set range A1 on selectedSheet
	selectedSheet.getRange("A1").setValue("Vous préoccupez-vous du gaspillage alimentaire ?");
	// Replace "Vous préoccupez-vous du gaspillage alimentaire ?" with "gaspillage alimentaire" on selectedSheet
	selectedSheet.replaceAll("Vous préoccupez-vous du gaspillage alimentaire ?", "gaspillage alimentaire", { completeMatch: false, matchCase: false });
	// Set range B1 on selectedSheet
	selectedSheet.getRange("B1").setValue("Vous préoccupez-vous du gaspillage énergétique?");
	// Replace all "Vous préoccupez-vous du gaspillage énergétique?" with "gaspillage énergétique" on range B1 on selectedSheet
	selectedSheet.getRange("B1").replaceAll("Vous préoccupez-vous du gaspillage énergétique?", "gaspillage énergétique", { completeMatch: false, matchCase: false });
	// This action currently can't be recorded.
	// Set range C1 on selectedSheet
	selectedSheet.getRange("C1").setValue("Vous préoccupez-vous du gaspillage électronique ?");
	// Replace all "Vous préoccupez-vous du gaspillage électronique ?" with "gaspillage électronique" on range A1 on selectedSheet
	selectedSheet.getRange("A1").replaceAll("Vous préoccupez-vous du gaspillage électronique ?", "gaspillage électronique", { completeMatch: false, matchCase: false });
	// Replace "Vous préoccupez-vous du gaspillage électronique ?" with "gaspillage électronique" on selectedSheet
	selectedSheet.replaceAll("Vous préoccupez-vous du gaspillage électronique ?", "gaspillage électronique", { completeMatch: false, matchCase: false });
	// Set range D1 on selectedSheet
	selectedSheet.getRange("D1").setValue("Vous préoccupez-vous du gaspillage plastique / sur - emballage ?");
	// Replace "Vous préoccupez-vous du gaspillage plastique / sur - emballage ?" with "gaspillage plastique" on selectedSheet
	selectedSheet.replaceAll("Vous préoccupez-vous du gaspillage plastique / sur - emballage ?", "gaspillage plastique", { completeMatch: false, matchCase: false });
	// Set range E1 on selectedSheet
	selectedSheet.getRange("E1").setValue("Vous préoccupez-vous du gaspillage de l'eau ?");
	// Replace "Vous préoccupez-vous du gaspillage de l'eau ?" with "gaspillage d'eau" on selectedSheet
	selectedSheet.replaceAll("Vous préoccupez-vous du gaspillage de l'eau ?", "gaspillage d'eau", { completeMatch: false, matchCase: false });
	// Auto fit the columns of range A:A on selectedSheet
	selectedSheet.getRange("A:A").getFormat().autofitColumns();
	// Auto fit the columns of range B:B on selectedSheet
	selectedSheet.getRange("B:B").getFormat().autofitColumns();
	// Auto fit the columns of range C:C on selectedSheet
	selectedSheet.getRange("C:C").getFormat().autofitColumns();
	// Auto fit the columns of range D:D on selectedSheet
	selectedSheet.getRange("D:D").getFormat().autofitColumns();
	// Auto fit the columns of range E:E on selectedSheet
	selectedSheet.getRange("E:E").getFormat().autofitColumns();
	// Set range F1 on selectedSheet
	selectedSheet.getRange("F1").setValue("Vous préoccupez-vous du gaspillage de ressource naturelle lié au transport quotidien ?");
	// Replace "Vous préoccupez-vous du gaspillage de ressource naturelle lié au transport quotidien ?" with "gaspillage ressource naturelle transport" on selectedSheet
	selectedSheet.replaceAll("Vous préoccupez-vous du gaspillage de ressource naturelle lié au transport quotidien ?", "gaspillage ressource naturelle transport", { completeMatch: false, matchCase: false });
	// Auto fit the columns of range F:F on selectedSheet
	selectedSheet.getRange("F:F").getFormat().autofitColumns();
	// Set range G1 on selectedSheet
	selectedSheet.getRange("G1").setValue("Vous préoccupez-vous du gaspillage de  ressource naturelle lié aux textiles et à la mode ?");
	// Replace "Vous préoccupez-vous du gaspillage de  ressource naturelle lié aux textiles et à la mode ?" with "gaspillage ressource naturelle textiles" on selectedSheet
	selectedSheet.replaceAll("Vous préoccupez-vous du gaspillage de  ressource naturelle lié aux textiles et à la mode ?", "gaspillage ressource naturelle textiles", { completeMatch: false, matchCase: false });
	// Auto fit the columns of range G:G on selectedSheet
	selectedSheet.getRange("G:G").getFormat().autofitColumns();
	// Set range H1 on selectedSheet
	selectedSheet.getRange("H1").setValue("Vous préoccupez-vous du gaspillage de ressource naturelle lié à la construction et à l'entretient des bâtiments  ?");
	// Replace "Vous préoccupez-vous du gaspillage de ressource naturelle lié à la construction et à l'entretient des bâtiments  ?" with "ressource naturelle construction / entretient bâtiments" on selectedSheet
	selectedSheet.replaceAll("Vous préoccupez-vous du gaspillage de ressource naturelle lié à la construction et à l'entretient des bâtiments  ?", "ressource naturelle construction / entretient bâtiments", { completeMatch: false, matchCase: false });
	// Replace "ressource naturelle construction / entretient bâtiments" with "gaspillage ressource naturelle construction / entretient bâtiments" on selectedSheet
	selectedSheet.replaceAll("ressource naturelle construction / entretient bâtiments", "gaspillage ressource naturelle construction / entretient bâtiments", { completeMatch: false, matchCase: false });
	// Auto fit the columns of range H:H on selectedSheet
	selectedSheet.getRange("H:H").getFormat().autofitColumns();
	// Paste to range J7 on selectedSheet from range A1:H1 on selectedSheet
	selectedSheet.getRange("J7").copyFrom(selectedSheet.getRange("A1:H1"), ExcelScript.RangeCopyType.all, false, false);
	// Set range J7:Q7 on selectedSheet
	selectedSheet.getRange("J7:Q7").setValues([["MOYENNE gaspillage alimentaire", "MOYENNE gaspillage énergétique", "MOYENNE gaspillage électronique", "MOYENNE gaspillage plastique", "MOYENNE gaspillage d'eau", "MOYENNE gaspillage ressource naturelle transport", "MOYENNE gaspillage ressource naturelle textiles", "MOYENNE gaspillage ressource naturelle construction / entretient bâtiments"]]);
	// Add a new worksheet with name "Moyenne gaspillage"
	let moyenne_gaspillage = workbook.addWorksheet("Moyenne gaspillage");
	// Paste to range A1 on moyenne_gaspillage from range J7:Q8 on selectedSheet
	selectedSheet.getRange("J7:Q8").moveTo(moyenne_gaspillage.getRange("A1"));
	// Auto fit the columns of range A:A on moyenne_gaspillage
	moyenne_gaspillage.getRange("A:A").getFormat().autofitColumns();
	// Auto fit the columns of range B:B on moyenne_gaspillage
	moyenne_gaspillage.getRange("B:B").getFormat().autofitColumns();
	// Auto fit the columns of range C:C on moyenne_gaspillage
	moyenne_gaspillage.getRange("C:C").getFormat().autofitColumns();
	// Auto fit the columns of range D:D on moyenne_gaspillage
	moyenne_gaspillage.getRange("D:D").getFormat().autofitColumns();
	// Auto fit the columns of range E:E on moyenne_gaspillage
	moyenne_gaspillage.getRange("E:E").getFormat().autofitColumns();
	// Auto fit the columns of range F:F on moyenne_gaspillage
	moyenne_gaspillage.getRange("F:F").getFormat().autofitColumns();
	// Auto fit the columns of range G:G on moyenne_gaspillage
	moyenne_gaspillage.getRange("G:G").getFormat().autofitColumns();
	// Auto fit the columns of range H:H on moyenne_gaspillage
	moyenne_gaspillage.getRange("H:H").getFormat().autofitColumns();
	// Set horizontal alignment to ExcelScript.HorizontalAlignment.center for range A2:H2 on moyenne_gaspillage
	moyenne_gaspillage.getRange("A2:H2").getFormat().setHorizontalAlignment(ExcelScript.HorizontalAlignment.center);
	moyenne_gaspillage.getRange("A2:H2").getFormat().setIndentLevel(0);
	// Set horizontal alignment to ExcelScript.HorizontalAlignment.center for range A1:H7 on selectedSheet
	selectedSheet.getRange("A1:H100").getFormat().setHorizontalAlignment(ExcelScript.HorizontalAlignment.center);
	selectedSheet.getRange("A1:H100").getFormat().setIndentLevel(0);
	// Create a table with format on range A1:H7 on selectedSheet
	let table1 = workbook.addTable(selectedSheet.getRange("A1:H100"), true);
	table1.setPredefinedTableStyle("TableStyleDark3");
	// Set font color to "FFFFFF" for range 1:1 on selectedSheet
	selectedSheet.getRange("1:1").getFormat().getFont().setColor("FFFFFF");
	// Auto fit the columns of range A:A on selectedSheet
	selectedSheet.getRange("A:A").getFormat().autofitColumns();
	// Auto fit the columns of range B:B on selectedSheet
	selectedSheet.getRange("B:B").getFormat().autofitColumns();
	// Auto fit the columns of range C:C on selectedSheet
	selectedSheet.getRange("C:C").getFormat().autofitColumns();
	// Auto fit the columns of range C:C on selectedSheet
	selectedSheet.getRange("C:C").getFormat().autofitColumns();
	// Auto fit the columns of range D:D on selectedSheet
	selectedSheet.getRange("D:D").getFormat().autofitColumns();
	// Auto fit the columns of range E:E on selectedSheet
	selectedSheet.getRange("E:E").getFormat().autofitColumns();
	// Auto fit the columns of range F:F on selectedSheet
	selectedSheet.getRange("F:F").getFormat().autofitColumns();
	// Auto fit the columns of range G:G on selectedSheet
	selectedSheet.getRange("G:G").getFormat().autofitColumns();
	// Auto fit the columns of range G:G on selectedSheet
	selectedSheet.getRange("G:G").getFormat().autofitColumns();
	// Auto fit the columns of range H:H on selectedSheet
	selectedSheet.getRange("H:H").getFormat().autofitColumns();
	// Create a table with format on range A1:H2 on moyenne_gaspillage
	let table2 = workbook.addTable(moyenne_gaspillage.getRange("A1:H2"), true);
	table2.setPredefinedTableStyle("TableStyleDark3");
	// Set font color to "FFFFFF" for range 1:1 on moyenne_gaspillage
	moyenne_gaspillage.getRange("1:1").getFormat().getFont().setColor("FFFFFF");
}
```

<a href="https://drive.google.com/uc?export=download&id=1mSnTht9gw0GCjJaObxFPh-Wl6tpIKcmG">Télécharger le Script VBA</a>

# Conclusion

L'instauration d'un questionnaire modulable et la conversion réussie des réponses en données numériques via un script VBA ont répondu de manière efficace à ma problématique initiale, celle de parvenir à traiter un grand volume de données permettant ainsi un enrichissement dans l'analyse.