--4월 15일 
--이메일 이름 만들기
SELECT FIRST_NAME, LAST_NAME, EMAIL,
    SUBSTR(FIRST_NAME,1,1) || UPPER(SUBSTR(REPLACE(LAST_NAME,' ',''),1,7)) AS EM
FROM EMPLOYEES
;


--사원들의 근무하고있는 도시를 구하시오.

SELECT DISTINCT L.CITY
FROM LOCATIONS L INNER JOIN DEPARTMENTS D
                                ON L.LOCATION_ID = D.LOCATION_ID
                            INNER JOIN (SELECT DISTINCT DEPARTMENT_ID
                                        FROM EMPLOYEES) E
                                        ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
;

--미국에 근무하는 부서장들 중 전체 부서장 급여의 평균 이상이면 해당 부서장의 급여를 10% 삭감하시오
--부서장 이름, 연봉, 삭감된 연봉 출력


SELECT *
FROM COUNTRIES C INNER JOIN LOCATIONS L
                                ON C.COUNTRY_ID = L.COUNTRY_ID
                                AND C.COUNTRY_ID IN 'US'
;   




SELECT DISTINCT *
FROM
            (SELECT *
        FROM COUNTRIES C INNER JOIN LOCATIONS L
                                ON C.COUNTRY_ID = L.COUNTRY_ID
                                AND C.COUNTRY_ID IN 'US') C INNER JOIN DEPARTMENTS D
                                                            ON C.LOCATION_ID = D.LOCATION_ID
;

--미국에 근무하는 부서장들 중 전체 부서장 급여의 평균 이상이면 해당 부서장의 급여를 10% 삭감하시오
--부서장 이름, 연봉, 삭감된 연봉 출력

SELECT FLOOR(AVG(E.SALARY)) AS DAVG
FROM
        (SELECT DISTINCT *
FROM
            (SELECT *
        FROM COUNTRIES C INNER JOIN LOCATIONS L
                        ON C.COUNTRY_ID = L.COUNTRY_ID
                        AND C.COUNTRY_ID IN 'US') C 
                            INNER JOIN DEPARTMENTS D
                                 ON C.LOCATION_ID = D.LOCATION_ID) A 
                                 INNER JOIN EMPLOYEES E
                                    ON A.MANAGER_ID = E.EMPLOYEE_ID
;
--부서장이름,연봉,삭감된 연봉, 우리 문제 정답

SELECT E2.LAST_NAME,E2.SALARY,
    CASE WHEN E2.SALARY >= A2.DAVG
            THEN E2.SALARY * 0.9
            ELSE E2.SALARY
            END AS RSAL
FROM 
        (SELECT E.LAST_NAME,E.SALARY
         FROM
            (SELECT DISTINCT *
                FROM (SELECT *
                    FROM COUNTRIES C 
                        INNER JOIN LOCATIONS L
                            ON C.COUNTRY_ID = L.COUNTRY_ID
                                AND C.COUNTRY_ID IN 'US') C 
                                    INNER JOIN DEPARTMENTS D
                                        ON C.LOCATION_ID = D.LOCATION_ID) A 
                                        INNER JOIN EMPLOYEES E
                                  ON A.MANAGER_ID = E.EMPLOYEE_ID) E2 
                                  INNER JOIN (SELECT FLOOR(AVG(E.SALARY)) AS DAVG
                                  FROM (SELECT DISTINCT *
                                 FROM
                                (SELECT * FROM COUNTRIES C 
                                INNER JOIN LOCATIONS L
                                 ON C.COUNTRY_ID = L.COUNTRY_ID
                                AND C.COUNTRY_ID IN 'US') C 
                                    INNER JOIN DEPARTMENTS D
                                     ON C.LOCATION_ID = D.LOCATION_ID) A 
                                     INNER JOIN EMPLOYEES E
                                        ON A.MANAGER_ID = E.EMPLOYEE_ID ) A2
                                                ON 1=1
;
--2005년에 입사한 사람이 있는 부서기준으로/ 그 부서에서 2005년 이전에 입사한 사람의 부서명과 부서별로 평균 연봉을 구하시오.
--[ 부서명 | 평균연봉 ]

--05년 부서 기준 부서 번호
SELECT  DISTINCT DEPARTMENT_ID
FROM EMPLOYEES 
WHERE TO_CHAR(HIRE_DATE, 'YY') = 05  
GROUP BY DEPARTMENT_ID
;

--그 부서에서 2005년 이전에 입사한 사람의 부서명과 부서별로 평균 연봉을 구하시오.
--[ 부서명 | 평균연봉 ]

SELECT E.DEPARTMENT_ID,D3.DEPARTMENT_NAME,ROUND(AVG(E.SALARY)) AS RSAL
FROM  EMPLOYEES  E INNER JOIN (SELECT  DISTINCT DEPARTMENT_ID 
                                        FROM EMPLOYEES 
                                        WHERE TO_CHAR(HIRE_DATE, 'YY') = 05  
                                        GROUP BY DEPARTMENT_ID)  Y
                                 ON E.DEPARTMENT_ID = ID.DEPARTMENT_ID
                            INNER JOIN DEPARTMENTS D3
                                ON E.DEPARTMENT_ID = D3.DEPARTMENT_ID
                                    
WHERE TO_CHAR(HIRE_DATE, 'YY') <= 05
GROUP BY E.DEPARTMENT_ID,D3.DEPARTMENT_NAME
;
--샘 답버전

SELECT DISTINCT DEPARTMENT_ID
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = 2005
;


SELECT D.DEPARTMENT_NAME, ROUND(AVG(E.SALARY),2)AS AVG
FROM  EMPLOYEES E INNER JOIN ( SELECT DISTINCT DEPARTMENT_ID
                                FROM EMPLOYEES
                                WHERE TO_CHAR(HIRE_DATE, 'YYYY') = 2005) Y
                        ON E.DEPARTMENT_ID = Y.DEPARTMENT_ID
                    INNER JOIN DEPARTMENTS D 
                        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE TO_CHAR(HIRE_DATE, 'YYYY') <= 2005
GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME
;


-- 서비스2
--IT 부서 사람들의 급여평균을 구하고/ 전체 사원들 중에 방금 구한 급여평균(IT 부서 사람들의 급여평균)보다 높은 사원들의 급여를 50% 감봉하고 전체 사원의 정보를 출력하시오.
--출력 : 사람이름(풀네임), 사는도시, 급여, 부서이름

--IT 부서 사람들의 급여 평균

SELECT D.DEPARTMENT_NAME,AVG(E.SALARY) AS RSAL
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
                        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                        AND D.DEPARTMENT_NAME IN 'IT'
GROUP BY E.DEPARTMENT_ID,D.DEPARTMENT_NAME                      
;

--전체 사원들 중에 방금 구한 급여평균(IT 부서 사람들의 급여평균)보다 높은 사원들의 급여를 50% 감봉하고 전체 사원의 정보를 출력하시오.
--출력 : 사람이름(풀네임), 사는도시, 급여, 부서이름
SELECT *
FROM  EMPLOYEES E INNER JOIN ( SELECT AVG(E.SALARY) AS RAVG,D.LOCATION_ID  
                                FROM EMPLOYEES E 
                                INNER JOIN DEPARTMENTS D
                                ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                                AND D.DEPARTMENT_NAME ='IT'
                                GROUP BY E.DEPARTMENT_ID,D.DEPARTMENT_NAME,D.LOCATION_ID  ) A
                                ON 1=1 
                                INNER JOIN LOCATIONS L
                                ON A.LOCATION_ID = L.LOCATION_ID
                                INNER JOIN DEPARTMENTS D2 
                                ON L.LOCATION_ID = D2.LOCATION_ID
                                
;
--샘 답
SELECT E.FIRST_NAME || ' ' || E.LAST_NAME, L.CITY,
                        CASE WHEN E.SALARY > A.AVG_SAL
                        THEN E.SALARY * 0.5
                        ELSE E.SALARY
                        END AS RSAL, D.DEPARTMENT_NAME
                            FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
                            ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                        INNER JOIN LOCATIONS L
                            ON D.LOCATION_ID = L.LOCATION_ID
                        INNER JOIN (SELECT AVG(E.SALARY) AS AVG_SAL
                            FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
                            ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                            AND D.DEPARTMENT_NAME = 'IT') A
                            ON 1 = 1                  
;


