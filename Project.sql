SELECT * FROM zepto;

DROP TABLE IF EXISTS zepto

CREATE TABLE zepto(
sku_id SERIAL PRIMARY KEY,
Category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock Boolean,
quantity INTEGER
);

--Data exploration

--count of rows
SELECT COUNT(*) FROM zepto;

--sample data
SELECT * FROM zepto;

--null values
SELECT * FROM zepto 
WHERE name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountPercent IS NULL
OR
availableQuantity IS NULL
OR
discountedSellingPrice IS NULL
OR
weightInGms IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL;

--different product categories
SELECT DISTINCT category 
FROM zepto
ORDER BY category;

--products in stock vs out of stock
SELECT outOfStock, COUNT(sku_id)  
FROM zepto
GROUP BY outOfStock;

--product names present multiple times
SELECT name, COUNT(sku_id) AS "Number of SKU's"
FROM zepto
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY COUNT(sku_id) DESC;

--data cleaning

--products with price = 0
SELECT * FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

DELETE FROM zepto
WHERE mrp = 0;

--convert paise to rupees
UPDATE zepto
SET mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;

SELECT name, mrp, discountedSellingPrice FROM zepto;

--Business questions

--Q1. Find the top 10 best-value products based on the discount percentage.

SELECT DISTINCT name, mrp, discountedSellingPrice, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

--Q2. What are the products with high MRP but out of stock?

SELECT DISTINCT name, mrp, outOfStock
FROM zepto
WHERE outOfStock = true
ORDER BY mrp DESC;

--Q3. Calculate estimated revenue for each category.

SELECT category, SUM(discountedSellingPrice * availableQuantity) AS Estimated_Revenue
FROM zepto
GROUP BY category 
ORDER BY Estimated_Revenue;

--Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.

SELECT DISTINCT name, mrp, discountPercent 
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

--Q5. Identify the top 5 categories offering the highest average discount percentage.

SELECT category, ROUND(AVG(discountPercent),2) AS average_discount_percentage
FROM zepto
GROUP BY category
ORDER BY average_discount_percentage DESC
LIMIT 5;

--Q6. Find the price per gram for products above 100g and sort by best value.

SELECT DISTINCT name, ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram;

--Q7. Group the products into categories like Low, Medium, Bulk.

SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
	WHEN weightInGms < 5000 THEN 'Medium'
	ELSE 'bulk'
	END AS weight_category
FROM zepto;

--Q8. What is the total inventory weight per category?

SELECT category, SUM(weightInGms * availableQuantity) AS total_inventory_weight_per_category
FROM zepto
GROUP BY category
ORDER BY total_inventory_weight_per_category;