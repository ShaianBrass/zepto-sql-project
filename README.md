# 🛒 SQL Data Analysis Project – E-Commerce Inventory (Zepto Dataset)

## 📌 Project Overview
This project simulates how data analysts in e-commerce/retail use SQL to work with **messy real-world data**.  
Using **PostgreSQL**, I explored, cleaned, and analyzed a Zepto product dataset to extract **business-driven insights** around pricing, inventory, and revenue.

---

## 📂 Dataset Overview
- **Source:** Kaggle – Zepto Products Dataset  
- **Rows:** ~3,452 product SKUs (rows may vary depending on version)  
- **Columns:**
  - `sku_id` – Unique product identifier  
  - `name` – Product name  
  - `category` – Product category (Fruits, Snacks, Beverages, etc.)  
  - `mrp` – Maximum Retail Price (₹, converted from paise)  
  - `discountPercent` – Discount applied  
  - `discountedSellingPrice` – Final price after discount (₹)  
  - `availableQuantity` – Units available in inventory  
  - `weightInGms` – Product weight in grams  
  - `outOfStock` – Stock status (boolean)  
  - `quantity` – Package count  

---

## 🔧 Project Workflow
1. **Database Setup** – Created PostgreSQL table with appropriate datatypes.  
2. **Data Import** – Imported CSV dataset (handled UTF-8 encoding issues).  
3. **Data Exploration** – Checked record counts, nulls, duplicates, stock distribution.  
4. **Data Cleaning** – Removed invalid rows (zero pricing), converted paise → rupees.  
5. **Business Insights** – Wrote SQL queries to answer real business questions.  

---

## 📊 Key SQL Queries & Insights

### 1️⃣ Top 10 Best-Value Products
```
SELECT DISTINCT name, mrp, discountedSellingPrice, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;
```
✔️ Identifies products with maximum customer savings.

### 2️⃣ High MRP but Out-of-Stock Products
```
SELECT DISTINCT name, mrp, outOfStock
FROM zepto
WHERE outOfStock = true
ORDER BY mrp DESC;
```
✔️ Useful for demand analysis & restocking decisions.

### 3️⃣ Estimated Revenue by Category
```
SELECT category, SUM(discountedSellingPrice * availableQuantity) AS Estimated_Revenue
FROM zepto
GROUP BY category 
ORDER BY Estimated_Revenue DESC;
```
✔️ Helps prioritize high-revenue categories.

### 4️⃣ Premium Products with Low Discounts
```
SELECT DISTINCT name, mrp, discountPercent 
FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;
```
✔️ Finds premium products with weak offers.

### 5️⃣ Top 5 Categories by Avg. Discount
```
SELECT category, ROUND(AVG(discountPercent),2) AS average_discount_percentage
FROM zepto
GROUP BY category
ORDER BY average_discount_percentage DESC
LIMIT 5;
```
✔️ Shows categories offering the best deals.

### 6️⃣ Price per Gram (Value-for-Money Check)
```
SELECT DISTINCT name, ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram ASC;
```
✔️ Helps compare true cost efficiency.

### 7️⃣ Product Weight Categorization
```
SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
     WHEN weightInGms < 5000 THEN 'Medium'
     ELSE 'Bulk' END AS weight_category
FROM zepto;
```
✔️ Classifies products into Low, Medium, Bulk packs.

### 8️⃣ Total Inventory Weight per Category
```
SELECT category, SUM(weightInGms * availableQuantity) AS total_inventory_weight_per_category
FROM zepto
GROUP BY category
ORDER BY total_inventory_weight_per_category DESC;
```
✔️ Useful for logistics & warehouse planning.

## 🛠 Tools & Skills

- SQL (PostgreSQL)

- Data Cleaning & Transformation

- Exploratory Data Analysis (EDA)

- Business-Driven Query Writing

## 🚀 Key Learnings

- Real-world datasets are messy → required cleaning & transformation.

- SQL is powerful for business-driven analysis (not just raw queries).

- Gained insights into pricing strategies, inventory health, and revenue optimization.
