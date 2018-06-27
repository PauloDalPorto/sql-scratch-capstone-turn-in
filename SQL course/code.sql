Name: Paulo Porto
Course: Learn SQL from Scratch
Project: "Usage Funnels with Warby Parker"

/////////////////////////////////////


-- Style Quiz funnels

SELECT *
FROM survey
LIMIT 10;

-- Total responses per questions

SELECT question, COUNT (response) AS number_responses
FROM survey
GROUP BY question;

-- Transition rates

SELECT question, COUNT (user_id) 
FROM survey
GROUP BY question;

-- Home Try-On Table

SELECT *
FROM quiz
LIMIT 5;

SELECT *
FROM home_try_on
LIMIT 5;

SELECT *
FROM purchase
LIMIT 5;

-- Home Try-On Table

SELECT DISTINCT q.user_id,
CASE WHEN
   h.user_id IS NOT NULL
   THEN 'True’
   ELSE 'False’
   END AS 'is_home_try_on',
h.number_of_pairs,
 CASE WHEN
   p.user_id IS NOT NULL
   THEN 'True’
   ELSE 'False’
   END AS 'is_purchase'
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h'
   ON q.user_id = h.user_id
LEFT JOIN purchase AS 'p'
   ON p.user_id = q.user_id
LIMIT 10;

-- Conversion rate

WITH funnels AS (SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h'
   ON q.user_id = h.user_id
LEFT JOIN purchase AS 'p'
   ON p.user_id = q.user_id)
SELECT 
CASE WHEN 
is_home_try_on = 1 
THEN 'True'
ELSE 'False'
END AS "Users_Tried",
number_of_pairs,
CASE WHEN 
is_purchase = 1
THEN 'True'
ELSE 'False'
END AS "Users_Purchased"
FROM funnels;

-- 3-pairs vs 5-pairs

WITH funnels AS (SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h'
   ON q.user_id = h.user_id
LEFT JOIN purchase AS 'p'
   ON p.user_id = q.user_id)
SELECT DISTINCT user_id,
CASE WHEN 
is_home_try_on = 1 
THEN 'True'
ELSE 'False'
END AS "Users_Tried",
number_of_pairs,
CASE WHEN 
is_purchase = 1
THEN 'True'
ELSE 'False'
END AS "Users_Purchased"
FROM funnels;

-- Brands sold

SELECT DISTINCT model_name, SUM (price) AS price
FROM purchase
GROUP BY model_name;

-- Sales per brand

SELECT DISTINCT style, COUNT (user_id)
FROM purchase
GROUP BY style;


-- 3-pair vs 5 pair vs Brands

WITH funnels AS (SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL AS 'is_purchase',
   p.style AS 'purchased_style',
   p.model_name AS 'purchased_model',
   p.price AS 'purchased_price'
FROM quiz AS 'q'
LEFT JOIN home_try_on AS 'h'
   ON q.user_id = h.user_id
LEFT JOIN purchase AS 'p'
   ON p.user_id = q.user_id)
SELECT DISTINCT user_id,
purchased_price,purchased_model,
number_of_pairs,
CASE WHEN 
is_purchase = 1
THEN 'True'
ELSE 'False'
END AS "Users_Purchased"
FROM funnels;


