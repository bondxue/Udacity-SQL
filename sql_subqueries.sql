SELECT AVG(standard_qty) avg_stand_qty,
       AVG(gloss_qty) avg_gloss_qty,
       AVG(poster_qty) avg_poster_qty
FROM orders o
WHERE DATE_TRUNC('month', o.occurred_at) = (
    SELECT MIN(DATE_TRUNC('month', occurred_at)) min_month
    FROM orders
    );


SELECT T1.name, Max(T1.count)
FROM (
       SELECT accounts.name as name, web_events.channel as channel, Count(*) as count
       FROM accounts
       JOIN web_events ON accounts.id = Web_events.account_id
       GROUP BY 1, 2
       ORDER BY 1,3
) as T1
GROUP BY 1