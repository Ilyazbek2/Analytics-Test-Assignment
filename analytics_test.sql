-- ============================================
-- ANALYTICS TEST ASSIGNMENT
-- SQL SOLUTIONS
-- ============================================


-- ============================================
-- 1. MAU
-- Monthly Active Users
-- ============================================

SELECT COUNT(DISTINCT user_id) AS MAU
FROM auditory_data
WHERE date >= '2023-11-01'
  AND date < '2023-12-01';


-- ============================================
-- 2. DAU
-- Daily Active Users
-- ============================================

SELECT COUNT(DISTINCT user_id) AS DAU
FROM auditory_data
WHERE date = '2023-11-01';


-- ============================================
-- 3. D1 RETENTION
-- Users who returned on the next day
-- ============================================

SELECT ROUND(
    100.0 * COUNT(DISTINCT b.user_id)
    / COUNT(DISTINCT a.user_id),
    1
) AS retention_d1
FROM auditory_data AS a
LEFT JOIN auditory_data AS b
    ON a.user_id = b.user_id
    AND b.date = '2023-11-02'
WHERE a.date = '2023-11-01';


-- ============================================
-- 4. AVERAGE DAU
-- Average daily active users
-- ============================================

SELECT ROUND(AVG(dau)) AS average_dau
FROM (
    SELECT
        date,
        COUNT(DISTINCT user_id) AS dau
    FROM auditory_data
    GROUP BY date
) AS daily_activity;


-- ============================================
-- 5. USER CONVERSION TO AD VIEW
-- November
-- ============================================

SELECT
    ROUND(
        100.0 * COUNT(DISTINCT CASE
            WHEN view_adverts > 0 THEN user_id
        END)
        / COUNT(DISTINCT user_id),
        1
    ) AS conversion_rate
FROM auditory_data
WHERE date >= '2023-11-01'
  AND date < '2023-12-01';


-- ============================================
-- 6. AVERAGE VIEWED ADVERTS PER USER
-- November
-- ============================================

SELECT
    ROUND(
        SUM(view_adverts) /
        COUNT(DISTINCT user_id),
        2
    ) AS avg_viewed_adverts
FROM auditory_data
WHERE date >= '2023-11-01'
  AND date < '2023-12-01';
