-- Obtain the project ID, minimal amount, and total donations for projects 
-- that have received donations over the minimum amount.
WITH total_donated_by_proj AS (
	SELECT project_id, sum(amount) AS total_donated FROM donation
	GROUP BY project_id
	ORDER BY sum(amount) DESC
)
SELECT id, minimal_amount, total_donated FROM project
JOIN total_donated_by_proj ON project.id = total_donated_by_proj.project_id
WHERE minimal_amount <= total_donated;
