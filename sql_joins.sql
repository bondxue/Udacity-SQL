---First JOIN---
SELECT *
FROM accounts
JOIN orders
ON accounts.id = orders.account_id;

SELECT o.poster_qty, o.standard_qty, o.gloss_qty, a.website, a.primary_poc
FROM accounts a
JOIN orders o
ON a.id = o.account_id;

---JOIN---
SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name = 'Walmart';

SELECT r.name, sr.name, a.name
FROM region r
JOIN sales_reps sr
ON r.id = sr.region_id
JOIN accounts a
ON sr.id = a.sales_rep_id
ORDER BY a.name;

SELECT r.name, a.name, o.total_amt_usd/(o.total+0.01) unit_price
FROM region r
JOIN sales_reps sr
ON r.id = sr.region_id
JOIN accounts a
ON sr.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id;

---LAST CHECK---
SELECT r.name, sr.name, a.name
FROM region r
JOIN sales_reps sr
ON r.id = sr.region_id
JOIN accounts a
ON sr.id = a.sales_rep_id
WHERE r.name = 'Midwest'
ORDER BY a.name;

SELECT r.name, sr.name, a.name
FROM region r
JOIN sales_reps sr
ON r.id = sr.region_id
JOIN accounts a
ON sr.id = a.sales_rep_id
WHERE r.name = 'Midwest' AND sr.name LIKE 'S%'
ORDER BY a.name;

SELECT r.name, sr.name, a.name
FROM region r
JOIN sales_reps sr
ON r.id = sr.region_id
JOIN accounts a
ON sr.id = a.sales_rep_id
WHERE r.name = 'Midwest' AND sr.name LIKE '% K%'
ORDER BY a.name;

SELECT r.name, a.name, o.total_amt_usd/(o.total+0.01) unit_price
FROM region r
JOIN sales_reps sr
ON r.id = sr.region_id
JOIN accounts a
ON sr.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
WHERE o.standard_qty > 100;

SELECT r.name, a.name, o.total_amt_usd/(o.total+0.01) unit_price
FROM region r
JOIN sales_reps sr
ON r.id = sr.region_id
JOIN accounts a
ON sr.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;

SELECT r.name, a.name, o.total_amt_usd/(o.total+0.01) unit_price
FROM region r
JOIN sales_reps sr
ON r.id = sr.region_id
JOIN accounts a
ON sr.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;

SELECT DISTINCT a.name account_name, w.channel channel
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.id = 1001;

SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;