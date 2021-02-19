DROP TABLE IF EXISTS covid_new ;

CREATE TABLE covid_new AS
WITH temp AS (
	SELECT country_code, report_date,
    tests,
		COALESCE(LAG (tests, 1) OVER (PARTITION BY country_code ORDER BY report_date), 0) AS tests_prev_day,
    confirmed,
		COALESCE(LAG (confirmed, 1) OVER (PARTITION BY country_code ORDER BY report_date), 0) AS confirmed_prev_day,
    recovered,
		COALESCE(LAG (recovered, 1) OVER (PARTITION BY country_code ORDER BY report_date), 0) AS recovered_prev_day,
    deaths,
		COALESCE(LAG (deaths, 1) OVER (PARTITION BY country_code ORDER BY report_date), 0) AS deaths_prev_day,
    hosp,
		COALESCE(LAG (hosp, 1) OVER (PARTITION BY country_code ORDER BY report_date), 0) AS hosp_prev_day,
    vent,
		COALESCE(LAG (vent, 1) OVER (PARTITION BY country_code ORDER BY report_date), 0) AS vent_prev_day,
    cancel_events,
    icu,
    school_closing,
    workplace_closing,
    gatherings_restrictions,
    transport_closing,
    stay_home_restrictions,
    internal_movement_restrictions,
    international_movement_restrictions,
    information_campaigns,
    testing_policy,
    contact_tracing,
    stringency_index
    FROM covid
	)
SELECT *
FROM temp

ALTER TABLE covid_new ADD PRIMARY KEY (country_code, report_date) ;

ALTER TABLE covid_new ADD CONSTRAINT fk_covid_new_countries
    FOREIGN KEY (country_code) REFERENCES country_gen_info (country_code) ;
