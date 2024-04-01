---
layout: post
title: Création de mon portfolio
date: 2023-11-08 9:00:00 +0300
categories: [Projet_Data, Personnel]
tags: [Jekyll, Template, Developpement_WEB, IA, Intelligence_Artificielle, HTML, Git, Github, Github_Desktop, Terminal]
---

# Création de mon portfolio

Dans ce projet, je partage mon voyage à travers la création de mon site web personnel pour présenter mes projets dans le domaine de la Data Science. Je vais détailler comment j'ai surmonté les défis, depuis la conception locale de mon site jusqu'à son déploiement sur Internet.

## Introduction

Au commencement, l'idée de créer un portfolio est née de la nécessité de présenter de manière claire mes différents projets Data, que ce soit dans le cadre scolaire, professionnel ou personnel. La recherche d'une alternance a amplifié ce besoin, et des professionnels de la Data Science sur LinkedIn m'ont conseillé de le construire.

Le hic résidait dans mes connaissances limitées en développement web lors de la création du site. J'avais suivi des cours de HTML et CSS, mais ils étaient insufisant pour mes besoins, je me suis alors tourné vers Chat GPT qui m'a recommandé Jekyll.

Jekyll est un générateur de site statique utilisant le langage Ruby, permettant de simplifier la création de sites web en transformant du contenu en pages HTML prêtes à être déployées à l'aide de Template.

## Développement du Site

Jekyll a résolu la création du site en local, mais l'exportation sur Internet était encore floue. Heureusement, j'ai découvert que GitHub offrait une solution gratuite. Un tutoriel YouTube m'a guidé tout au long du processus, du choix du Template à son exportation sur internet.

Vous pouvez retrouver ce tutoriel ici:

<iframe width="100%" height="600px" src="https://www.youtube.com/embed/F8iOU1ci19Q" frameborder="0" allowfullscreen></iframe>

**Attention** ce tutoriel est anglais mais vous pouvez activer les sous titres (en anglais) si cela va trop rapidement.

## Surmonter les Obstacles Techniques

Les premières difficultés ont émergé lors de l'ajout d'une image personnelle et de la création de pages. Grâce à des astuces fournies par l'IA, j'ai pu résoudre ces problèmes spécifiques. En effet les images doivent venir d'un site internet, j'ai donc d'abord utilisé ce site pour mettre mon image:

[imageshack](https://imageshack.com/)

Avant de me rendre compte que je pouvais, comme pour mes autres documents, utiliser google drive.

La création de page a été quand à elle plus compliqué, en effet la vidéo datant de plus d'un an, certaines chose avait déjà évolué. Pour me débloquer j'ai dû faire les choses suivantes:

* Le fichier était sous la forme "nom-du-fichier.md" et non pas sous la forme "YYYY-MM-DD-nom-du-fichier.md"
* Avoir un dossier "_layouts/post.html" qui n'était pas présent à la base et qui doit contenir ce code:

[créer un lien de téléchargement car le code ne s'affiche pas comme il faut]

Le déploiement sur GitHub Pages a également posé des défis, mais une page spécifique dans l'aide de Jekyll a éclairci la situation. La séquence correcte de commits s'est avérée cruciale. Pour information, pour permettre le déploiement il faut faire la chose suivante:

<iframe src="https://drive.google.com/file/d/14Q04-DRWOEhIj6WvRPNXJzUjsWLGQly-/preview" width="100%" height="400px"></iframe>

Il faut dans Build and Deployment passer de "Deploy from a branch" à "GitHub Actions", ce qui permettra d'exporter le portfolio sur le web. Une fois cela fait, deux comit apparaîtront et il est normal qu'un seul fonctionne, voici un exemple de ce que l'on peut appercevoir:

<iframe src="https://drive.google.com/file/d/1vsQkXHobpI7t3qgP-T-ciR9NK7w4Z2VS/preview" width="100%" height="300px"></iframe>

## Surmonter les Obstacles de Présentation

### Intégration de Documents et d'Images
Maintenant que mon site est opérationnel, je me suis heurté à des obstacles pour présenter mes projets. L'intégration de vidéos YouTube, l'affichage de documents et le partage de code VBA ont nécessité des solutions créatives.

Pour débuter, abordons la complexité de l'intégration de documents et d'images depuis Google Drive, un processus qui m'a confronté à deux problèmes distincts.

Premier problème :

<iframe src="https://drive.google.com/file/d/1sh5QUBNpo-XlgVeAtCCsy8fg7qvJq_6I/preview" width="100%" height="300px"></iframe>

L'URL fournie pour ce premier problème était erronée. Il était impératif de récupérer le lien correct, tel qu'illustré dans la photo ci-dessous :

<iframe src="https://drive.google.com/file/d/1-xz7QB2hdfJfgRTZHESIWp0ZXwzA8Wt7/preview" width="100%" height="300px"></iframe>

Deuxième problème :

<iframe src="https://drive.google.com/file/d/1tU03jBLj9fFXQIFHEet1pHZ03Y8Bc802/preview" width="100%" height="300px"></iframe>

Dans ce cas, le problème résidait dans l'URL. Lors de la récupération du lien, un suffixe "view?usp=sharing" était ajouté. Il fallait le remplacer par "preview".

### Intégration de Vidéos YouTube
Passons désormais à l'intégration de vidéos YouTube. Bien que j'aie initialement choisi cette plateforme pour son intégration fluide, j'ai également dû surmonter des difficultés :

<iframe src="https://drive.google.com/file/d/1GSG95ef_E_-IVjVKZZeZ4GGPewnwYsLD/preview" width="100%" height="300px"></iframe>

Une fois de plus, un problème d'URL s'est posé. La solution impliquait une manipulation technique : récupérer l'adresse fixe de YouTube "https://www.youtube.com", puis ajouter "embed" suivi de l'ID de la vidéo YouTube.

Par exemple, pour la vidéo précédente dont l'URL est "https://www.youtube.com/watch?v=F8iOU1ci19Q&t=310s&ab_channel=TechnoTim", l'ID "F8iOU1ci19" était extrait pour obtenir l'URL finale : "https://www.youtube.com/embed/F8iOU1ci19Q".

### Edit intégration lié aux divers documents

En échangeant avec des collègues de l'école, je me suis rendu compte d'un autre problème :

<iframe src="https://drive.google.com/file/d/1zLJ3LxbHVXLxmBL8cpSG3lV8AaJ5V2EI/preview" width="100%" height="300px"></iframe>

En effet, en utilisant mon compte Google pour importer une image ou un document, lorsque je vérifie si tout fonctionne, je le fais avec ce compte. Cette exception m'a donc échappé.

J'utilise maintenant un autre navigateur où je ne suis pas connecté à mon compte Google. La résolution du problème était assez simple, il suffisait de faire la chose suivante :

<iframe src="https://drive.google.com/file/d/11LsgN76L2bYHCcwx146zlvavf8u-CLU6/preview" width="100%" height="300px"></iframe>

<iframe src="https://drive.google.com/file/d/1YH-XHxAueiqd973zgy5TDV9Z858K5pFd/preview" width="100%" height="300px"></iframe>

Une fois que tous les utilisateurs disposant du lien ont été cochés, même sans avoir donné la permission à un compte Google spécifique, le contenu est accessible.

### Partage de Code VBA
En ce qui concerne l'intégration du code sur le site, les balises de code standard ne fonctionnaient pas avec VBA. J'ai donc adopté une solution ingénieuse consistant à fournir un bouton de téléchargement direct du fichier. Pour cela, j'ai ajouté deux arguments à l'URL d'origine : "uc?export=download" et "id=" suivi de l'ID du fichier. Cela permet de rendre le code facilement accessible à tous, même en l'absence de backticks.

En mettant en pratique ces solutions, vous serez en mesure de résoudre efficacement les défis d'intégration de documents, de vidéos et de code sur votre site web.


## Mini-Conclusion

En conclusion, ce projet de portfolio est une aventure en cours. Les défis rencontrés ne sont pas seulement des obstacles, mais des opportunités d'apprentissage continu. Mon portfolio évoluera avec moi, reflétant ma croissance dans le domaine passionnant de la Data Science.

*Dernière mise à jour - 01 avril 2024*
