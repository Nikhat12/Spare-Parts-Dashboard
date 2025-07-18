CREATE DATABASE spare_parts_sales;
USE spare_parts_sales;
## product table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    vehicle_type VARCHAR(10),
    unit_price DECIMAL(10,2),
    stock_qty INT
);
## customer table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    region_id INT,
    customer_type VARCHAR(20),
    email VARCHAR(100)
);
##region table
CREATE TABLE regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(50)
);
## order table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);
## order_item table
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    total_price DECIMAL(10,2)
);
SELECT * FROM customers LIMIT 10;
#Total sales
select sum(total_price) as total_sales from order_items;

#Monthly sales trend
SELECT 
    DATE_FORMAT(o.order_date, "%y-%m") AS month,
    SUM(oi.total_price) AS monthly_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_date, "%y-%m")
ORDER BY month;

##  Top 5 Best Selling Products
select p.product_name, sum(oi.quantity)as total_quantity_sold
from order_items oi
join products p on oi.product_id = p.product_id
group by p.product_name
order by total_quantity_sold desc
limit 5;

##  Sales by Region
select r.region_name,sum(oi.total_price) as region_sales from orders o
join customers c on o.customer_id= c.customer_id
join regions r on c.region_id=r.region_id
join order_items oi on o.order_id = oi.order_id
group by r.region_name
order by region_sales desc;

## Sales by Category
select p.category, sum(oi.total_price) as category_sales from order_items oi
join products p on oi.product_id = p.product_id
group by p.category
order by category_sales desc;

##  Customer Type-wise Sales
SELECT 
    c.customer_type,
    SUM(oi.total_price) AS sales
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_type;














