--Liste des titres de films
SELECT f.title  
FROM film f ; 

--Nombre de films par catégorie
SELECT fc.category_id , COUNT(*) AS nombre_de_films_par_categories
FROM film_category fc  
JOIN category c  
ON fc.category_id  = c.category_id 
GROUP BY fc.category_id; 


--Liste des films dont la durée est supérieure à 120 minutes
SELECT f.title , f."length"
FROM film f 
WHERE f.length > 120; 

--Liste des films de catégorie "Action" ou "Comedy"
SELECT  f.title ,fc.category_id 
FROM film_category fc 
JOIN film f 
ON fc.film_id = f.film_id 
WHERE fc.category_id = 1;

--Nombre total de films (définissez l'alias 'nombre de film' pour la valeur calculée)

SELECT  SUM(f.language_id)  AS nombre_de_film_
FROM film f; 

--Les notes moyennes par catégorie
SELECT  AVG(f.rental_rate) AS notes_moyennes_par_categorie
FROM film f; 


--Liste des 10 films les plus loués. (SELECT, JOIN, GROUP BY, ORDER BY, LIMIT)

SELECT f.title , i.film_id , COUNT() AS films_les_plus_loues
FROM film f 
JOIN inventory i 
ON f.film_id  = i.film_id 
JOIN rental r 
ON r.inventory_id = i.inventory_id 
GROUP BY f.title 
ORDER BY films_les_plus_loues DESC 
LIMIT 10;

-- Acteurs ayant joué dans le plus grand nombre de films. 
--(JOIN, GROUP BY, ORDER BY, LIMIT)

SELECT a.actor_id,a.first_name,a.last_name ,COUNT() AS actors_avec_le_plus_de_films
FROM actor a 
JOIN film_actor fa 
ON a.actor_id = fa.actor_id 
JOIN film f 
ON f.film_id = fa.film_id 
GROUP BY a.actor_id 
ORDER BY actors_avec_le_plus_de_films DESC
LIMIT 15;

-- Revenu total généré par mois

SELECT strftime('%Y-%m', '2006-08-23') AS mois ,SUM(p.amount) AS revenu_total_par_mois  
FROM payment p 
--JOIN inventory i 
--ON f.film_id = i.film_id 
--JOIN rental r 
--ON r.inventory_id = i.inventory_id 
--JOIN payment p 
--ON r.rental_id = p.rental_id 
GROUP BY mois


--Revenu total généré par chaque magasin par mois pour l'année 2005.
-- (JOIN, SUM, GROUP BY, DATE functions)

SELECT	strftime('%Y-%m', p.payment_date) AS years, s.store_id AS magasin  ,SUM(p.amount) AS total_de_revenus
from store s  
JOIN payment p
ON s.manager_staff_id  = p.staff_id  
WHERE years LIKE  '2005%'
GROUP BY  s.store_id ,years

--Les clients les plus fidèles, basés sur le nombre de locations.
--  (SELECT, COUNT, GROUP BY, ORDER BY)

SELECT c.first_name ,c.last_name ,c.store_id AS Store, COUNT(r.customer_id) AS The_most_loyal_customers
FROM customer c 
JOIN rental r 
ON c.customer_id = r.customer_id 
GROUP BY r.customer_id  
ORDER BY The_most_loyal_customers DESC

--Films qui n'ont pas été loués au cours des 6 derniers mois.
-- (LEFT JOIN, WHERE, DATE functions, Sub-query)

WITH date_avant AS (
SELECT date(MAX(rental_date), '-6 months') AS the_value_stock
FROM rental
),
recent_rental AS (
SELECT *
FROM film f 
JOIN inventory i ON f.film_id = i.film_id 
JOIN rental r ON r.inventory_id = i.inventory_id 
WHERE r.rental_date  > (SELECT the_value_stock FROM date_avant)
)
-- requête principal  
SELECT f.title , f.film_id 
FROM film f 
LEFT JOIN recent_rental 
ON f.film_id  = recent_rental.film_id
WHERE recent_rental.rental_date IS NULL ; 


--Le revenu total de chaque membre du personnel à partir des locations. 
--(JOIN, GROUP BY, ORDER BY, SUM)

SELECT s.staff_id , s.first_name ,s.last_name  , SUM(p.amount) AS revenu_total
FROM staff s 
--JOIN rental r 
--ON s.staff_id = r.staff_id 
JOIN payment p 
ON s.staff_id = p.staff_id  
GROUP BY s.staff_id
ORDER BY revenu_total DESC ;

--Catégories de films les plus populaires parmi les clients.
-- (JOIN, GROUP BY, ORDER BY, LIMIT)

SELECT c.category_id ,c.name  , COUNT() AS total
FROM category c 
JOIN film_category fc 
ON c.category_id = fc.category_id 
JOIN film f 
ON fc.film_id = f.film_id 
JOIN inventory i 
ON f.film_id = i.film_id 
JOIN rental r 
ON r.inventory_id = i.inventory_id 
GROUP BY c.name 
ORDER BY total DESC;

--Durée moyenne entre la location d'un film et son retour.
-- (SELECT, AVG, DATE functions) 
SELECT ROUND(AVG(julianday(r.return_date) - julianday(r.rental_date)), 2) AS la_duree_moyenne,f.film_id , f.title, r.rental_id 
FROM rental r 
JOIN inventory i 
ON r.inventory_id = i.inventory_id 
JOIN film f 
ON i.film_id = f.film_id 
GROUP BY  f.film_id 



--la moyenne générale de tous les films

with duree_moyenne_par_film AS (
	SELECT ROUND(AVG(julianday(r.return_date) - julianday(r.rental_date)), 2) AS la_duree_moyenne,f.film_id , f.title, r.rental_id 
	FROM rental r 
	JOIN inventory i 
	ON r.inventory_id = i.inventory_id 
	JOIN film f 
	ON i.film_id = f.film_id 
	GROUP BY  f.film_id 
)
SELECT ROUND( AVG(la_duree_moyenne)) 
FROM duree_moyenne_par_film


--Acteurs qui ont joué ensemble dans le plus grand nombre de films.
--Afficher l'acteur 1, l'acteur 2 et le nombre de films en commun.
--Trier les résultats par ordre décroissant. Attention aux répétitons.
--(JOIN, GROUP BY, ORDER BY, Self-join)

WITH nom_de_acteur AS (
SELECT fa1.actor_id AS acteur1,a1.first_name ,fa2.actor_id AS acteur2,a2.first_name , COUNT(*) AS films_en_communs 
FROM film_actor fa1 
JOIN film_actor fa2  ON fa1.film_id = fa2.film_id AND acteur1  < acteur2
JOIN actor a1 ON a1.actor_id = fa1.actor_id 
JOIN actor a2 ON a2.actor_id = fa2.actor_id 
--WHERE acteur1 < acteur2
GROUP BY acteur1 , acteur2 
ORDER BY films_en_communs DESC
)
SELECT *
FROM nom_de_acteur

--Bonus : Clients qui ont loué des films mais n'ont pas 
--fait au moins une location dans les 30 jours qui suivent.
-- (JOIN, WHERE, DATE functions, Sub-query)
--
WITH deux_date AS(
	SELECT r1.customer_id ,r1.rental_id ,r2.rental_date as rental_date2 ,r1.rental_date as rental_date1 
	FROM rental r1 
	JOIN rental r2 ON r1.customer_id = r2.customer_id AND date(r2.rental_date) > date(r1.rental_date) 	
),
differance_deux_date  AS(
	SELECT * , JULIANDAY(rental_date1) - JULIANDAY(rental_date2) as la_differante 
	FROM deux_date
)
SELECT  * 
FROM differance_deux_date
GROUP  BY customer_id 
HAVING la_differante > 30





