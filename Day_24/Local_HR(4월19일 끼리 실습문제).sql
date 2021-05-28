--4월19일 끼리 실습문제


--[유통 물류]
--영국에 있는 부서들의 부서별 평균 연봉/을 구하되 해당 평균 연봉이 전체 평균 연봉 이상인 경우만 부서명을 출력하시오.

SELECT *
FROM COUNTRIES C INNER JOIN LOCATIONS L
                        ON C.COUNTRY_ID  = L.COUNTRY_ID
                        AND COUNTRY_NAME = 'United Kingdom'
;

SELECT D.*
FROM DEPARTMENTS D INNER JOIN (SELECT *
                              FROM COUNTRIES C 
                   INNER JOIN LOCATIONS L
                              ON C.COUNTRY_ID  = L.COUNTRY_ID
                              AND COUNTRY_NAME = 'United Kingdom') U
                   ON D.LOCATION_ID = U.LOCATION_ID    
;

SELECT AVG(E.SALARY)AS AVG_SAL,U2.DEPARTMENT_NAME,
        RANK() OVER( ORDER BY AVG(E.SALARY) DESC) AS RNK
FROM EMPLOYEES E INNER JOIN (SELECT D.*
                           FROM DEPARTMENTS D 
               INNER JOIN (SELECT *
                            FROM COUNTRIES C 
               INNER JOIN LOCATIONS L
                            ON C.COUNTRY_ID  = L.COUNTRY_ID
                            AND COUNTRY_NAME = 'United Kingdom') U
               ON D.LOCATION_ID = U.LOCATION_ID ) U2
            ON E.DEPARTMENT_ID  = U2.DEPARTMENT_ID
GROUP BY E.DEPARTMENT_ID,U2.DEPARTMENT_NAME
;
--해당 평균 연봉이 전체 평균 연봉 이상인 경우만 부서명을 출력하시오.

SELECT  AVG(E2.SALARY)
FROM EMPLOYEES E2 
;



SELECT CASE WHEN E3.E_AVG < U3.AVG_SAL
              THEN U3.DEPARTMENT_NAME
              ELSE NULL
              END AS RESULT
FROM (SELECT  AVG(E2.SALARY) AS E_AVG
      FROM EMPLOYEES E2 ) E3 INNER JOIN (SELECT AVG(E.SALARY)AS AVG_SAL,U2.DEPARTMENT_NAME,
                                         RANK() OVER( ORDER BY AVG(E.SALARY) DESC) AS RNK
                                         FROM EMPLOYEES E 
                             INNER JOIN (SELECT D.*
                                         FROM DEPARTMENTS D 
                            INNER JOIN (SELECT *
                                         FROM COUNTRIES C 
                            INNER JOIN LOCATIONS L
                                        ON C.COUNTRY_ID  = L.COUNTRY_ID
                                        AND COUNTRY_NAME = 'United Kingdom') U
                                        ON D.LOCATION_ID = U.LOCATION_ID ) U2
                                        ON E.DEPARTMENT_ID  = U2.DEPARTMENT_ID
                            GROUP BY E.DEPARTMENT_ID,U2.DEPARTMENT_NAME) U3
                        ON 1=1
;
--금융
-- JOB_ID가 PU_MAN인 사람의 급여와 같은 범위에 있는 사람 중 가장 높은 연봉을 받는 직원을 출력하시오.
-- 이름만 출력하시오.

SELECT E.EMPLOYEE_ID,(FIRST_NAME || LAST_NAME) AS NAME, J.*
FROM EMPLOYEES E INNER JOIN JOBS J 
                        ON E.JOB_ID = J.JOB_ID
                        AND E.SALARY BETWEEN MIN_SALARY AND MAX_SALARY
                        AND E.JOB_ID ='PU_MAN'
;
SELECT *
FROM            (SELECT (E2.FIRST_NAME || E2.LAST_NAME)AS NAME,E2.SALARY,
                    RANK() OVER (ORDER BY E2.SALARY DESC) AS RNK
                FROM EMPLOYEES E2 
    INNER JOIN (SELECT E.EMPLOYEE_ID,(FIRST_NAME || LAST_NAME) AS NAME, J.*
                FROM EMPLOYEES E 
    INNER JOIN JOBS J 
                ON E.JOB_ID = J.JOB_ID
                AND E.SALARY BETWEEN MIN_SALARY AND MAX_SALARY 
                AND E.JOB_ID ='PU_MAN') P
                ON E2.SALARY BETWEEN P.MIN_SALARY AND P.MAX_SALARY ) P2
    WHERE  P2.RNK = 1
;


--서비스2 답확인
-- 이름이 J로 시작하는 직원중에서 가장 많이 속해있는 부서의 상급자를 구하고, 전체 직원에서 그 상급자보다 적은 급여를 받는 직원들의 평균급여를 구하시오.
-- 출력은 소수점 2째자리까지.

SELECT DEPARTMENT_ID,COUNT(*),
    RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
FROM EMPLOYEES 
WHERE FIRST_NAME LIKE 'J%' 
GROUP BY DEPARTMENT_ID
;
SELECT D.MANAGER_ID
FROM DEPARTMENTS D INNER JOIN (SELECT DEPARTMENT_ID,COUNT(*),
                               RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
                               FROM EMPLOYEES
                               WHERE FIRST_NAME LIKE 'J%' 
                               GROUP BY DEPARTMENT_ID) J
                        ON D.DEPARTMENT_ID = J.DEPARTMENT_ID   
                        AND J.RNK = 1
                            
;
SELECT E2.SALARY AS PSAL
FROM EMPLOYEES E2 INNER JOIN (SELECT D.MANAGER_ID
                              FROM DEPARTMENTS D 
                  INNER JOIN (SELECT DEPARTMENT_ID,COUNT(*),
                               RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
                               FROM EMPLOYEES
                               WHERE FIRST_NAME LIKE 'J%' 
                               GROUP BY DEPARTMENT_ID) J
                        ON D.DEPARTMENT_ID = J.DEPARTMENT_ID   
                        AND J.RNK = 1) J2
                ON E2.EMPLOYEE_ID = J2.MANAGER_ID
;

SELECT (E.FIRST_NAME || E.LAST_NAME) AS NAME, CASE WHEN E.SALARY < J3.PSAL
                                                   THEN E.SALARY
                                                   ELSE NULL
                                                   END AS RSAL,J3.PSAL
FROM EMPLOYEES E INNER JOIN (SELECT E2.SALARY AS PSAL
                             FROM EMPLOYEES E2 
                 INNER JOIN (SELECT D.MANAGER_ID
                              FROM DEPARTMENTS D 
                 INNER JOIN (SELECT DEPARTMENT_ID,COUNT(*),
                                RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
                            FROM EMPLOYEES
                            WHERE FIRST_NAME LIKE 'J%' 
                            GROUP BY DEPARTMENT_ID) J
                        ON D.DEPARTMENT_ID = J.DEPARTMENT_ID   
                        AND J.RNK = 1) J2
                ON E2.EMPLOYEE_ID = J2.MANAGER_ID) J3
            ON 1 = 1
;
SELECT ROUND(AVG(J4.RSAL),2)
FROM        (SELECT (E.FIRST_NAME || E.LAST_NAME) AS NAME, CASE WHEN E.SALARY < J3.PSAL
                                                                THEN E.SALARY
                                                                ELSE NULL
                                                                END AS RSAL,J3.PSAL
            FROM EMPLOYEES E 
        INNER JOIN (SELECT E2.SALARY AS PSAL
                    FROM EMPLOYEES E2 
        INNER JOIN (SELECT D.MANAGER_ID
                    FROM DEPARTMENTS D 
        INNER JOIN (SELECT DEPARTMENT_ID,COUNT(*),
                           RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
                    FROM EMPLOYEES
                    WHERE FIRST_NAME LIKE 'J%' 
                    GROUP BY DEPARTMENT_ID) J
                ON D.DEPARTMENT_ID = J.DEPARTMENT_ID   
                AND J.RNK = 1) J2
                ON E2.EMPLOYEE_ID = J2.MANAGER_ID) J3
            ON 1 = 1) J4
WHERE J4.RSAL IS NOT NULL
;
--공공1 답 이 이상
-- 사원들의 급여순위(공동순위 제외) 중 3~6위까지 사원을 구하고 
--그중 업무나 부서변동이 있던 사람들을 FIRST_NAME,LAST_NAME,SALARY,JOB_TITLE 포함하여 출력하시오

SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,SALARY,
      RANK() OVER (ORDER BY SALARY DESC ) AS RNK
FROM EMPLOYEES
;

SELECT *
FROM JOB_HISTORY J INNER JOIN (SELECT EMPLOYEE_ID,FIRST_NAME,SALARY,
                                    ROW_NUMBER()OVER(ORDER BY SALARY DESC ) AS RNK
                               FROM EMPLOYEES) A
                                 ON J.EMPLOYEE_ID = A.EMPLOYEE_ID
                               AND A.RNK > 2 AND A.RNK <= 6        
;
--서비스 1,공부필요
-- 부서 이동한 사람 중에서 급여가 10000미만인 경우 급여의 50퍼센트 커미션을 주어서
--전체급여(커미션 포함) 순위중 1등부터 5등까지 직원의 정보를 출력하시오.

SELECT DISTINCT E.EMPLOYEE_ID AS LIST,CASE WHEN E.SALARY < 10000
                                           THEN E.SALARY * 1.5
                                           ELSE E.SALARY
                                           END AS RSAL
FROM EMPLOYEES E INNER JOIN JOB_HISTORY J 
                                ON E.EMPLOYEE_ID = J.EMPLOYEE_ID
;
SELECT E.*
FROM 
(SELECT  (SALARY*(1+NVL(COMMISSION_PCT,0))) AS RSAL,RANK()OVER (ORDER BY (SALARY*(1+NVL(COMMISSION_PCT,0))) DESC) AS RNK
FROM EMPLOYEES)E INNER JOIN (SELECT DISTINCT E.EMPLOYEE_ID AS LIST,CASE WHEN E.SALARY < 10000
                                           THEN E.SALARY * 1.5
                                           ELSE  E.SALARY
                                           END AS RSAL
FROM EMPLOYEES E INNER JOIN JOB_HISTORY J 
                                ON E.EMPLOYEE_ID = J.EMPLOYEE_ID) J2
                            ON 1 = 1
;
--공공2
-- IT부서사람들의 급여 순위를 구하고 1등의 근무도시를 출력하세요.

SELECT E.*,RANK() OVER (ORDER BY E.SALARY DESC) AS RNK,D.LOCATION_ID
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D 
                            ON E.DEPARTMENT_ID =D.DEPARTMENT_ID
                            AND D.DEPARTMENT_NAME = 'IT'
;

SELECT L.*
FROM LOCATIONS L INNER JOIN (SELECT E.*,RANK() OVER (ORDER BY E.SALARY DESC) AS RNK,D.LOCATION_ID
                            FROM EMPLOYEES E 
                 INNER JOIN DEPARTMENTS D 
                            ON E.DEPARTMENT_ID =D.DEPARTMENT_ID
                            AND D.DEPARTMENT_NAME = 'IT') C
                        ON L.LOCATION_ID = C.LOCATION_ID
                        AND C.RNK = 1                      
;






SELECT *
    FROM
    (SELECT DISTINCT A.FIRST_NAME, RANK()OVER(ORDER BY NEW_SAL DESC) AS RNK
        FROM
        (SELECT CASE WHEN E.SALARY < 10000
                    THEN E.SALARY * 1.5
                    ELSE E.SALARY
                    END AS NEW_SAL,
                    E.*
            FROM EMPLOYEES E INNER JOIN JOB_HISTORY H
            ON E.EMPLOYEE_ID = H.EMPLOYEE_ID) A)
    WHERE RNK < 6;