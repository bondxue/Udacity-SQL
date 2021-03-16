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
GROUP BY  r.name
ORDER BY num_sales_reps;

SELECT













