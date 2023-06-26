-- Exploring Data
  -- Size: 1192 kB
SELECT pg_size_pretty(
  pg_table_size('sensors.observations')
);

SELECT pg_size_pretty(pg_total_relation_size('sensors.observations')) as idx_1_size,
    pg_size_pretty(pg_total_relation_size('sensors.observations')) as idx_2_size;

SELECT 
    pg_size_pretty(pg_table_size('sensors.observations')) as tbl_size, 
    pg_size_pretty(pg_indexes_size('sensors.observations')) as idx_size,
    pg_size_pretty(pg_total_relation_size('sensors.observations')) as total_size;

-- Implementing a large UPDATE and INSERT
UPDATE sensors.observations
SET distance = (distance * 3.281)
WHERE TRUE;

SELECT 
    pg_size_pretty(pg_table_size('sensors.observations')) as tbl_size, 
    pg_size_pretty(pg_indexes_size('sensors.observations')) as idx_size,
    pg_size_pretty(pg_total_relation_size('sensors.observations')) as total_size;

VACUUM sensors.observations;
SELECT pg_size_pretty(pg_table_size('sensors.observations'));

\COPY sensors.observations (id, datetime, location_id, duration, distance, category) FROM './additional_obs_types.csv' WITH DELIMITER ',' CSV HEADER;

SELECT pg_size_pretty(pg_table_size('sensors.observations')) as total_size;

VACUUM FULL sensors.observations; --this reduced the size
SELECT pg_size_pretty(pg_table_size('sensors.observations')) as total_size;

-- Implementing a large DELETE
DELETE FROM sensors.observations
WHERE location_id > 24;

SELECT pg_size_pretty(pg_table_size('sensors.observations')) as total_size;

-- Reloading The Table
TRUNCATE sensors.observations;

\COPY sensors.observations (id, datetime, location_id, duration, distance, category) FROM './original_obs_types.csv' WITH DELIMITER ',' CSV HEADER;
 
\COPY sensors.observations (id, datetime, location_id, duration, distance, category) FROM './additional_obs_types.csv' WITH DELIMITER ',' CSV HEADER;

SELECT 
    pg_size_pretty(pg_table_size('sensors.observations')) as tbl_size, 
    pg_size_pretty(pg_indexes_size('sensors.observations')) as idx_size,
    pg_size_pretty(pg_total_relation_size('sensors.observations')) as total_size;
