-- Problem: Types of Triangle
-- Link: https://www.hackerrank.com/challenges/what-type-of-triangle/problem

select case
WHEN A+B<=C OR B+C<=A OR A+C<=B THEN 'Not A Triangle'
when A != B AND B != C AND C != A THEN 'Scalene'
when (A = B AND B != C) OR (B = C AND C != A) OR (C = A AND A != B) THEN 'Isosceles'
when A = B AND B = C THEN 'Equilateral'
END FROM TRIANGLES;
