-- statements to reset the db
DROP TABLE IF EXISTS supporter CASCADE;
DROP TABLE IF EXISTS project CASCADE;
DROP TABLE IF EXISTS donation CASCADE;

-- functions
CREATE OR REPLACE FUNCTION random_between(low INT ,high INT)
   RETURNS INT AS
$$
BEGIN
   RETURN floor(random()* (high-low + 1) + low);
END;
$$ LANGUAGE 'plpgsql' STRICT;

CREATE OR REPLACE FUNCTION random_money_between(low INT, high INT)
	RETURNS NUMERIC AS
$$
BEGIN
	RETURN ROUND((random()*(high-low)+low)::DECIMAL, 2);
END;
$$ LANGUAGE 'plpgsql' STRICT;

-- create the tables
CREATE TABLE supporter (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR,
	last_name VARCHAR
);

CREATE TABLE project (
	id SERIAL PRIMARY KEY,
	category VARCHAR,
	author_id INT,
	minimal_amount INT
);

CREATE TABLE donation (
	id SERIAL PRIMARY KEY,
	project_id INT,
	supporter_id INT,
	amount DECIMAL(5,2),
	donated DATE,
	FOREIGN KEY(project_id) REFERENCES project(id),
	FOREIGN KEY(supporter_id) REFERENCES supporter(id)
);

-- generates 200 random supporters
INSERT INTO supporter (first_name, last_name)
SELECT 'first' || n, 'last' || n FROM generate_series(1,200) n;

-- generates 30 random projects
INSERT INTO project (category, author_id, minimal_amount)
SELECT CASE random_between(1,6) 
	       WHEN 1 THEN 'music'
		   WHEN 2 THEN 'traveling'
		   WHEN 3 THEN 'technology'
		   WHEN 4 THEN 'technology'
		   WHEN 5 THEN 'healthcare'
	   ELSE 'other' END,
	   random_between(1,30),
	   random_between(1000,30000)
FROM generate_series(1,40);

-- generates 500 random donations
INSERT INTO donation (project_id, supporter_id, amount, donated)
SELECT random_between(1,30),
	   random_between(1,200) AS supporter_id,
	   random_money_between(1,1000),
	   '2016-09-01'::DATE + random_between(0,120)
FROM generate_series(1,500);
