-- Retrieve the total number of orders placed.
SELECT 
    COUNT(*) AS total_order_placed
FROM
    orders;

-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS total_sales
FROM
    order_details AS od
        LEFT JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id;

-- Identify the highest-priced pizza.
SELECT 
    pt.name, p.price
FROM
    pizzas AS p
        LEFT JOIN
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.


SELECT 
    p.size, COUNT(order_details_id) AS total_order
FROM
    order_details AS od
        LEFT JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY COUNT(order_details_id) DESC;


-- List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pt.name, pt.pizza_type_id, SUM(od.quantity)
FROM
    order_details AS od
        JOIN
    pizzas AS p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types AS pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.pizza_type_id , pt.name
ORDER BY SUM(od.quantity) DESC
LIMIT 5;

-- alternate query 
SELECT DISTINCT
    pt.name,
    pt.pizza_type_id,
    SUM(od.quantity) OVER(PARTITION BY pt.pizza_type_id) AS total_quantity
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
ORDER BY total_quantity DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT distinct
    pt.category,
    SUM(od.quantity) OVER(PARTITION BY pt.category) AS total_quantity
FROM order_details od
JOIN pizzas p
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
ORDER BY total_quantity DESC;


-- alternate query
SELECT 
    pt.category, SUM(od.quantity) AS total_quantity
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details AS od ON p.pizza_id = od.pizza_id
GROUP BY pt.category;

-- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) as Hour, COUNT(order_id)  as Order_count
FROM
    orders
GROUP BY HOUR(order_time);


-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT 
    pt.category, COUNT(o.order_id) AS total_orders
FROM
    orders AS o
        JOIN
    order_details AS od ON o.order_id = od.order_id
        JOIN
    pizzas AS p ON p.pizza_id = od.pizza_id
        JOIN
    pizza_types AS pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.category;


-- Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(Total_quantity), 2) AS avg_pizza_ordered_per_day
FROM
    (SELECT 
        o.order_date, SUM(od.quantity) AS Total_quantity
    FROM
        order_details AS od
    JOIN orders AS o ON o.order_id = od.order_id
    GROUP BY o.order_date) AS quantity_by_date;

-- Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pt.name, SUM(od.quantity * p.price) AS revenue
FROM
    order_details AS od
        JOIN
    pizzas AS p ON p.pizza_id = od.pizza_id
        JOIN
    pizza_types AS pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 3;


-- Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pt.category,
    round(SUM(p.price * od.quantity),2) AS revenue,
    round(SUM(p.price * od.quantity) / (select  
round(sum(od.quantity * p.price),2) as total_sales
from  order_details as od
left join  pizzas as p
on od.pizza_id = p.pizza_id)*100,2) as perc_contribution
FROM
    order_details AS od
        JOIN
    pizzas AS p ON p.pizza_id = od.pizza_id
        JOIN
    pizza_types AS pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.category
ORDER BY revenue DESC;



-- Analyze the cumulative revenue generated over time.

select 
order_date,
revenue,
sum(revenue) over(order by order_date) as cum_revenue
from 
(select 
	orders.order_date,
	sum(order_details.quantity * pizzas.price) as revenue
from order_details
join pizzas
on order_details.pizza_id = pizzas.pizza_id
join orders
on order_details.order_id = orders.order_id
group by orders.order_date) as sales;


-- Determine the top 3 most ordered pizza types based on revenue 
-- for each pizza category.
select category , name , revenue, ranks
from
(select category , name ,
revenue,
rank() over(partition by category order by revenue desc) as ranks
from
(select 
pizza_types.category,
pizza_types.name ,
sum(order_details.quantity * pizzas.price ) as revenue
from pizza_types
join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id =pizzas.pizza_id
group by pizza_types.category,
pizza_types.name) as Alfa) as Bita 
where ranks <= 3;

















    













