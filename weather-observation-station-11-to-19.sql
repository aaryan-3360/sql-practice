-- Problem: Weather Observation Station 11
-- Link: https://www.hackerrank.com/challenges/weather-observation-station-11/problem
SELECT DISTINCT CITY FROM STATION WHERE (CITY NOT LIKE 'a%' AND CITY NOT LIKE 'e%' AND CITY NOT LIKE 'i%' AND CITY NOT LIKE 'o%' AND CITY NOT LIKE 'u%') OR (CITY NOT LIKE '%a' AND CITY NOT LIKE '%e' AND CITY NOT LIKE '%i' AND CITY NOT LIKE '%o' AND CITY NOT LIKE '%u');


-- Problem: Weather Observation Station 12
-- Link: https://www.hackerrank.com/challenges/weather-observation-station-12/problem
SELECT DISTINCT CITY FROM STATION WHERE (CITY NOT LIKE 'a%' AND CITY NOT LIKE 'e%' AND CITY NOT LIKE 'i%' AND CITY NOT LIKE 'o%' AND CITY NOT LIKE 'u%') AND (CITY NOT LIKE '%a' AND CITY NOT LIKE '%e' AND CITY NOT LIKE '%i' AND CITY NOT LIKE '%o' AND CITY NOT LIKE '%u');


-- Problem: Weather Observation Station 13
-- Link: https://www.hackerrank.com/challenges/weather-observation-station-13/problem
SELECT TRUNCATE(SUM(LAT_N), 4) FROM STATION WHERE LAT_N > 38.7880 AND LAT_N < 137.2345;


-- Problem: Weather Observation Station 14
-- Link: https://www.hackerrank.com/challenges/weather-observation-station-14/problem
SELECT ROUND(MAX(LAT_N), 4) FROM STATION WHERE LAT_N < 137.2345;


-- Problem: Weather Observation Station 15
-- Link: https://www.hackerrank.com/challenges/weather-observation-station-15/problem
SELECT ROUND(LONG_W, 4) FROM STATION WHERE LAT_N < 137.2345 ORDER BY LAT_N DESC LIMIT 1;


-- Problem: Weather Observation Station 16
-- Link: https://www.hackerrank.com/challenges/weather-observation-station-16/problem
SELECT ROUND(MIN(LAT_N), 4) FROM STATION WHERE LAT_N > 38.7780;


-- Problem: Weather Observation Station 17
-- Link: https://www.hackerrank.com/challenges/weather-observation-station-17/problem
SELECT ROUND(LONG_W, 4) FROM STATION WHERE LAT_N > 38.7780 ORDER BY LAT_N ASC LIMIT 1;


-- Problem: Weather Observation Station 18
-- Link: https://www.hackerrank.com/challenges/weather-observation-station-18/problem
SELECT ROUND(ABS(MAX(LAT_N)-MIN(LAT_N)) + ABS(MAX(LONG_W)-MIN(LONG_W)), 4) FROM STATION;


-- Problem: Weather Observation Station 19
-- Link: https://www.hackerrank.com/challenges/weather-observation-station-19/problem
SELECT ROUND(SQRT(POWER(MAX(LAT_N)-MIN(LAT_N),2) + POWER(MAX(LONG_W)-MIN(LONG_W),2)), 4) FROM STATION;
