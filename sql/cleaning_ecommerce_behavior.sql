

-- Menampilkan dataset raw
SELECT *
FROM
`cleaning-ecommerce-behavior.ecommerce_behavior_cleaning.ecommerce_behavior_raw`

-- Menampilkan total rows dari dataset raw
SELECT COUNT(*) AS total_rows
FROM
`cleaning-ecommerce-behavior.ecommerce_behavior_cleaning.ecommerce_behavior_raw`

-- Menampilkan tipe data setiap kolom
SELECT 
  column_name, 
  data_type
FROM 
  `cleaning-ecommerce-behavior.ecommerce_behavior_cleaning.INFORMATION_SCHEMA.COLUMNS`
WHERE 
  table_name = 'ecommerce_behavior_raw'

-- Standarisasi data dan mengubah tipe data
CREATE OR REPLACE TABLE
`cleaning-ecommerce-behavior.ecommerce_behavior_cleaning.ecommerce_behavior_cleaned`
AS

SELECT
    -- Customer ID
    TRIM(CAST(`Customer ID` AS STRING)) AS Customer_ID,
    -- Gender
    INITCAP(TRIM(Gender)) AS Gender,
    -- Age
    TRIM(CAST(Age AS STRING)) AS Age,
    -- City
    INITCAP(TRIM(City)) AS City,
    -- Membership Type
    INITCAP(TRIM(`Membership Type`)) AS Membership_Type,
    -- Total Spend
    CAST(`Total Spend` AS NUMERIC) AS Total_Spend,
    -- Items Purchased
    CAST(`Items Purchased` AS INT64) AS Items_Purchased,
    -- Average Rating
    CAST(`Average Rating` AS NUMERIC) AS Average_Rating,
    -- Discount Applied
    CAST(`Discount Applied` AS BOOL) AS Discount_Applied,
    -- Days Since Last Purchase
    CAST(`Days Since Last Purchase` AS INT64) AS Days_Since_Last_Purchase,
    -- Satisfaction Level
    INITCAP(TRIM(`Satisfaction Level`)) AS Satisfaction_Level
FROM
`cleaning-ecommerce-behavior.ecommerce_behavior_cleaning.ecommerce_behavior_raw`
WHERE
    -- Customer ID
    NULLIF(TRIM(CAST(`Customer ID` AS STRING)), '') IS NOT NULL
    -- Gender
    AND NULLIF(TRIM(Gender), '') IS NOT NULL
    -- Age
    AND NULLIF(TRIM(CAST(Age AS STRING)), '') IS NOT NULL
    -- City
    AND NULLIF(TRIM(City), '') IS NOT NULL
    -- Membership Type
    AND NULLIF(TRIM(`Membership Type`), '') IS NOT NULL
    -- Total Spend
    AND `Total Spend` IS NOT NULL
    -- Items Purchased
    AND `Items Purchased` IS NOT NULL
    -- Average Rating
    AND `Average Rating` IS NOT NULL
    -- Discount Applied
    AND `Discount Applied` IS NOT NULL
    -- Days Since Last Purchase
    AND `Days Since Last Purchase` IS NOT NULL
    -- Satisfaction Level
    AND NULLIF(TRIM(`Satisfaction Level`), '') IS NOT NULL

-- Menampilkan dataset yang sudah di cleaning
SELECT *
FROM
`cleaning-ecommerce-behavior.ecommerce_behavior_cleaning.ecommerce_behavior_cleaned`

-- Cek kembali tipe data dari setiap kolom
SELECT 
  column_name, 
  data_type
FROM 
  `cleaning-ecommerce-behavior.ecommerce_behavior_cleaning.INFORMATION_SCHEMA.COLUMNS`
WHERE 
  table_name = 'ecommerce_behavior_cleaned'

-- Cek total rows setelah di cleaning
SELECT COUNT(*) AS total_rows
FROM
`cleaning-ecommerce-behavior.ecommerce_behavior_cleaning.ecommerce_behavior_cleaned`

-- Cek duplikat full rows
SELECT
    *,
    COUNT(*) AS duplicate_count
FROM
`cleaning-ecommerce-behavior.ecommerce_behavior_cleaning.ecommerce_behavior_cleaned`
GROUP BY ALL
HAVING COUNT(*) > 1

-- Cek Distinct Value
SELECT DISTINCT Gender
FROM
`cleaning-ecommerce-behavior.ecommerce_behavior_cleaning.ecommerce_behavior_cleaned`

--
SELECT DISTINCT Membership_Type
FROM
`cleaning-ecommerce-behavior.ecommerce_behavior_cleaning.ecommerce_behavior_cleaned`

--
SELECT DISTINCT Satisfaction_Level
FROM
`cleaning-ecommerce-behavior.ecommerce_behavior_cleaning.ecommerce_behavior_cleaned`

-- Cek Outlier
-- Age
SELECT
    MIN(CAST(Age AS INT64)) AS min_age,
    MAX(CAST(Age AS INT64)) AS max_age
FROM
`cleaning-ecommerce-behavior.ecommerce_behavior_cleaning.ecommerce_behavior_cleaned`

-- Total Spend
SELECT
    MIN(Total_Spend) AS min_spend,
    MAX(Total_Spend) AS max_spend
FROM
`cleaning-ecommerce-behavior.ecommerce_behavior_cleaning.ecommerce_behavior_cleaned`

-- Membuat Final Table dari hasil cleaning
CREATE OR REPLACE TABLE
`cleaning-ecommerce-behavior.ecommerce_behavior_cleaning.ecommerce_behavior_final`
AS
SELECT *
FROM
`cleaning-ecommerce-behavior.ecommerce_behavior_cleaning.ecommerce_behavior_cleaned`



