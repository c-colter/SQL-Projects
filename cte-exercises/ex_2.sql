-- Select supporters who donated more than $200 total or who donated at least twice.
WITH over_200 AS (
	SELECT supporter_id FROM donation
	GROUP BY supporter_id
	HAVING SUM(amount) > 200
),
multiple_donations AS (
	SELECT supporter_id FROM donation
	GROUP BY supporter_id
	HAVING COUNT(*) >= 2
)
SELECT first_name || ' ' || last_name FROM supporter
WHERE id IN (
	SELECT supporter_id FROM over_200 INTERSECT SELECT supporter_id FROM multiple_donations
);
