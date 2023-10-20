# Projet d'Analyste de Données Sakila Films

Bienvenue dans le projet d'Analyste de Données Sakila Films ! Dans ce projet, vous allez endosser le rôle d'un analyste de données au sein de la société de location de films fictive "Sakila Films". Votre mission consiste à analyser la base de données de l'entreprise pour extraire des informations clés et fournir des données essentielles pour la prise de décisions stratégiques.

## Contexte du Projet

Sakila Films cherche à mieux comprendre son activité de location de films et à prendre des décisions éclairées. La société a mis à disposition une base de données riche en informations, et vous utiliserez des requêtes SQL pour répondre à diverses demandes de la direction. Ces demandes varient en complexité, de la simple récupération de données à des analyses plus avancées.

## Demandes de Base

1. **Liste des Titres de Films** : Récupérez la liste de tous les titres de films.
2. **Nombre de Films par Catégorie** : Calculez le nombre de films dans chaque catégorie.
3. **Liste des Films d'une Durée Supérieure à 120 Minutes** : Identifiez les films dont la durée dépasse 120 minutes.
4. **Liste de Films d'Action ou de Comédie** : Extrayez une liste de films catégorisés comme "Action" ou "Comédie".
5. **Nombre Total de Films** : Trouvez le nombre total de films et fournissez-le avec l'alias 'nombre de film'.
6. **Notes Moyennes par Catégorie** : Calculez les notes moyennes des films dans chaque catégorie.

## Demandes Intermédiaires

7. **Top 10 des Films les Plus Loués** : Énumérez les 10 films les plus loués en utilisant plusieurs concepts tels que SELECT, JOIN, GROUP BY, ORDER BY et LIMIT.
8. **Acteurs Ayant Joué dans le Plus Grand Nombre de Films** : Identifiez les acteurs ayant joué dans le plus grand nombre de films en utilisant JOIN, GROUP BY, ORDER BY et LIMIT.
9. **Revenu Total Mensuel** : Calculez le revenu total généré par mois.
10. **Revenu Mensuel par Magasin en 2005** : Déterminez le revenu total généré par chaque magasin par mois en 2005 en utilisant JOIN, SUM, GROUP BY et des fonctions DATE.
11. **Clients les Plus Fidèles Basés sur le Nombre de Locations** : Identifiez les clients les plus fidèles en fonction du nombre de locations, en impliquant SELECT, COUNT, GROUP BY et ORDER BY.
12. **Films Non Loués au Cours des 6 Derniers Mois** : Repérez les films qui n'ont pas été loués au cours des 6 derniers mois en utilisant LEFT JOIN, WHERE, des fonctions DATE et une sous-requête.
13. **Revenu Total de Chaque Employé par Location** : Calculez le revenu total de chaque membre du personnel à partir des locations en utilisant JOIN, GROUP BY, ORDER BY et SUM.
14. **Catégories de Films les Plus Populaires Parmi les Clients** : Déterminez les catégories de films les plus populaires parmi les clients en utilisant JOIN, GROUP BY, ORDER BY et LIMIT.
15. **Durée Moyenne entre la Location et le Retour d'un Film** : Calculez la durée moyenne entre la location et le retour d'un film en utilisant SELECT, AVG et des fonctions DATE.
16. **Acteurs Ayant Joué Ensemble dans le Plus Grand Nombre de Films** : Trouvez les acteurs ayant joué ensemble dans le plus grand nombre de films. Affichez l'acteur 1, l'acteur 2 et le nombre de films en commun. Triez les résultats par ordre décroissant. Faites attention aux doublons (JOIN, GROUP BY, ORDER BY, Auto-jointure).
17. **Bonus : Clients Ayant Loué des Films mais N'ayant Pas Loué dans les 30 Jours Suivants** : Identifiez les clients ayant loué des films mais qui n'ont pas loué dans les 30 jours suivants en utilisant JOIN, WHERE, des fonctions DATE et une sous-requête.
18. **Bonus : Refaites la Même Requête pour un Interval de 15 Jours en Août 2005**.

## Modifications de la Base de Données

Vous avez la possibilité de modifier la base de données avec les requêtes suivantes :

- Ajoutez un nouveau film intitulé "Sunset Odyssey", sorti en 2023, d'une durée de 125 minutes et catégorisé en "Drame".
- Mettez à jour le film intitulé "Sunset Odyssey" pour le faire appartenir à la catégorie "Aventure".
- Supprimez le film ayant pour titre "Sunset Odyssey".

**Remarque** : Assurez-vous de sauvegarder la base de données avant d'exécuter des requêtes qui modifient les données.

Merci de vous lancer dans ce passionnant projet d'analyste de données pour Sakila Films. Vous jouerez un rôle essentiel en fournissant des informations précieuses pour les processus de prise de décision de l'entreprise. Bonne chance dans votre analyse !