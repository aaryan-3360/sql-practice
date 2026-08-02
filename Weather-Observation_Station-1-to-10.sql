-- Problem: Weather Observation Station 1
-- Link: https://www.hackerrank.com/challenges/weather-observation-station-1/problem
SELECT CITY, STATE FROM STATION;

-- Problem: Weather Observation Station 2
-- Link: https://www.hackerrank.com/challenges/weather-observation-station-2/problem
SELECT ROUND(SUM(LAT_N), 2), ROUND(SUM(LONG_W), 2) FROM STATION;


-- Problem: Weather Observation Station 3
-- Link: https://www.hackerrank.com/challenges/weather-observation-station-3/problem
SELECT DISTINCT CITY FROM STATION WHERE MOD(ID,2)=0;


-- Problem: Weather Observation Station 4
-- Link: https://www.hackerrank.com/challenges/weather-observation-station-4/problem
SELECT COUNT(CITY) - COUNT(DISTINCT CITY) FROM STATION;


-- Problem: Weather Observation Station 5
-- Link: https://www.hackerrank.com/challenges/weather-observation-station-5/problem
SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY) ASC, CITY ASC LIMIT 1;
SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY) DESC, CITY ASC LIMIT 1;


-- Problem: Weather Observation Station 6
-- Link: https://www.hackerrank.com/challenges/weather-observation-station-6/problem
SELECT DISTINCT CITY FROM STATION WHERE CITY LIKE 'a%' OR CITY LIKE 'e%' OR CITY LIKE 'i%' OR CITY LIKE 'o%' OR CITY LIKE 'u%';


-- Problem: Weather Observation Station 7
-- Link: https://www.hackerrank.com/challenges/weather-observation-station-7/problem
SELECT DISTINCT CITY FROM STATION WHERE CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u';


-- Problem: Weather Observation Station 8
-- Link: https://www.hackerrank.com/challenges/weather-observation-station-8/problem
SELECT DISTINCT CITY FROM STATION WHERE LOWER(SUBSTR(CITY,1,1)) IN ('a','e','i','o','u') AND LOWER(SUBSTR(CITY,-1,1)) IN ('a','e','i','o','u');


-- Problem: Weather Observation Station 9
-- Link: https://www.hackerrank.com/challenges/weather-observation-station-9/problem
SELECT DISTINCT CITY FROM STATION WHERE CITY NOT LIKE 'a%' AND CITY NOT LIKE 'e%' AND CITY NOT LIKE 'i%' AND CITY NOT LIKE 'o%' AND CITY NOT LIKE 'u%';


-- Problem: Weather Observation Station 10
-- Link: https://www.hackerrank.com/challenges/weather-observation-station-10/problem
SELECT DISTINCT CITY FROM STATION WHERE CITY NOT LIKE '%a' AND CITY NOT LIKE '%e' AND CITY NOT LIKE '%i' AND CITY NOT LIKE '%o' AND CITY NOT LIKE '%u';
