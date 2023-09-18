SELECT server, sample_date, SUM(load_val) OVER () as sum_load FROM server_load_sample;

SELECT server, sample_date, SUM(load_val) OVER (PARTITION BY server) as sum_load FROM server_load_sample;
