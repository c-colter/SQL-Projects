DROP TABLE IF EXISTS initial_weight_conditions;
DROP VIEW IF EXISTS weight_loss_by_lbs_per_week;

CREATE TABLE initial_weight_conditions (
	weight NUMERIC NOT NULL
);

INSERT INTO initial_weight_conditions VALUES (225.0);

CREATE VIEW weight_loss_by_lbs_per_week AS (
	WITH RECURSIVE weight_loss AS (
		SELECT 1 AS week, weight AS half_per_wk, weight AS one_per_wk, weight AS one_and_half_per_wk, weight AS two_per_wk
		FROM initial_weight_conditions
		UNION
		SELECT week + 1, half_per_wk - 0.5, one_per_wk - 1.0, one_and_half_per_wk - 1.5, two_per_wk - 2
		FROM weight_loss
		WHERE week < 52
	)
	SELECT * FROM weight_loss
);