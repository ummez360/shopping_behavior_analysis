CREATE TABLE shopping_data (
    Customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    Age INT,
    Gender VARCHAR(10),
    ItemPurchased VARCHAR(100),
    Category VARCHAR(50),
    PurchaseAmountUSD INT,
    Location VARCHAR(50),
    Size VARCHAR(10),
    Color VARCHAR(30),
    Season VARCHAR(20),
    ReviewRating DECIMAL(10,2),
    SubscriptionStatus VARCHAR(10),
    ShippingType VARCHAR(50),
    DiscountApplied VARCHAR(10),
    PromoCodeUsed VARCHAR(10),
    PreviousPurchases INT,
    PaymentMethod VARCHAR(50),
    FrequencyOfPurchases VARCHAR(50)
);

select * from shopping_data limit 10;

-- Easy level Queries 
-- 1.Total Number of Customers
SELECT COUNT(DISTINCT(Customer_ID)) as Total_customers FROM shopping_data;

-- 2.Average Purchase Amount
SELECT ROUND(AVG(PurchaseAmountUSD),2) as avg_purchase_amount from shopping_data;

-- 3. Number of Purchases by Gender
SELECT GENDER, COUNT(*) AS purchase_count FROM shopping_data GROUP BY GENDER;

-- 4. Count of Customers by Frequency of Purchase
SELECT FrequencyOfPurchases, COUNT(*) AS customer_count  
FROM shopping_data  
GROUP BY FrequencyOfPurchases  
ORDER BY customer_count DESC;

-- Moderate level Queries
-- 5. Average Purchase Amount per Category
SELECT Category, ROUND(AVG(PurchaseAmountUSD), 2) AS avg_category_purchase  
FROM shopping_data  
GROUP BY Category  
ORDER BY avg_category_purchase DESC;

-- 6. CTE: Top 5 Customers by Total Purchase Amount
WITH customer_totals AS (
    SELECT Customer_ID, SUM(PurchaseAmountUSD) AS total_spent  
    FROM shopping_data  
    GROUP BY Customer_ID
)
SELECT Customer_ID, total_spent  
FROM customer_totals  
ORDER BY total_spent DESC  
LIMIT 5;

-- 7. Most Popular Color per Category
SELECT Category, Color, COUNT(*) AS color_count  
FROM shopping_data  
GROUP BY Category, Color  
ORDER BY Category, color_count DESC;

-- 8. Distribution of Frequency of Purchase by Gender
SELECT Gender, FrequencyOfPurchases, COUNT(*) AS count  
FROM shopping_data  
GROUP BY Gender, FrequencyOfPurchases  
ORDER BY Gender, count DESC;

-- 9. Average Purchase Amount by Frequency of Purchase
SELECT FrequencyOfPurchases, ROUND(AVG(PurchaseAmountUSD), 2) AS avg_purchase_amount  
FROM shopping_data  
GROUP BY FrequencyOfPurchases  
ORDER BY avg_purchase_amount DESC;



--  Hard Level Queries
-- 10. CTE + Window Function: Rank Customers by Total Spending
WITH customer_spending AS (
    SELECT Customer_ID, SUM(PurchaseAmountUSD) AS total_spent  
    FROM shopping_data  
    GROUP BY Customer_ID
)
SELECT Customer_ID, total_spent,  
       DENSE_RANK() OVER (ORDER BY total_spent DESC) AS spending_rank  
FROM customer_spending;

-- 11. CTE – Average Purchase Amount by Season and Gender
WITH season_gender_avg AS (
    SELECT Season, Gender, AVG(PurchaseAmountUSD) AS avg_amount  
    FROM shopping_data  
    GROUP BY Season, Gender
)
SELECT * FROM season_gender_avg  
ORDER BY Season, Gender;

-- 12. CTE Example – Most Common Frequency of Purchase
WITH freq_counts AS (
    SELECT FrequencyOfPurchases, COUNT(*) AS freq_count  
    FROM shopping_data  
    GROUP BY FrequencyOfPurchases
)
SELECT FrequencyOfPurchases  
FROM freq_counts  
ORDER BY freq_count DESC  
LIMIT 1;
