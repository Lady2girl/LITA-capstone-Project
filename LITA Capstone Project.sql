USE retailstoredata;
-- Retrieve the Total Sales for Each Product Category
SELECT 
    Product,
    SUM(Quantity * UnitPrice) AS TotalSales
FROM 
    salesdata
GROUP BY 
    Product;
    -- 2. Find the number of sales transactions in each region
SELECT 
    Region,
    COUNT(OrderID) AS SalesTransactions
FROM 
    salesdata
GROUP BY 
    Region;
    -- 3. Find the highest-selling product by total sales value
SELECT 
    Product,
    SUM(Quantity * UnitPrice) AS TotalSales
FROM 
    salesdata
GROUP BY 
    Product
ORDER BY 
    TotalSales DESC
LIMIT 1;
-- 4. Calculate total revenue per product
SELECT 
    Product,
    SUM(Quantity * UnitPrice) AS TotalRevenue
FROM 
    salesdata
GROUP BY 
    Product;

-- 5. Calculate monthly sales totals for the current year
SELECT 
    MONTH(OrderDate) AS Month,
    SUM(Quantity * UnitPrice) AS MonthlySalesTotal
FROM 
    salesdata
WHERE 
    YEAR(OrderDate) = YEAR(CURDATE())
GROUP BY 
    MONTH(OrderDate)
ORDER BY 
    Month;

-- 6. Find the top 5 customers by total purchase amount
SELECT 
    CustomerId,
    SUM(Quantity * UnitPrice) AS TotalPurchaseAmount
FROM 
    salesdata
GROUP BY 
    CustomerId
ORDER BY 
    TotalPurchaseAmount DESC
LIMIT 5;

-- 7. Calculate the percentage of total sales contributed by each region
SELECT 
    Region,
    SUM(Quantity * UnitPrice) AS RegionSales,
    (SUM(Quantity * UnitPrice) / (SELECT SUM(Quantity * UnitPrice) FROM salesdata) * 100) AS SalesPercentage
FROM 
    salesdata
GROUP BY 
    Region;

-- 8. Identify products with no sales in the last quarter
SELECT 
    Product
FROM 
    salesdata
WHERE 
    OrderDate < DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
GROUP BY 
    Product
HAVING 
    SUM(Quantity) = 0;


-- 1. Retrieve the total number of customers from each region
SELECT 
    Region,
    COUNT(CustomerID) AS TotalCustomers
FROM 
    customerdata
GROUP BY 
    Region;

-- 2. Find the most popular subscription type by the number of customers
SELECT 
    SubscriptionType,
    COUNT(CustomerID) AS CustomerCount
FROM 
    customerdata
GROUP BY 
    SubscriptionType
ORDER BY 
    CustomerCount DESC
LIMIT 1;

-- 3. Find customers who canceled their subscription within 6 months
SELECT 
    CustomerID,
    CustomerName,
    SubscriptionStart,
    SubscriptionEnd,
    Canceled
FROM 
    customerdata
WHERE 
    Canceled = 'Yes'
    AND DATEDIFF(SubscriptionEnd, SubscriptionStart) <= 180;

-- 4. Calculate the average subscription duration for all customers
SELECT 
    AVG(DATEDIFF(SubscriptionEnd, SubscriptionStart)) AS AvgSubscriptionDurationDays
FROM 
    customerdata;

-- 5. Find customers with subscriptions longer than 12 months
SELECT 
    CustomerID,
    CustomerName,
    SubscriptionStart,
    SubscriptionEnd
FROM 
    customerdata
WHERE 
    DATEDIFF(SubscriptionEnd, SubscriptionStart) > 365;

-- 6. Calculate total revenue by subscription type
SELECT 
    SubscriptionType,
    SUM(Revenue) AS TotalRevenue
FROM 
    customerdata
GROUP BY 
    SubscriptionType;

-- 7. Find the top 3 regions by subscription cancellations
SELECT 
    Region,
    COUNT(CustomerID) AS Cancellations
FROM 
    customerdata
WHERE 
    Canceled = 'Yes'
GROUP BY 
    Region
ORDER BY 
    Cancellations DESC
LIMIT 3;

-- 8. Find the total number of active and canceled subscriptions
SELECT 
    Canceled,
    COUNT(CustomerID) AS SubscriptionCount
FROM 
    customerdata
GROUP BY 
    Canceled;



