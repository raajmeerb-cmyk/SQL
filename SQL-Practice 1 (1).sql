/* ============================================================
   PRACTICE FILE: AGGREGATE FUNCTIONS & TEXT FUNCTIONS
   Table: Products
   Instructions: Write the SQL query below each question.
   ============================================================ */
create database practice_1;
use practice_1;

/* ------------------------------------------------------------
   STEP 1: CREATE TABLE
   ------------------------------------------------------------ */

CREATE TABLE Products (
    product_id INT,
    product_name VARCHAR(50),
    category VARCHAR(50),
    city VARCHAR(50),
    price INT,
    description VARCHAR(100)
);


/* ------------------------------------------------------------
   STEP 2: INSERT DATA
   ------------------------------------------------------------ */

INSERT INTO Products VALUES
(1, 'wireless mouse', 'Electronics', 'Bangalore', 799, 'compact wireless mouse'),
(2, 'Office Chair', 'Furniture', 'Delhi', 4500, 'ergonomic office chair'),
(3, 'BLUETOOTH SPEAKER', 'Electronics', 'Bangalore', 2200, 'portable bluetooth speaker'),
(4, 'Study Table', 'Furniture', 'Mumbai', 3800, 'wooden study table'),
(5, 'laptop stand', 'Electronics', 'Pune', 1200, 'adjustable laptop stand'),
(6, 'Bookshelf', 'Furniture', 'Delhi', 3200, 'wall mounted bookshelf'),
(7, 'Table Lamp', 'Electronics', 'Mumbai', 950, 'LED table lamp'),
(8, '  Yoga Mat  ', 'Fitness', 'Bangalore', 600, 'non-slip yoga mat');


/* ============================================================
   SECTION A: AGGREGATE FUNCTIONS
   ============================================================ */

-- Q1. Find the total number of products.
select count(product_name) from products;


-- Q2. Find the total value of all products (sum of prices).
select product_name,sum(price) 
from products 
group by product_name;


-- Q3. Find the average price of products.
select product_name,avg(price)
from products
group by product_name;


-- Q4. Find the most expensive and least expensive product price.
select max(price) as max_exp,min(price) as lest_exp
from products;

-- Q5. Find how many products exist in each category.
select category,count(product_id) as total_count
from products
group by category;

-- Q6. Find the average price per city.
select city,avg(price) as average_price
from products
group by city;

-- Q7. Find categories where the average price is more than 2000.
select category,avg(price) as average_price
from products
group by category
having average_price > 2000;

-- Q8. Find the total price of products per city, sorted from highest to lowest.
select city,sum(price) as total_price
from products
group by city
order by total_price desc;

-- Q9. Find the number of distinct cities the products are available in.
select distinct city as distinct_city
from products;


/* ============================================================
   SECTION B: TEXT FUNCTIONS
   ============================================================ */

-- Q1. Display all product names in uppercase and lowercase.
select product_name,upper(product_name) as upperacse ,lower(product_name) as lowercase
from products;

-- Q2. Remove the extra spaces from the product_name column and display the cleaned result.
select product_name,trim(product_name) as trimed_product_name
from products;

-- Q3. Find the length of each product_name (after removing spaces).
select trim(product_name) as trimed_product_name,length(trim(product_name)) as length
from products;

-- Q4. Extract the first 5 characters of each description.
select description, substring(description,1,5) as first_5_letters
from products;

-- Q5. Combine product_name and category into a single column separated by a hyphen.
select product_name,category,concat(product_name,"/",category) as combined_name
from products;

-- Q6. Replace the word 'table' with 'desk' in the description column.
select description,replace(description,"table","desk") as replaced_name
from products;

-- Q7. Convert each product_name into proper case (first letter capital, rest lowercase).
select product_name,concat(upper(substring(product_name,1,1)),lower(substring(product_name,2)))
from products;

-- Q8. Find all products whose description contains the word 'wireless'.
SELECT 
    product_name
FROM
    products
WHERE
    description LIKE '%wireless%';


-- Q9. Find all products whose product_name starts with the letter 'B' (case-insensitive).
SELECT 
    product_name
FROM
    products
WHERE
    SUBSTRING(product_name, 1, 1) LIKE '%B%';
