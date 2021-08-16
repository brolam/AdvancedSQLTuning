CREATE TABLE iot_measurement
(
location_id int NOT NULL,
measure_date date NOT NULL,
temp_celcius int,
rel_humidity_pct int
)
PARTITION BY RANGE (measure_date);
CREATE TABLE iot_measurement_wk1_2021 PARTITION of iot_measurement
for values from  ('2021-01-01') to ('2021-01-08');