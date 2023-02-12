-- Question 1 
SELECT DISTINCT
    CONCAT(first_name, ' ', last_name) AS customer_name, email
FROM
    customer
ORDER BY 1;

-- Question 2
SELECT DISTINCT
    a.customer_id,
    CONCAT(first_name, ' ', last_name) AS customer_name,
    AVG(b.amount) AS average_payment_made
FROM
    customer a
        INNER JOIN
    payment b ON a.customer_id = b.customer_id
GROUP BY 1 , 2
ORDER BY 3 DESC;

-- Question 3 - Method 1 (joins)
SELECT DISTINCT
    (CONCAT(d.first_name, '  ', d.last_name)) AS customer_full_name
FROM
    customer d
        JOIN
    rental l ON d.customer_id = l.customer_id
        JOIN
    inventory i ON l.inventory_id = i.inventory_id
        JOIN
    film_category f ON i.film_id = f.film_id
        JOIN
    category c ON f.category_id = c.category_id
WHERE
    c.name = 'Action';

-- Question 3 - Method 2 (subqueries)
SELECT DISTINCT
    (CONCAT(first_name, '  ', last_name)) AS customer_full_name
FROM
    sakila.customer
WHERE
    customer_id IN (SELECT 
            customer_id
        FROM
            rental
        WHERE
            inventory_id IN (SELECT 
                    inventory_id
                FROM
                    inventory
                WHERE
                    film_id IN (SELECT 
                            film_id
                        FROM
                            film_category
                        WHERE
                            category_id IN (SELECT 
                                    category_id
                                FROM
                                    category
                                WHERE
                                    name = 'Action'))));

-- Question 4
SELECT DISTINCT
    a.customer_id,
    CONCAT(first_name, ' ', last_name) AS customer_name,
    CASE
        WHEN b.amount < 2 THEN 'Low'
        WHEN b.amount >= 2 THEN 'Medium'
        WHEN b.amount >= 4 THEN 'High'
    END AS transaction_value
FROM
    customer a
        INNER JOIN
    payment b ON a.customer_id = b.customer_id
GROUP BY 1 , 2 , 3
ORDER BY 2;