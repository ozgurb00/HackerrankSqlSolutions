--1. Revising the Select Query 1

select * from CITY where POPULATION > 100000
and COUNTRYCODE = 'USA' 

--2. Revising the Select Query 2

SELECT NAME FROM CITY WHERE 
POPULATION > 120000 AND COUNTRYCODE = 'USA'

--3. Select All

SELECT * FROM CITY

--4. Select By ID

SELECT * FROM CITY WHERE ID = 1661

--5. Japanese Cities’ Attributes

SELECT * FROM CITY WHERE COUNTRYCODE= 'JPN'

--6. Japanese Cities’ Names

SELECT NAME FROM CITY WHERE COUNTRYCODE = 'JPN'

--7. Weather Observation Station 1

SELECT CITY, STATE FROM STATION

--8. Weather Observation Station 3

SELECT DISTINCT CITY FROM STATION WHERE ID % 2 = 0

--9. Weather Observation Station 4

SELECT COUNT(CITY) - COUNT(DISTINCT CITY)
FROM STATION

--10. Weather Observation Station 5

SELECT TOP 1 CITY, LEN(CITY) FROM STATION ORDER BY LEN(CITY), CITY 
SELECT TOP 1 CITY, LEN(CITY) FROM STATION ORDER BY LEN(CITY) DESC 

--11. Weather Observation Station 6

SELECT CITY FROM STATION
WHERE CITY LIKE 'A%' OR CITY LIKE 'E%'
OR CITY LIKE 'I%' OR CITY LIKE 'O%' 
OR CITY LIKE 'U%'

--12. Weather Observation Station 7

SELECT DISTINCT CITY FROM STATION
WHERE CITY LIKE '%A' OR CITY LIKE '%E'
OR CITY LIKE '%I' OR CITY LIKE '%O' 
OR CITY LIKE '%U'

--13. Weather Observation Station 8

SELECT DISTINCT CITY FROM STATION
WHERE (CITY LIKE 'A%' OR CITY LIKE 'E%'
OR CITY LIKE 'I%' OR CITY LIKE 'O%' 
OR CITY LIKE 'U%') AND
(CITY LIKE '%A' OR CITY LIKE '%E'
OR CITY LIKE '%I' OR CITY LIKE '%O' 
OR CITY LIKE '%U')

--14. Weather Observation Station 9

SELECT DISTINCT CITY FROM STATION
WHERE CITY NOT LIKE '[AEIOU]%'

--15. Weather Observation Station 10

SELECT DISTINCT CITY FROM STATION
WHERE CITY NOT LIKE '%[AEIOU]'

--16. Weather Observation Station 11

SELECT DISTINCT CITY FROM STATION
WHERE (CITY NOT LIKE 'A%' AND CITY NOT LIKE 'E%'
AND CITY NOT LIKE 'I%' AND CITY NOT LIKE 'O%' AND
CITY NOT LIKE 'U%')
OR (CITY NOT LIKE '%A' AND CITY NOT LIKE '%E'
AND CITY NOT LIKE '%I' AND CITY NOT LIKE '%O' AND
CITY NOT LIKE '%U')

--17. Weather Observation Station 12

SELECT DISTINCT CITY FROM STATION
WHERE (CITY NOT LIKE 'A%' AND CITY NOT LIKE 'E%'
AND CITY NOT LIKE 'I%' AND CITY NOT LIKE 'O%' AND
CITY NOT LIKE 'U%')
AND (CITY NOT LIKE '%A' AND CITY NOT LIKE '%E'
AND CITY NOT LIKE '%I' AND CITY NOT LIKE '%O' AND
CITY NOT LIKE '%U')

--18. Higher Than 75 Marks

SELECT NAME
FROM STUDENTS
WHERE MARKS > 75
ORDER BY RIGHT(NAME,3), ID ASC

--19. Employee Names

SELECT NAME FROM EMPLOYEE
ORDER BY NAME

--20. Employee Salaries

SELECT NAME FROM EMPLOYEE WHERE SALARY > 2000
AND MONTHS < 10 ORDER BY EMPLOYEE_ID

--21. Types of Triangles

SELECT CASE
            WHEN A + B > C AND B + C > A AND A + C > B THEN
                CASE 
                    WHEN A = B AND B = C THEN 'Equilateral'
                    WHEN A = B OR B = C OR A = C THEN 'Isosceles'
                    ELSE 'Scalene'
                END
            ELSE 'Not A Triangle'
        END
FROM TRIANGLES

--22. The PADS

SELECT 
CONCAT(NAME, '(', SUBSTRING(OCCUPATION, 1, 1), ')') AS NM
FROM OCCUPATIONS
ORDER BY NM
SELECT 
CONCAT('There are a total of ', COUNT(occupation),' ', LOWER(occupation),'s.')
AS TOTALS
FROM OCCUPATIONS
GROUP BY OCCUPATION
ORDER BY TOTALS 

--23. Occupations

SELECT 
    [Doctor],
    [Professor],
    [Singer],
    [Actor]
FROM
    (SELECT 
         ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) row_num,
         [Name],
         [Occupation] 
     FROM 
         Occupations
    ) AS source 
PIVOT 
    ( MIN([Name]) FOR [occupation] IN ([Doctor],[Professor],[Singer],[Actor]) ) as pvt 
ORDER BY row_num

--24. Binary Tree Nodes

SELECT BT.N,
CASE
    WHEN BT.P IS NULL THEN 'Root'
    WHEN EXISTS (SELECT B.P FROM BST B WHERE B.P = BT.N) THEN 'Inner'        
    ELSE 'Leaf'
END
FROM BST AS BT 
ORDER BY BT.N

--25. New Companies

SELECT c.company_code,c.founder,
count(distinct lm.lead_manager_code),
count(distinct sm.senior_manager_code),
count(distinct m.manager_code), 
count(distinct e.employee_code)
FROM Company c, Lead_Manager lm, Senior_Manager sm, Manager m, Employee e
WHERE
c.company_code=lm.company_code AND
lm.lead_manager_code=sm.lead_manager_code AND
sm.senior_manager_code=m.senior_manager_code AND
m.manager_code=e.manager_code
GROUP BY c.company_code,c.founder
ORDER BY c.company_code ASC

--26. Revising Aggregations - The Count Function

SELECT COUNT(*) FROM CITY WHERE POPULATION > 100000

--27. Revising Aggregations - The Sum Function

SELECT SUM(POPULATION) FROM CITY WHERE DISTRICT = 'CALIFORNIA'

--28. Revising Aggregations - Averages

SELECT AVG(POPULATION) FROM CITY WHERE DISTRICT = 'CALIFORNIA'

--29. Average Population

SELECT FLOOR(AVG(POPULATION)) FROM CITY

--30. Japan Population

SELECT SUM(POPULATION) FROM CITY WHERE COUNTRYCODE = 'JPN'

--31. Population Density Difference

SELECT MAX(POPULATION) - MIN(POPULATION) FROM CITY

--32. The Blunder

--+1 added due to precision
SELECT 
CEILING(AVG(SALARY) - 
AVG(CAST(REPLACE(CAST(Salary AS VARCHAR(10)), '0', '') AS INT))) + 1 
FROM  EMPLOYEES

--33. Top Earners

SELECT TOP 1 MONTHS*SALARY,
COUNT(MONTHS*SALARY)
FROM EMPLOYEE
GROUP BY MONTHS*SALARY
ORDER BY MONTHS*SALARY DESC

--34. Weather Observation Station 2

SELECT 
CAST( CAST(SUM(LAT_N) AS DECIMAL(10,2)) AS VARCHAR) + ' ' +
CAST( CAST(SUM(LONG_W) AS DECIMAL(10,2)) AS VARCHAR)
FROM STATION

--35. Weather Observation Station 13

SELECT 
CAST( CAST(SUM(LAT_N) AS DECIMAL(10,4)) AS VARCHAR)
FROM STATION 
WHERE LAT_N BETWEEN 38.7880 AND 137.2345 

--36. Weather Observation Station 14

SELECT 
CAST(MAX(LAT_N) AS DECIMAL(10,4))
FROM STATION WHERE LAT_N < 137.2345

--37. Weather Observation Station 15

WITH LAT_N_LARGEST AS (
SELECT
MAX(LAT_N) AS MAXLAT_N
FROM STATION
WHERE LAT_N < 137.2345
)

SELECT CAST(LONG_W AS DECIMAL(10,4)) AS LONG_W
FROM STATION S
JOIN LAT_N_LARGEST L ON L.MAXLAT_N = S.LAT_N

--38. Weather Observation Station 16

SELECT
CAST(MIN(LAT_N) AS DECIMAL(10,4))
FROM STATION
WHERE LAT_N > 38.7780

--39. Weather Observation Station 17

WITH SMALL AS (
SELECT MIN(LAT_N) AS SMALLEST
FROM STATION
WHERE LAT_N > 38.7780
)

SELECT
CAST(LONG_W AS DECIMAL(10,4)) AS LONG_W
FROM STATION ST
JOIN SMALL S ON S.SMALLEST = ST.LAT_N

--40. Weather Observation Station 18

SELECT 
CAST(ABS(MAX(LAT_N) - MIN(LAT_N)) + ABS(MAX(LONG_W) - MIN(LONG_W))
AS DECIMAL(10,4)) AS MANHATTAN_DISTANCE
FROM STATION

--41. Weather Observation Station 19

SELECT 
CAST(SQRT(POWER(MAX(LAT_N) - MIN(LAT_N), 2) + 
POWER(MAX(LONG_W) - MIN(LONG_W), 2)) AS DECIMAL(10,4))
FROM STATION

--42. Weather Observation Station 20

SELECT TOP 1
CAST(PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY LAT_N)
OVER (PARTITION BY NULL) AS DECIMAL(10,4)) AS MEDIAN
FROM STATION

--43. Population Census

SELECT
SUM(C.POPULATION)
FROM CITY C
JOIN COUNTRY CT
ON C.COUNTRYCODE = CT.CODE
WHERE CT.CONTINENT = 'ASIA'

--44. African Cities

SELECT
C.NAME
FROM CITY C
JOIN COUNTRY CT
ON C.COUNTRYCODE = CT.CODE
WHERE CT.CONTINENT = 'AFRICA'

--45. Average Population of Each Continent

SELECT 
CT.CONTINENT, AVG(C.POPULATION)
FROM CITY C
JOIN COUNTRY CT 
ON C.COUNTRYCODE = CT.CODE
GROUP BY CT.CONTINENT


--46. The Report

SELECT CASE WHEN GRADE >= 8 THEN NAME
ELSE 'NULL' END AS NAME,
GRADE, MARKS
FROM STUDENTS S 
JOIN GRADES G ON S.MARKS BETWEEN G.MIN_MARK AND G.MAX_MARK
ORDER BY GRADE DESC, NAME ASC, MARKS ASC

--47. The Competitors

SELECT H.HACKER_ID, H.NAME
FROM SUBMISSIONS S JOIN CHALLENGES C ON
S.CHALLENGE_ID = C.CHALLENGE_ID 
JOIN DIFFICULTY D ON C.DIFFICULTY_LEVEL = D.DIFFICULTY_LEVEL
JOIN HACKERS H ON S.HACKER_ID = H.HACKER_ID WHERE 
S.SCORE = D.SCORE AND C.DIFFICULTY_LEVEL = D.DIFFICULTY_LEVEL
GROUP BY H.HACKER_ID, H.NAME 
HAVING COUNT(S.HACKER_ID) > 1 
ORDER BY COUNT(S.HACKER_ID) DESC, H.HACKER_ID ASC

--48. Olivander's Inventory

WITH MIN_COINS AS (
SELECT ROW_NUMBER() OVER(PARTITION BY CODE, POWER ORDER BY CODE,
POWER, COINS_NEEDED ASC) AS ROWNUMBER, ID, CODE, COINS_NEEDED,
POWER FROM WANDS
)

SELECT ID, AGE, COINS_NEEDED, POWER
FROM WANDS_PROPERTY WP
JOIN MIN_COINS MC ON MC.CODE = WP.CODE AND ROWNUMBER = 1
WHERE IS_EVIL = 0
ORDER BY POWER DESC, AGE DESC

--49. Challenges

WITH TBL_NUM_CHALLENGES AS (
SELECT H.HACKER_ID, H.NAME,
COUNT(C.CHALLENGE_ID) AS NUM_CHALLENGES
FROM HACKERS H
JOIN CHALLENGES C ON C.HACKER_ID = H.HACKER_ID
GROUP BY H.HACKER_ID, H.NAME
)

, TBL_COUNT_CHALLENGES AS (
SELECT NUM_CHALLENGES,
COUNT(NUM_CHALLENGES) AS COUNT_CHALLENGES
FROM TBL_NUM_CHALLENGES
GROUP BY NUM_CHALLENGES
)

SELECT TNC.HACKER_ID, TNC.NAME,
TNC.NUM_CHALLENGES
FROM TBL_NUM_CHALLENGES TNC
JOIN TBL_COUNT_CHALLENGES TCC ON TCC.NUM_CHALLENGES 
= TNC.NUM_CHALLENGES WHERE TCC.COUNT_CHALLENGES <= 1
OR TNC.NUM_CHALLENGES = (SELECT MAX(NUM_CHALLENGES) FROM 
TBL_NUM_CHALLENGES)
ORDER BY TNC.NUM_CHALLENGES DESC, HACKER_ID

--50. Contest Leader Board

WITH MAX_SCORE AS (
SELECT MAX(SCORE) AS MSCORE, CHALLENGE_ID,
HACKER_ID FROM SUBMISSIONS
GROUP BY CHALLENGE_ID, HACKER_ID
)

SELECT H.HACKER_ID, H.NAME, SUM(MSCORE)
FROM HACKERS H JOIN MAX_SCORE MS
ON MS.HACKER_ID = H.HACKER_ID 
GROUP BY H.HACKER_ID, H.NAME
HAVING SUM(MS.MSCORE) > 0
ORDER BY SUM(MS.MSCORE) DESC, HACKER_ID ASC

--51. SQL Project Planning

WITH PROJECT_START_DATE AS (
SELECT START_DATE, RANK() OVER
(ORDER BY START_DATE) AS RANK_START
FROM PROJECTS WHERE START_DATE 
NOT IN (SELECT END_DATE FROM PROJECTS)
),

PROJECT_END_DATE AS (
SELECT END_DATE, RANK() OVER (ORDER BY END_DATE)
AS RANK_END FROM PROJECTS WHERE END_DATE NOT IN
(SELECT START_DATE FROM PROJECTS)
)

SELECT START_DATE, END_DATE FROM PROJECT_START_DATE,
PROJECT_END_DATE WHERE RANK_START = RANK_END
ORDER BY DATEDIFF(DAY, START_DATE, END_DATE),
START_DATE

--52. Placements

WITH SOLUTION_WITH_NULLS AS (
SELECT CASE WHEN PF.SALARY > P.SALARY THEN S.NAME
END AS NAME_SALARY, PF.SALARY
FROM STUDENTS S JOIN FRIENDS F ON F.ID = S.ID
JOIN PACKAGES P ON P.ID = S.ID
JOIN PACKAGES PF ON PF.ID = F.FRIEND_ID
)
SELECT NAME_SALARY FROM SOLUTION_WITH_NULLS
WHERE NAME_SALARY IS NOT NULL ORDER BY SALARY

--53. Symmetric Pairs

WITH ENUMERATE AS (
SELECT X, Y, ROW_NUMBER() OVER(ORDER BY X, Y) AS RN
FROM FUNCTIONS F
)

SELECT DISTINCT E.X, E.Y FROM ENUMERATE E
JOIN ENUMERATE E2 ON E.X = E2.Y AND E2.X = E.Y
AND E.RN <> E2.RN WHERE E.X <= E.Y 
ORDER BY X, Y

--54. Interviews

WITH TOTAL_SUBMIT AS (
SELECT COLL.CONTEST_ID, 
SUM(SS.TOTAL_SUBMISSIONS) AS SUMTS,
SUM(SS.TOTAL_ACCEPTED_SUBMISSIONS) AS SUMTAS 
FROM COLLEGES COLL 
JOIN CHALLENGES CHALL ON CHALL.COLLEGE_ID
= COLL.COLLEGE_ID 
JOIN SUBMISSION_STATS SS ON CHALL.CHALLENGE_ID
= SS.CHALLENGE_ID 
GROUP BY COLL.CONTEST_ID
),

TOTAL_VIEW AS (
SELECT COLL.CONTEST_ID, 
SUM(VS.TOTAL_VIEWS) AS SUMTV,
SUM(VS.TOTAL_UNIQUE_VIEWS) AS SUMTUV 
FROM COLLEGES COLL
JOIN CHALLENGES CHALL ON CHALL.COLLEGE_ID = COLL.COLLEGE_ID
JOIN VIEW_STATS VS ON CHALL.CHALLENGE_ID = VS.CHALLENGE_ID
GROUP BY COLL.CONTEST_ID
)

SELECT 
CONT.CONTEST_ID,
CONT.HACKER_ID, 
CONT.NAME,
TS.SUMTS, 
TS.SUMTAS, 
TV.SUMTV, 
TV.SUMTUV FROM CONTESTS CONT
JOIN TOTAL_SUBMIT TS ON TS.CONTEST_ID = CONT.CONTEST_ID
JOIN TOTAL_VIEW TV ON TV.CONTEST_ID = CONT.CONTEST_ID
WHERE TS.SUMTS > 0 
OR TS.SUMTAS > 0 
OR TV.SUMTV > 0
OR TV.SUMTUV > 0 
ORDER BY CONT.CONTEST_ID

--55. 15 Days of Learning SQL
with MaxSubEachDay as (
    select submission_date,
           hacker_id,
           RANK() OVER(partition by submission_date order by SubCount desc, hacker_id) as Rn
    FROM
    (select submission_date, hacker_id, count(1) as SubCount 
     from submissions
     group by submission_date, hacker_id
     ) subQuery
), DayWiseRank as (
    select submission_date,
           hacker_id,
           DENSE_RANK() OVER(order by submission_date) as dayRn
    from submissions
), HackerCntTillDate as (
select outtr.submission_date,
       outtr.hacker_id,
       case when outtr.submission_date='2016-03-01' then 1
            else 1+(select count(distinct a.submission_date)                         from submissions a where a.hacker_id = outtr.hacker_id and                              a.submission_date<outtr.submission_date)
        end as PrevCnt,
        outtr.dayRn
from DayWiseRank outtr
), HackerSubEachDay as (
    select submission_date,
    count(distinct hacker_id) HackerCnt
from HackerCntTillDate
  where PrevCnt = dayRn
group by submission_date
)
select HackerSubEachDay.submission_date,
       HackerSubEachDay.HackerCnt,
       MaxSubEachDay.hacker_id,
       Hackers.name
from HackerSubEachDay
inner join MaxSubEachDay
 on HackerSubEachDay.submission_date = MaxSubEachDay.submission_date
inner join Hackers
 on Hackers.hacker_id = MaxSubEachDay.hacker_id
where MaxSubEachDay.Rn=1

--56. Draw The Triangle 1

DECLARE @COUNTER INT
SET @COUNTER = 20
WHILE(@COUNTER > 0)
BEGIN
PRINT(REPLICATE('* ', @COUNTER))
SET @COUNTER = @COUNTER - 1
END

--57. Draw The Triangle 2

DECLARE @COUNTER INT
SET @COUNTER = 1
WHILE(@COUNTER <= 20)
BEGIN
PRINT(REPLICATE('* ', @COUNTER))
SET @COUNTER = @COUNTER + 1
END

--58. Print Prime Numbers

DECLARE @table TABLE (PrimeNumber INT)
DECLARE @final AS VARCHAR(1500)
SET @final = ''
DECLARE @counter INT
SET @counter = 2
WHILE @counter <= 1000
BEGIN
    IF NOT EXISTS (
            SELECT PrimeNumber
            FROM @table
            WHERE @counter % PrimeNumber = 0)
        BEGIN 
            INSERT INTO @table SELECT @counter
            SET @final = @final + CAST(@counter AS VARCHAR(20))+'&' 
        END
    SET @counter = @counter + 1
END
SELECT SUBSTRING(@final,0,LEN(@final))