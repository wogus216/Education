--4월 16일 우리끼리 실습문제

--HR 문제 [공공1]
-- 3월에 입사한 사람들 중 급여순위 4위의 근무도시를 출력하시오

--3월입사자 급여순위 
SELECT FIRST_NAME,SALARY,DEPARTMENT_ID,
        RANK () OVER ( ORDER BY SALARY DESC) AS RNK
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'MM') = 03 
;

--3월입사자 급여순위 4 그리고 부서번호 추가
SELECT D.*,MA.FIRST_NAME,MA.SALARY
FROM DEPARTMENTS D INNER JOIN (SELECT FIRST_NAME,SALARY,DEPARTMENT_ID,
                                 RANK () OVER ( ORDER BY SALARY DESC) AS RNK
                               FROM EMPLOYEES
                               WHERE TO_CHAR(HIRE_DATE, 'MM') = 03 ) MA
                    ON D.DEPARTMENT_ID = MA.DEPARTMENT_ID
                    AND MA.RNK =4                  
;
​
--정답

SELECT  L.CITY
FROM LOCATIONS L INNER JOIN (SELECT D.*,MA.FIRST_NAME,MA.SALARY
                            FROM DEPARTMENTS D 
                 INNER JOIN (SELECT FIRST_NAME,SALARY,DEPARTMENT_ID,
                            RANK () OVER ( ORDER BY SALARY DESC) AS RNK
                             FROM EMPLOYEES
                            WHERE TO_CHAR(HIRE_DATE, 'MM') = 03 ) MA
                        ON D.DEPARTMENT_ID = MA.DEPARTMENT_ID
                        AND MA.RNK =4) D2
             ON L.LOCATION_ID = D2.LOCATION_ID
GROUP BY L.CITY
;    
--[HR]서비스2
--Purchasing Manager가 근무하는 도시의 모든 사원 중 부서장을 제외하고 급여를 가장 많이 받는 사람 2명 순서대로 출력

--PURCHASGIN MANAGER 매니저
SELECT *
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
                                ON E.EMPLOYEE_ID = D.MANAGER_ID
                                AND D.MANAGER_ID = 114
;

--근무하는 도시
SELECT L.LOCATION_ID,L.CITY,P.*
FROM LOCATIONS L INNER JOIN (SELECT *
                            FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
                                              ON E.EMPLOYEE_ID = D.MANAGER_ID
                                              AND D.MANAGER_ID = 114) P
                            ON L.LOCATION_ID = P.LOCATION_ID 
;


--시애틀에 있는 부서
SELECT  D3.*
FROM DEPARTMENTS D3 INNER JOIN (SELECT L.LOCATION_ID,L.CITY
                                FROM LOCATIONS L INNER JOIN (SELECT *
                                                            FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
                                                            ON E.EMPLOYEE_ID = D.MANAGER_ID
                                                            AND D.MANAGER_ID = 114) P
                                 ON L.LOCATION_ID = P.LOCATION_ID) C
                    ON D3.LOCATION_ID = C.LOCATION_ID                  
;

--도시의 모든 사원 중 부서장을 제외하고 급여를 가장 많이 받는 사람 2명 순서대로 출력

--부서장 목록
SELECT E2.EMPLOYEE_ID AS ID,E2.LAST_NAME,E2.FIRST_NAME
FROM EMPLOYEES E2 INNER JOIN  (SELECT  D3.*
                                FROM DEPARTMENTS D3 
                                            INNER JOIN (SELECT L.LOCATION_ID,L.CITY
                                                        FROM LOCATIONS L 
                                                    INNER JOIN (SELECT *
                                                                 FROM EMPLOYEES E 
                                                        INNER JOIN DEPARTMENTS D
                                                                ON E.EMPLOYEE_ID = D.MANAGER_ID
                                                                AND D.MANAGER_ID = 114) P
                                            ON L.LOCATION_ID = P.LOCATION_ID) C
                             ON D3.LOCATION_ID = C.LOCATION_ID) C2
            ON E2.DEPARTMENT_ID = C2.DEPARTMENT_ID
            AND  E2.EMPLOYEE_ID = C2.MANAGER_ID
;

--부서장 200,114,100,108,205,정답
SELECT *
FROM
        (SELECT E3.EMPLOYEE_ID,(E3.FIRST_NAME || E3.LAST_NAME) AS NAME, E3.SALARY,
                RANK() OVER ( ORDER BY E3.SALARY DESC) AS RNK
        FROM  EMPLOYEES E3 INNER JOIN (SELECT E2.EMPLOYEE_ID AS ID
                                        FROM EMPLOYEES E2 
                                 INNER JOIN  (SELECT  D3.*
                                             FROM DEPARTMENTS D3 
                                                    INNER JOIN (SELECT L.LOCATION_ID,L.CITY
                                                                FROM LOCATIONS L 
                                                            INNER JOIN (SELECT *
                                                                         FROM EMPLOYEES E 
                                                                INNER JOIN DEPARTMENTS D
                                                                        ON E.EMPLOYEE_ID = D.MANAGER_ID
                                                                        AND D.MANAGER_ID = 114) P
                                                    ON L.LOCATION_ID = P.LOCATION_ID) C
                                ON D3.LOCATION_ID = C.LOCATION_ID) C2
                            ON E2.DEPARTMENT_ID = C2.DEPARTMENT_ID
                            AND  E2.EMPLOYEE_ID = C2.MANAGER_ID) C3
            ON E3.MANAGER_ID = C3.ID )
WHERE RNK =1      
;
--(2번)  HR 문제 금융
-- 부하직원이 두번째로 많은 상급자들의 평균 연봉을 구하시오.

SELECT MANAGER_ID,COUNT(*),
        DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
FROM EMPLOYEES
GROUP BY MANAGER_ID
;
--정답
SELECT AVG(SALARY)
FROM EMPLOYEES E INNER JOIN (SELECT MANAGER_ID,COUNT(*),
                            RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
                            FROM EMPLOYEES
                            GROUP BY MANAGER_ID) M
                    ON E.EMPLOYEE_ID = M.MANAGER_ID
                    AND M.RNK = 2 
                    
;

--공공2
--폰넘버 515로 시작하는 사람들이 가장많이 속해있는 3번째 부서를 구하고, 
--그부서의 급여 최고와 최소의 차를 구하시오.

--515로 시작하는 사원이 많이 속한 3번째 부서
SELECT COUNT(*),DEPARTMENT_ID,
    RANK() OVER (ORDER BY COUNT(*) DESC ) AS RNK
FROM EMPLOYEES
WHERE PHONE_NUMBER LIKE '515%'
GROUP BY DEPARTMENT_ID
;

SELECT (MAX(SALARY) - MIN(SALARY)) AS RESULT
FROM EMPLOYEES E INNER JOIN (SELECT COUNT(*),DEPARTMENT_ID,
                            RANK() OVER (ORDER BY COUNT(*) DESC ) AS RNK
                            FROM EMPLOYEES
                            WHERE PHONE_NUMBER LIKE '515%'
                            GROUP BY DEPARTMENT_ID) N
                ON E.DEPARTMENT_ID = N.DEPARTMENT_ID
                AND N.RNK = 3
        
;


--서비스
-- 전화번호에 4가 두 개이상 들어가는 사원 중 급여가 5000이 넘어가는 사원이 가장 많이 사는 도시를 구하시오
-- 출력 : 도시

SELECT (FIRST_NAME || LAST_NAME) AS NAME, (CASE WHEN SALARY > 5000
            THEN SALARY
            ELSE NULL
            END ) AS RSAL,
            DEPARTMENT_ID
FROM EMPLOYEES
WHERE PHONE_NUMBER LIKE '%4%4%'
;
SELECT *
FROM DEPARTMENTS D INNER JOIN (SELECT (FIRST_NAME || LAST_NAME) AS NAME, 
                                    (CASE WHEN SALARY > 5000
                                          THEN SALARY
                                          ELSE NULL
                                          END ) AS RSAL,
                                        DEPARTMENT_ID
                             FROM EMPLOYEES
                             WHERE PHONE_NUMBER LIKE '%4%4%') E
                ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
                AND E.RSAL IS NOT NULL
;
SELECT *
FROM 
            (SELECT L.CITY,COUNT(*),
                    RANK() OVER(ORDER BY COUNT(*) DESC) AS CITY_RNK
            FROM LOCATIONS L INNER JOIN (SELECT *
                                        FROM DEPARTMENTS D 
                                    INNER JOIN (SELECT (FIRST_NAME || LAST_NAME) AS NAME, 
                                                (CASE WHEN SALARY > 5000
                                                      THEN SALARY
                                                      ELSE NULL
                                                      END ) AS RSAL,
                                                    DEPARTMENT_ID
                                                 FROM EMPLOYEES
                                                 WHERE PHONE_NUMBER LIKE '%4%4%') E
                            ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
                            AND E.RSAL IS NOT NULL) E2
                    ON L.LOCATION_ID = E2.LOCATION_ID
            GROUP BY L.CITY ) 
WHERE CITY_RNK = 1
;


--미국에 있는 부서들의  부서별 평균 연봉(커미션 포함) 1위 2위 3위를 구하시오
--미국--
SELECT *
FROM LOCATIONS 
WHERE COUNTRY_ID = 'US'
;
--미국에서 일하고 있는 부서
SELECT D.*
FROM DEPARTMENTS D INNER JOIN (SELECT *
                                FROM LOCATIONS 
                                WHERE COUNTRY_ID = 'US') U
                                ON D.LOCATION_ID = U.LOCATION_ID
;
--SALARY * (1+0.2)
--커미션 공식
SELECT ROUND(AVG(E.SALARY),2),E.DEPARTMENT_ID,D.DEPARTMENT_NAME,
        RANK () OVER (ORDER BY AVG(E.SALARY) DESC) AS RNK
FROM  EMPLOYEES E INNER JOIN (SELECT D.*
                                FROM DEPARTMENTS D 
                                INNER JOIN (SELECT *
                                            FROM LOCATIONS 
                                            WHERE COUNTRY_ID = 'US') U
                                            ON D.LOCATION_ID = U.LOCATION_ID ) D
                 ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        GROUP BY E.DEPARTMENT_ID ,D.DEPARTMENT_NAME  
;

--
SELECT *
FROM (SELECT ROUND(AVG(E.SALARY),2),E.DEPARTMENT_ID,D.DEPARTMENT_NAME,
        RANK () OVER (ORDER BY AVG(E.SALARY) DESC) AS RNK
FROM  EMPLOYEES E INNER JOIN (SELECT D.*
                                FROM DEPARTMENTS D 
                INNER JOIN (SELECT *
                            FROM LOCATIONS 
                            WHERE COUNTRY_ID = 'US') U
                            ON D.LOCATION_ID = U.LOCATION_ID ) D
                 ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        GROUP BY E.DEPARTMENT_ID ,D.DEPARTMENT_NAME  )
WHERE RNK IN( 1,2,3)        
;

--나연이버전

SELECT DEPARTMENT_NAME, RNK
FROM ( SELECT D.DEPARTMENT_NAME, 
           RANK() OVER ( ORDER BY ROUND(AVG(CASE WHEN E.COMMISSION_PCT IS NULL
                                                 THEN E.SALARY
                                                 ELSE SALARY * (1 + E.COMMISSION_PCT)
                                             END), 2)) AS RNK
        FROM COUNTRIES C INNER JOIN LOCATIONS L 
                            ON C.COUNTRY_NAME = 'United States of America'
                            AND C.COUNTRY_ID = L.COUNTRY_ID
                         INNER JOIN DEPARTMENTS D
                            ON L.LOCATION_ID = D.LOCATION_ID
                         INNER JOIN EMPLOYEES E
                            ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        GROUP BY D.DEPARTMENT_NAME )
WHERE RNK IN (1, 2, 3)
;
SELECT AVG(SALARY)
FROM EMPLOYEES
 ;                   
 
SELECT AVG(SALARY),D.DEPARTMENT_NAME
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
                        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_ID,D.DEPARTMENT_NAME
;