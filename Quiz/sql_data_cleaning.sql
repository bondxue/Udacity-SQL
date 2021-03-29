--LEFT&RIGHT---
SELECT RIGHT(a.website, 3) as domain, COUNT(*) num_companies
FROM accounts a
GROUP BY 1
ORDER BY 2 DESC;

SELECT LEFT(UPPER(name), 1) AS first_letter, COUNT(*) num_companies
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

