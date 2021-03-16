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







