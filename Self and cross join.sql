# SQL Self and cross join
# 1. Get all pairs of actors that worked together.

select fa.actor_id, fa.film_id, fa2.actor_id from sakila.film_actor fa 
join sakila.film_actor fa2
on fa.actor_id > fa2.actor_id
and fa.film_id = fa2.film_id;

# 2. Get all pairs of customers that have rented the same film more than 1 times.
select * from sakila.rental;

SELECT count(a1.rental_id), a1.customer_id, a1.film_id, a2.customer_id
FROM ( select i.inventory_id, r.rental_id, r.customer_id, i.film_id
from sakila.rental r
join sakila.inventory i
on r.inventory_id  = i.inventory_id) a1
JOIN
(select iv.inventory_id, re.rental_id, re.customer_id, iv.film_id
from sakila.rental re
join sakila.inventory iv
on re.inventory_id  = iv.inventory_id) a2
ON a1.film_id = a2.film_id
and a1.customer_id  <> a2.customer_id
group by a1.customer_id, a1.film_id, a2.customer_id
having count(a1.rental_id)>1;

 

# 3. Get all possible pairs of actors and films
select distinct title from sakila.film;
select distinct actor_id, last_name from sakila.actor;

select * from (
  select distinct title from sakila.film
) sub1
cross join (
  select distinct actor_id,first_name, last_name from sakila.actor
) sub2;