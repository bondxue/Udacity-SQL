---SUM---
SELECT SUM(poster_qty)
FROM orders;

SELECT SUM(standard_qty)
FROM orders;

SELECT SUM(total_amt_usd)
FROM orders;

SELECT standard_amt_usd + gloss_amt_usd
FROM orders;

SELECT SUM(standard_amt_usd) / SUM(standard_qty) unit_price
FROM orders;

---MIN MAX AVERAGE---
SELECT MIN(occurred_at)
FROM orders;

SELECT occurred_at
FROM orders
ORDER BY occurred_at
LIMIT 1;

SELECT MAX(occurred_at)
FROM web_events;

SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;

SELECT AVG(standard_qty),
       AVG(gloss_qty),
       AVG(poster_qty),
       AVG(standard_amt_usd),
       AVG(gloss_amt_usd),
       AVG(poster_amt_usd)
FROM orders;

---GROUP BY---
SELECT a.name, MIN(o.occurred_at) ealiest_occurred_at
FROM accounts a
         JOIN orders o
              ON a.id = o.account_id
GROUP BY a.name
ORDER BY ealiest_occurred_at
LIMIT 1;

SELECT a.name, SUM(total_amt_usd)
FROM accounts a
         JOIN orders o
              ON a.id = o.account_id
GROUP BY a.name;

SELECT a.name, w.occurred_at, w.channel
FROM web_events w
         JOIN accounts a
              ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1;

SELECT w.channel, COUNT(w.occurred_at)
FROM web_events w
GROUP BY w.channel;

SELECT a.primary_poc, w.occurred_at
FROM web_events w
         JOIN accounts a
              ON w.account_id = a.id
ORDER BY w.occurred_at
LIMIT 1;

SELECT a.name, MIN(total_amt_usd) min_total_amt_usd
FROM accounts a
         JOIN orders o
              ON a.id = o.account_id
GROUP BY a.name
ORDER BY min_total_amt_usd;

SELECT COUNT(r.id) num_sales_reps, r.name
FROM region r
         JOIN sales_reps sr
              ON r.id = sr.region_id
GROUP BY r.name
ORDER BY num_sales_reps;


---GROUP BY II---
SELECT a.name, AVG(o.standard_qty), AVG(o.gloss_qty), AVG(o.poster_qty)
FROM accounts a
         JOIN orders o
              ON a.id = o.account_id
GROUP BY a.name

SELECT a.name,
       AVG(o.standard_amt_usd) avg_stand,
       AVG(o.gloss_amt_usd)    avg_gloss,
       AVG(o.poster_amt_usd)   avg_post
FROM accounts a
         JOIN orders o
              ON a.id = o.account_id
GROUP BY a.name;

SELECT sr.name, w.channel, COUNT(w.occurred_at) num_occurred
FROM web_events w
         JOIN accounts a
              ON w.account_id = a.id
         JOIN sales_reps sr
              ON a.sales_rep_id = sr.id
GROUP BY sr.name, w.channel
ORDER BY sr.name, num_occurred DESC;

SELECT r.name, w.channel, COUNT(w.occurred_at) num_occurred
FROM web_events w
         JOIN accounts a
              ON w.account_id = a.id
         JOIN sales_reps sr
              ON a.sales_rep_id = sr.id
         JOIN region r
              ON sr.region_id = r.id
GROUP BY r.name, w.channel
ORDER BY r.name, num_occurred DESC;

---DISTINCT---
SELECT DISTINCT a.name, r.name
FROM accounts a
         JOIN sales_reps sr
              ON a.sales_rep_id = sr.id
         JOIN region r
              ON sr.region_id = r.id;

SELECT a.name, sr.name
FROM accounts a
         JOIN sales_reps sr
              ON a.sales_rep_id = sr.id

---HAVING---
SELECT sr.name, COUNT(a.*)
FROM accounts a
         JOIN sales_reps sr
              ON a.sales_rep_id = sr.id
GROUP BY sr.name
HAVING COUNT(a.*) > 5;

SELECT a.name, COUNT(o.*)
FROM accounts a
         JOIN orders o
              ON a.id = o.account_id
GROUP BY a.name
HAVING COUNT(o.*) > 20;

SELECT a.name, COUNT(o.*)
FROM accounts a
         JOIN orders o
              ON a.id = o.account_id
GROUP BY a.name
ORDER BY COUNT(o.*) DESC
LIMIT 1;

SELECT a.name, SUM(o.total_amt_usd)
FROM accounts a
         JOIN orders o
              ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) > 30000;

SELECT a.name, SUM(o.total_amt_usd)
FROM accounts a
         JOIN orders o
              ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total_amt_usd) < 1000;

SELECT a.name, SUM(o.total_amt_usd)
FROM accounts a
         JOIN orders o
              ON a.id = o.account_id
GROUP BY a.name
ORDER BY SUM(o.total_amt_usd) DESC
LIMIT 1;

SELECT a.name, SUM(o.total_amt_usd)
FROM accounts a
         JOIN orders o
              ON a.id = o.account_id
GROUP BY a.name
ORDER BY SUM(o.total_amt_usd)
LIMIT 1;

SELECT a.name, w.channel, COUNT(w.channel)
FROM accounts a
         JOIN web_events w
              ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.name, w.channel
HAVING COUNT(w.channel) > 6;

SELECT a.name, w.channel, COUNT(w.channel)
FROM accounts a
         JOIN web_events w
              ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.name, w.channel
HAVING COUNT(w.channel) > 6;

SELECT a.name, w.channel, COUNT(w.channel)
FROM accounts a
         JOIN web_events w
              ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.name, w.channel
ORDER BY COUNT(w.channel) DESC
LIMIT 1;

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
         JOIN web_events w
              ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 1;

---DATE---
SELECT SUM(o.total_amt_usd), DATE_PART('year', o.occurred_at)
FROM orders o
GROUP BY DATE_PART('year', o.occurred_at)
ORDER BY SUM(o.total_amt_usd) DESC;

SELECT SUM(O.total_amt_usd), DATE_PART('month', o.occurred_at)
FROM orders o
WHERE o.occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY DATE_PART('month', o.occurred_at)
ORDER BY DATE_PART('month', o.occurred_at);


SELECT SUM(O.total), DATE_PART('month', o.occurred_at)
FROM orders o
GROUP BY DATE_PART('month', o.occurred_at)
ORDER BY DATE_PART('month', o.occurred_at);

SELECT DATE_TRUNC('month', o.occurred_at), SUM(o.gloss_amt_usd)
FROM accounts a
         JOIN orders o
              ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY DATE_TRUNC('month', o.occurred_at)
ORDER BY SUM(o.gloss_amt_usd) DESC
LIMIT 1;

---CASE---
SELECT o.account_id,
       o.total_amt_usd,
       CASE WHEN o.total_amt_usd >= 3000 THEN 'Large' ELSE 'Small' END level_of_order
FROM orders o;

SELECT COUNT(o.account_id),
       CASE
           WHEN o.total >= 2000 THEN 'At Least 2000'
           WHEN o.total >= 1000 AND o.total < 2000 THEN 'Between 1000 and 2000'
           WHEN o.total < 1000 THEN 'Less than 1000' END level_of_order
FROM orders o
GROUP BY 2;

SELECT a.name, SUM(total_amt_usd) total_spent,
     CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
     WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
     ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY a.name
ORDER BY 2 DESC;

SELECT a.name, SUM(total_amt_usd) total_spent,
     CASE WHEN SUM(total_amt_usd) > 200000 THEN 'top'
     WHEN  SUM(total_amt_usd) > 100000 THEN 'middle'
     ELSE 'low' END AS customer_level
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE occurred_at BETWEEN '2016-01-01' AND '2017-12-31'
GROUP BY 1
ORDER BY 2 DESC;














