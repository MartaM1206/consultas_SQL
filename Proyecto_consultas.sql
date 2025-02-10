--SECCION 1

-- Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.
SELECT "title",   
    "rating"
from FILM F 
WHERE "rating" = 'R'

-- Encuentra los nombres de los actores con actor_id entre 30 y 40.
SELECT actor_id, concat(first_name, ' ', last_name) AS Nomnbre_actor
FROM actor a 
WHERE actor_id BETWEEN 30 AND 40

-- Obtén las películas cuyo idioma coincide con el idioma original.
SELECT *
FROM film f 
WHERE language_id = original_language_id 

-- Ordena las películas por duración de forma ascendente.
SELECT "title", length 
FROM film f 
ORDER BY length ASC

-- Encuentra el nombre y apellido de los actores con ‘Allen’ en su apellido.
SELECT first_name, last_name 
FROM actor a 
WHERE last_name like '%Allen%'

-- Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.
SELECT rating AS "Clasificación", count(film_id) AS "recuento"
FROM film f 
GROUP BY rating 

-- Encuentra el título de todas las películas que son ‘PG13’ o tienen una duración mayor a 3 horas.
SELECT "title", rating, length 
FROM film f 
WHERE rating = 'PG-13' OR length > 180

-- Encuentra la variabilidad de lo que costaría reemplazar las películas.
SELECT variance(replacement_cost ) 
FROM film f 

-- Encuentra la mayor y menor duración de una película en la base de datos.
SELECT max(length) AS mayor_duracion, min(length) AS menor_duracion

-- Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
SELECT amount, payment_date 
FROM payment p 
ORDER BY payment_date DESC 
LIMIT 1
OFFSET 2

-- Encuentra el título de las películas que no sean ni ‘NC-17’ ni ‘G’ en cuanto a clasificación.
SELECT "title", "rating"
FROM film f 
WHERE rating NOT IN ('NC-17', 'G')

-- Encuentra el promedio de duración de las películas para cada clasificación y muestra la clasificación junto con el promedio.
SELECT "rating" AS clasificacion, avg(length) AS duracion_media
FROM film f 
GROUP BY "rating"

-- Encuentra el título de todas las películas con una duración mayor a 180 minutos.
SELECT "title", "length"
FROM film f 
WHERE length > 180

-- ¿Cuánto dinero ha generado en total la empresa?
SELECT sum(amount) AS total_ingresos
FROM payment p 

-- Muestra los 10 clientes con mayor valor de ID.
SELECT customer_id, concat(first_name, ' ', last_name)
FROM customer c 
ORDER BY customer_id DESC 
LIMIT 10

-- Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
SELECT a.first_name, a.last_name 
FROM film f 
INNER JOIN film_actor fa ON f.film_id = fa.film_id 
INNER JOIN actor a ON fa.actor_id = a.actor_id 
WHERE f.title = 'EGG IGBY'


-- SECCION 2

-- Selecciona todos los nombres únicos de películas.
SELECT DISTINCT "title"
FROM film f 

-- Encuentra las películas que son comedias y tienen una duración mayor a 180 minutos.
SELECT f.title, c.name, f.length 
FROM film f 
JOIN film_category fc ON f.film_id = fc.film_id 
JOIN category c ON fc.category_id =c.category_id 
WHERE c."name" = 'Comedy' AND f.length > 180

-- Encuentra las categorías de películas con un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio.
SELECT c."name" AS categoria, avg(f.length) AS promedio
FROM film f 
JOIN film_category fc ON f.film_id = fc.film_id 
JOIN category c ON fc.category_id = c.category_id 
GROUP BY c.category_id 
HAVING avg(f.length) > 110

-- ¿Cuál es la media de duración del alquiler de las películas?
SELECT avg(rental_duration) AS duracion_alquiler_medio
FROM film f 

SELECT AVG(return_date - rental_date) AS media_duracion
FROM rental r 

-- Crea una columna con el nombre completo (nombre y apellidos) de los actores y actrices.
SELECT concat(first_name, ' ', last_name) AS nombre_completo
FROM actor a 

-- Muestra los números de alquileres por día, ordenados de forma descendente.
SELECT rental_date, count(rental_id) AS alquieres_dia
FROM rental r 
group BY rental_date 
ORDER BY alquieres_dia DESC

-- Encuentra las películas con una duración superior al promedio.
SELECT "title", length 
FROM film f 
WHERE length > (SELECT avg(length) FROM film f2)

-- Averigua el número de alquileres registrados por mes.
SELECT (EXTRACT (MONTH FROM r.rental_date)) AS "mes",
count("rental_id")
FROM rental r 
GROUP BY "mes"

-- Encuentra el promedio, la desviación estándar y la varianza del total pagado.
SELECT avg(amount) AS promedio, stddev(amount) AS desviacion_estandar, variance(amount) AS varianza  
FROM payment p 

-- ¿Qué películas se alquilan por encima del precio medio?
SELECT f.title, p.amount 
FROM payment p 
JOIN rental r ON P.rental_id = R.rental_id 
JOIN inventory i ON r.inventory_id = i.inventory_id 
JOIN film f ON i.film_id = f.film_id 
WHERE p.amount > (SELECT avg(p2.amount) FROM payment p2)

-- Muestra el ID de los actores que hayan participado en más de 40 películas.
SELECT actor_id, count(film_id) 
FROM film_actor fa 
GROUP BY actor_id 
HAVING count(film_id) >= 40
 
-- Obtén todas las películas y, si están disponibles en el inventario, muestra la cantidad disponible.
SELECT f.title AS pelicula, count(i.inventory_id) AS cantidad_disponible
FROM film f
LEFT JOIN inventory i ON i.film_id = f.film_id 
GROUP BY f.title

-- Obtén los actores y el número de películas en las que han actuado.
SELECT a.actor_id, concat(a.first_name, ' ', a.last_name) AS nombre, count(film_id) AS num_pelis
FROM film_actor fa 
JOIN actor a ON fa.actor_id = a.actor_id 
GROUP BY a.actor_id 
ORDER BY a.actor_id 

-- Obtén todas las películas con sus actores asociados, incluso si algunas no tienen actores.
SELECT f.title, concat(a.first_name, ' ', a.last_name) AS actores
FROM film f 
LEFT JOIN film_actor fa ON f.film_id = fa.film_id 
JOIN actor a ON fa.actor_id = a.actor_id 

-- Encuentra los 5 clientes que más dinero han gastado.
SELECT c.customer_id, concat(c.first_name, ' ', c.last_name) AS nombre, sum(p.amount) AS cantidad
FROM customer c 
JOIN payment p ON c.customer_id = p.customer_id 
GROUP BY c.customer_id 
ORDER BY cantidad desc
LIMIT 5


-- SECCION 3

-- Encuentra el ID del actor más bajo y más alto.
SELECT min(actor_id) AS id_bajo, max(actor_id) AS id_alto
FROM actor a 

-- Cuenta cuántos actores hay en la tabla actor.
SELECT count(actor_id) AS conteo_actores
FROM actor a 

-- Selecciona todos los actores y ordénalos por apellido en orden ascendente.
SELECT *
FROM actor a 
ORDER BY last_name ASC 

-- Selecciona las primeras 5 películas de la tabla film
SELECT *
FROM film f 
LIMIT 5

-- Agrupa los actores por nombre y cuenta cuántos tienen el mismo nombre.
SELECT first_name, count(first_name) AS conteo
FROM actor a
GROUP BY first_name 

-- Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
SELECT r.rental_id, concat(c.first_name, ' ', c.last_name) AS nombre_cliente 
FROM rental r 
JOIN customer c ON r.customer_id = c.customer_id 

-- Muestra todos los clientes y sus alquileres, incluyendo los que no tienen.
SELECT concat(c.first_name, ' ', c.last_name) AS nombre_cliente, r.rental_id 
FROM customer c 
LEFT JOIN rental r ON r.customer_id = c.customer_id 

-- Realiza un CROSS JOIN entre las tablas film y category. Analiza su valor.
SELECT *
FROM film f 
CROSS JOIN category c 
/* Podemos ver todas las categorías de cada película aunque no haya una relación directa entre las dos tablas.*/

-- Encuentra los actores que han participado en películas de la categoría ‘Action’.
SELECT concat(a.first_name, ' ', a.last_name) AS nombre, c.name AS categoria
FROM actor a 
JOIN film_actor fa ON a.actor_id = fa.actor_id 
JOIN film f ON fa.film_id = f.film_id 
JOIN film_category fc ON fc.film_id = f.film_id 
JOIN category c ON fc.category_id = c.category_id 
WHERE c."name" = 'Action'

-- Encuentra todos los actores que no han participado en películas.
SELECT concat(a.first_name, ' ', a.last_name) AS nombre
FROM actor a 
JOIN film_actor fa ON a.actor_id = fa.actor_id 
WHERE fa.film_id  ISNULL 

-- Crea una vista llamada actor_num_peliculas que muestre los nombres de los actores y el número de películas en las que han actuado.
CREATE VIEW actor_num_peliculas AS
SELECT concat(a.first_name, ' ', a.last_name) AS actores, count(f.film_id)
FROM actor a 
JOIN film_actor fa ON fa.actor_id = a.actor_id
JOIN film f ON f.film_id = fa.film_id
GROUP BY a.actor_id


-- SECCION 4
-- Calcula el número total de alquileres realizados por cada cliente.
SELECT concat(c."first_name", ' ', c."last_name") AS cliente, count(r."rental_id") as alquileres
FROM customer c
JOIN rental r ON c."customer_id" = r."customer_id"
GROUP BY c.customer_id

-- Calcula la duración total de las películas en la categoría Action.
select sum(f.length) as duracion
from film f 
join  film_category fc on f.film_id = fc.film_id 
join category c on fc.category_id = c.category_id 
where c."name" = 'Action'

-- Encuentra los clientes que alquilaron al menos 7 películas distintas.
SELECT concat(c."first_name", ' ', c."last_name") AS cliente, count(i."film_id") as alquileres
FROM customer c
JOIN rental r ON c."customer_id" = r."customer_id"
join inventory i on r.inventory_id = i.inventory_id 
GROUP BY c.customer_id
having count(i."film_id") > 7

-- Encuentra la cantidad total de películas alquiladas por categoría.
select c."name" as categoria,  sum(r.rental_id) as cantidad
from film f 
join film_category fc on f.film_id = fc.film_id 
join category c on fc.category_id = c.category_id 
join inventory i on i.film_id = f.film_id 
join rental r on r.inventory_id = i.inventory_id 
group by c."name"

-- Renombra las columnas first_name como Nombre y last_name como Apellido.
create view clientes as
select c.first_name as Nombre, c.last_name as Apellido
from customer c

select *
from clientes

-- Crea una tabla temporal llamada cliente_rentas_temporal para almacenar el total de alquileres por cliente.
CREATE TEMPORARY TABLE cliente_rentas_temporal as
SELECT concat(c."first_name", ' ', c."last_name") AS cliente, count(r."rental_id") as alquileres
FROM customer c
JOIN rental r ON c."customer_id" = r."customer_id"
GROUP BY c.customer_id


select cliente_rentas_temporal.cliente, cliente_rentas_temporal.alquileres 
from cliente_rentas_temporal

    --Crea otra tabla temporal llamada peliculas_alquiladas para almacenar películas alquiladas al menos 10 veces.
CREATE TEMPORARY TABLE peliculas_alquiladas as
SELECT f.title, count(r.rental_id)
from rental r
join inventory i on r.inventory_id = i.inventory_id 
join film f on i.film_id = f.film_id 
group by f.film_id 
having count(r.rental_id) >= 10

select * from peliculas_alquiladas

-- Encuentra los nombres de los clientes que más gastaron y sus películas asociadas.
select concat(c.first_name, ' ', c.last_name) as nombre,
	sum(p.amount),
	f.title 
from customer c 
join payment p on c.customer_id = p.customer_id 
join rental r on p.customer_id = r.customer_id 
join inventory i on r.inventory_id = i.inventory_id 
join film f on i.film_id = f.film_id 
group by c.customer_id , f.title
order by sum(p.amount) desc

-- Encuentra los actores que actuaron en películas de la categoría Sci-Fi.
select concat(a.first_name, ' ', a.last_name) as actores
from actor a 
join film_actor fa on a.actor_id = fa.actor_id 
join film f on fa.film_id = f.film_id 
join film_category fc on f.film_id = fc.film_id 
join category c on fc.category_id = c.category_id 
where c."name" = 'Sci-Fi'