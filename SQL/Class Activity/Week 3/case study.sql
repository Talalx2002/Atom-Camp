#Session-05 Exercise

#1 Question: Retrieve the order dates for customers who have joined as members after their first order date.
#2 Question: Find the total amount spent by each customer on their orders.
#3 Question: Retrieve the product names and prices for products that were ordered more than twice.
#4 Question: Find the customer IDs of those customers who have ordered all the products from the menu.
#5 Question: Retrieve the customer IDs and their corresponding join dates who have never placed an order.
################
 #JOINS AND DENSE RANK & CTE
 #1 Question: What is the total amount each customer spent at the restaurant?
  #2 How many days has each customer visited the restaurant?
  #3 What was the first item from the menu purchased by each customer?
  #4 . Which item was the most popular for each customer?
  #5  Which item was purchased first by the customer after they became a member?
  #6 Which item was purchased just before the customer became a member?
  #7 If each $1 spent equates to 10 points and sushi has a 2x points multiplier — how many points would each customer have?
  #8 Recreate the table with: customer_id, order_date, product_name, price, member (Y/N)

## Create tables and insert data before the session using queries below.

CREATE SCHEMA dannys_diner;

SET search_path = dannys_diner;

CREATE TABLE sales (
customer_id VARCHAR(1),
  order_date DATE,
  product_id INTEGER
);

  set sql_safe_updates = 0;
  
INSERT INTO sales
  (customer_id, order_date, product_id)
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 
 select * from sales;

CREATE TABLE menu (
  product_id INTEGER,
  product_name VARCHAR(5),
  price INTEGER
);

INSERT INTO menu
  (product_id, product_name, price)
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  
select * from menu;

CREATE TABLE members (
  customer_id VARCHAR(1),
  join_date DATE
);

INSERT INTO members
  (customer_id, join_date)
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');
  
  select * from members;
#3 Question: Retrieve the product names and prices for products that were ordered more than twice.

SELECT m.product_name, m.price
FROM menu m
WHERE m.product_id IN (
    SELECT s.product_id
    FROM sales s
    GROUP BY s.product_id
    HAVING COUNT(*) > 2
);

#4 Question: Find the customer IDs of those customers who have ordered all the products from the menu.
SELECT customer_id
FROM (
    SELECT customer_id, COUNT(DISTINCT product_id) AS ordered_products
    FROM sales
    GROUP BY customer_id
) AS CustomerOrders
WHERE ordered_products = (
    SELECT COUNT(DISTINCT product_id)
    FROM menu
);

#5 Question: Retrieve the customer IDs and their corresponding join dates who have never placed an order.
SELECT m.customer_id, m.join_date
FROM members m
LEFT JOIN sales s ON m.customer_id = s.customer_id
WHERE s.customer_id IS NULL;


#1 Question: What is the total amount each customer spent at the restaurant?

SELECT customer_id, SUM(price) AS total_spent
FROM sales 
JOIN menu ON sales.product_id = menu.product_id
GROUP BY customer_id;

#2 How many days has each customer visited the restaurant?
SELECT customer_id, COUNT(DISTINCT order_date) AS visit_days
FROM sales
GROUP BY customer_id;

  #3 What was the first item from the menu purchased by each customer?
  SELECT s.customer_id, m.product_name AS first_purchased_item
FROM (
    SELECT customer_id, MIN(order_date) AS first_order_date
    FROM sales
    GROUP BY customer_id
) AS first_orders
JOIN sales s ON first_orders.customer_id = s.customer_id AND first_orders.first_order_date = s.order_date
JOIN menu m ON s.product_id = m.product_id;


