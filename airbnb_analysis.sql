-- =========================================================
-- Airbnb Dataset Analysis Project (SQLite)
-- Author : Anup Singh
-- Project : Airbnb Data Analysis using SQL
-- =========================================================

-- =========================================================
-- BASIC DATA EXPLORATION
-- =========================================================

-- View all listing IDs
SELECT id
FROM airbnb_dataset;

-- Total number of records
SELECT COUNT(*) AS total_records
FROM airbnb_dataset;

-- Total Listings
SELECT COUNT(*) AS total_listings
FROM airbnb_dataset;

-- Average Price of Listings
SELECT ROUND(AVG(price),2) AS average_price
FROM airbnb_dataset;

-- Highest and Lowest Price
SELECT MAX(price) AS highest_price,
       MIN(price) AS lowest_price
FROM airbnb_dataset;

-- Missing Review Dates
SELECT COUNT(*) AS missing_review_dates
FROM airbnb_dataset
WHERE last_review IS NULL;


-- =========================================================
-- PRICING ANALYSIS
-- =========================================================

-- Average Price Across Neighbourhoods
SELECT neighbourhood_gr,
       neighbourhood,
       ROUND(AVG(price),2) AS avg_price
FROM airbnb_dataset
GROUP BY neighbourhood_gr, neighbourhood
ORDER BY avg_price DESC;

-- Insights:
-- New Dorp and Chelsea have the highest average prices
-- Woodside has the lowest average price

-- Properties Giving Highest Prices in New Dorp and Chelsea
SELECT id,
       name,
       neighbourhood,
       price
FROM airbnb_dataset
WHERE neighbourhood IN ('New Dorp', 'Chelsea, Staten Island')
ORDER BY price DESC;

-- Most Expensive Listings
SELECT name,
       neighbourhood_gr,
       price
FROM airbnb_dataset
ORDER BY price DESC
LIMIT 10;

-- Average Price by Room Type
SELECT room_type,
       ROUND(AVG(price),2) AS avg_price
FROM airbnb_dataset
GROUP BY room_type
ORDER BY avg_price DESC;

-- Average Price by Borough
SELECT neighbourhood_gr,
       ROUND(AVG(price),2) AS avg_price
FROM airbnb_dataset
GROUP BY neighbourhood_gr
ORDER BY avg_price DESC;


-- =========================================================
-- ROOM TYPE ANALYSIS
-- =========================================================

-- Room Type Popularity and Ratings
SELECT room_type,
       COUNT(id) AS total_properties,
       ROUND(AVG(review_rate_numb),3) AS avg_rating,
       ROUND(AVG(price),2) AS avg_price
FROM airbnb_dataset
GROUP BY room_type
ORDER BY total_properties DESC;

-- Insights:
-- Hosts prefer listing Entire Home/Apartments
-- Customers give better ratings to Hotel Rooms
-- Hotel Rooms are generally more expensive

-- Listings by Room Type
SELECT room_type,
       COUNT(*) AS total_listings
FROM airbnb_dataset
GROUP BY room_type;


-- =========================================================
-- REVIEW & RATING ANALYSIS
-- =========================================================

-- Most Reviewed Listings
SELECT name,
       neighbourhood_gr,
       number_of_review
FROM airbnb_dataset
ORDER BY number_of_review DESC
LIMIT 10;

-- Average Rating by Room Type
SELECT room_type,
       ROUND(AVG(review_rate_numb),2) AS avg_rating
FROM airbnb_dataset
GROUP BY room_type
ORDER BY avg_rating DESC;

-- Listings with Perfect Ratings
SELECT name,
       neighbourhood_gr,
       review_rate_numb
FROM airbnb_dataset
WHERE review_rate_numb = 5
LIMIT 20;


-- =========================================================
-- HOST ANALYSIS
-- =========================================================

-- Hosts with Most Listings
SELECT host_name,
       COUNT(*) AS total_properties
FROM airbnb_dataset
GROUP BY host_name
ORDER BY total_properties DESC
LIMIT 10;

-- Verified vs Unverified Hosts
SELECT host_identity_ve,
       COUNT(*) AS total_hosts
FROM airbnb_dataset
GROUP BY host_identity_ve;

-- Average Rating of Verified Hosts
SELECT host_identity_ve,
       ROUND(AVG(review_rate_numb),2) AS avg_rating
FROM airbnb_dataset
GROUP BY host_identity_ve;


-- =========================================================
-- REVENUE ANALYSIS
-- =========================================================

-- Estimated Revenue by Borough
SELECT neighbourhood_gr,
       ROUND(SUM(price * availability_365),2) AS estimated_revenue
FROM airbnb_dataset
GROUP BY neighbourhood_gr
ORDER BY estimated_revenue DESC;

-- Estimated Revenue by Room Type
SELECT room_type,
       ROUND(SUM(price * availability_365),2) AS estimated_revenue
FROM airbnb_dataset
GROUP BY room_type
ORDER BY estimated_revenue DESC;

-- Most Profitable Listings
SELECT name,
       neighbourhood_gr,
       ROUND(price * availability_365,2) AS estimated_revenue
FROM airbnb_dataset
ORDER BY estimated_revenue DESC
LIMIT 10;

-- =========================================================
-- END OF PROJECT
-- =========================================================