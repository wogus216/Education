--1.부서별 직원수

SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
order by count(*) desc
;
--2.부서별 평균 급여

SELECT DEPARTMENT_ID,ROUND(AVG(SALARY),-1) AS AVG_SAL,COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
;
--3.직책별 평균급여(평균급여 기준 상위 7개 직책만)

SELECT *
FROM  (SELECT JOB_ID,AVG(SALARY) AS JOB_ASAL,COUNT(*),
             RANK() OVER (ORDER BY AVG(SALARY) DESC) AS RNK
        FROM EMPLOYEES
        GROUP BY JOB_ID ) E
WHERE E.RNK < 8
;

--4.자신의 매니저 보다 더 많은 급여를 받는 사람 목록

SELECT M.MANAGER_ID, (E.FIRST_NAME || E.LAST_NAME) AS NAME, E.SALARY
FROM (  SELECT DISTINCT MANAGER_ID
        FROM EMPLOYEES ) M INNER JOIN EMPLOYEES E
                                    ON M.MANAGER_ID = E.EMPLOYEE_ID
;

SELECT R.EMPLOYEE_ID,R.LAST_NAME
FROM (  SELECT E2.EMPLOYEE_ID, E2.LAST_NAME,E2.SALARY,M2.SALARY,
                            CASE WHEN E2.SALARY > M2.SALARY
                                 THEN E2.SALARY 
                                 ELSE NULL 
                                 END AS RSAL
        FROM EMPLOYEES E2 INNER JOIN (SELECT M.MANAGER_ID, (E.FIRST_NAME || E.LAST_NAME) AS NAME, E.SALARY
                                      FROM (  SELECT DISTINCT MANAGER_ID
                                              FROM EMPLOYEES ) M INNER JOIN EMPLOYEES E
                                      ON M.MANAGER_ID = E.EMPLOYEE_ID) M2
                            ON E2.MANAGER_ID = M2.MANAGER_ID ) R
WHERE R.RSAL IS NOT NULL
;
--간단한 정답--
SELECT E.*
FROM EMPLOYEES E INNER JOIN EMPLOYEES ES 
                         ON E.MANAGER_ID = ES.EMPLOYEE_ID
WHERE E.SALARY > ES.SALARY
;
--5.job title이 sales representative인 직원 중에서, 급여가 9,000 ~ 10,000 인 직원들의 이름과 급여를 출력

SELECT E.FIRST_NAME,E.LAST_NAME,E.SALARY,J.JOB_TITLE
FROM EMPLOYEES E INNER JOIN JOBS J 
                         ON E.JOB_ID = J.JOB_ID
WHERE J.JOB_TITLE IN 'Sales Representative' AND E.SALARY BETWEEN 9000 AND 10000
;

--6.각 직급별로 급여의 총합을 구하고자 한다.
--급여총합이 가장 높은 직급순으로 급여 총합을 출력하시오.(단,급여총합이 30,000 이상인 직급만 출력 할 것)

SELECT J.JOB_TITLE,SUM(E.SALARY) AS SUB_SAL,COUNT(*),
    RANK() OVER (ORDER BY SUM(E.SALARY) DESC) AS RNK
FROM EMPLOYEES E INNER JOIN JOBS J 
                    ON E.JOB_ID = J.JOB_ID
GROUP BY J.JOB_TITLE
;

SELECT E.*
FROM (SELECT J.JOB_TITLE,SUM(E.SALARY) AS SUM_SAL,COUNT(*),
            RANK() OVER (ORDER BY SUM(E.SALARY) DESC) AS RNK
      FROM EMPLOYEES E INNER JOIN JOBS J 
                    ON E.JOB_ID = J.JOB_ID
      GROUP BY J.JOB_TITLE) E
WHERE E.SUM_SAL >= 30000
;
--간단한 버전
SELECT J.JOB_TITLE,SUM(E.SALARY) AS SUB_SAL,COUNT(*)
FROM EMPLOYEES E INNER JOIN JOBS J 
                    ON E.JOB_ID = J.JOB_ID
GROUP BY J.JOB_TITLE
HAVING SUM(E.SALARY) > 30000
ORDER BY SUM(E.SALARY) DESC
;
--7. 각 도시별 평균 연봉(급여)가 높은 순으로 상위 3개도시를 출력하시오.

SELECT C.*
FROM (  SELECT L.CITY,AVG(E.SALARY),RANK() OVER (ORDER BY AVG(E.SALARY) DESC) AS RNK
        FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
                                 ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                         LEFT OUTER JOIN LOCATIONS L
                                 ON D.LOCATION_ID = L.LOCATION_ID
        GROUP BY L.CITY ) C
WHERE C.RNK BETWEEN 1 AND 3
;
--8. 직책(JOB TITLE)이 'Sales Manager'인 사원들의 입사년도(hire_date)별 평균급여를 출력하시오
--출력 시 년도를 기준으로 오름차순 정렬하시오.

SELECT TO_CHAR(E.HIRE_DATE, 'YY') AS YY
FROM EMPLOYEES E INNER JOIN JOBS J 
                ON E.JOB_ID  = J.JOB_ID
WHERE J.JOB_TITLE IN 'Sales Manager'
;

SELECT AVG(E.SALARY),TO_CHAR(E.HIRE_DATE, 'YY')
FROM EMPLOYEES E INNER JOIN (SELECT TO_CHAR(E.HIRE_DATE, 'YY') AS YY
                             FROM EMPLOYEES E INNER JOIN JOBS J 
                                              ON E.JOB_ID  = J.JOB_ID
                             WHERE J.JOB_TITLE IN 'Sales Manager') Y
                    ON 1=1
WHERE TO_CHAR(E.HIRE_DATE, 'YY') = Y.YY
GROUP BY TO_CHAR(E.HIRE_DATE, 'YY')
ORDER BY TO_CHAR(E.HIRE_DATE, 'YY') ASC
;

SELECT TO_CHAR(E.HIRE_DATE, 'YYYY') AS HIRE_YEAR, ROUND(AVG(E.SALARY)) AS AVG_SAL
FROM EMPLOYEES E INNER JOIN JOBS J 
                         ON E.JOB_ID = J.JOB_ID
WHERE J.JOB_TITLE IN 'Sales Manager'
GROUP BY TO_CHAR(E.HIRE_DATE, 'YYYY')
ORDER BY TO_CHAR(E.HIRE_DATE, 'YYYY')
;

--여기서부터 보기
--9. 각 도시(city)에 있는 모든 부서 직원들의 평균급여를 조회하고자 한다.
--평균급여가 가장 낮은 도시부터 도시명(city)과 평균연봉, 해당도시의 직원수를 출력하시오
--단, 도시에 근무하는 직원이 10명 이상인 곳은 제외하고 조회하시오.
SELECT L.LOCATION_ID,L.CITY,D.DEPARTMENT_ID,D.DEPARTMENT_NAME
FROM LOCATIONS L INNER  JOIN DEPARTMENTS D 
                             ON L.LOCATION_ID = D.LOCATION_ID                         
;

SELECT C.CITY,COUNT(*),AVG(E.SALARY) AS AVG_SAL,RANK() OVER(ORDER BY AVG(E.SALARY) DESC ) AS RNK
FROM EMPLOYEES E LEFT OUTER JOIN (SELECT L.LOCATION_ID,L.CITY,D.DEPARTMENT_ID,D.DEPARTMENT_NAME
                                  FROM LOCATIONS L INNER JOIN DEPARTMENTS D 
                                                         ON L.LOCATION_ID = D.LOCATION_ID) C
                            ON E.DEPARTMENT_ID = C.DEPARTMENT_ID
GROUP BY C.CITY                        
;

SELECT *
FROM (SELECT C.CITY,COUNT(*)AS CNT,AVG(E.SALARY) AS AVG_SAL,RANK() OVER(ORDER BY AVG(E.SALARY) DESC ) AS RNK
      FROM EMPLOYEES E LEFT OUTER JOIN (SELECT L.LOCATION_ID,L.CITY,D.DEPARTMENT_ID,D.DEPARTMENT_NAME
                                        FROM LOCATIONS L INNER JOIN DEPARTMENTS D 
                                                               ON L.LOCATION_ID = D.LOCATION_ID) C
                                  ON E.DEPARTMENT_ID = C.DEPARTMENT_ID
                                  GROUP BY C.CITY) C2
WHERE C2.CNT < 10
;

--10.'Public Accountnat'의 직책(job_title)으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력

SELECT E.EMPLOYEE_ID,E.FIRST_NAME,E.LAST_NAME,JH.*,J.JOB_TITLE
FROM JOB_HISTORY JH INNER JOIN JOBS J
                                ON J.JOB_ID = JH.JOB_ID
                    INNER JOIN EMPLOYEES E
                                ON JH.EMPLOYEE_ID = E.EMPLOYEE_ID
WHERE J.JOB_TITLE IN 'Public Accountant'
;
--11.2007녀에 입사(HIRE_DATE) 한 직원들의 사번(EMPLOYEE_ID),이름(FIRST_NAME),성(LAST_NAME),부서명(DEPARTMENT_NAME)을
--조회합니다. 이때, 부서에 배치되지 않을 경우,'<NOT ASSIGNED>'로 출력하시오

SELECT E.EMPLOYEE_ID,E.FIRST_NAME,E.LAST_NAME,
       CASE WHEN D.DEPARTMENT_NAME IS NULL
            THEN '<NOT ASSIGNED>'
            ELSE D.DEPARTMENT_NAME
            END AS RDNAME
FROM EMPLOYEES E LEFT OUTER JOIN DEPARTMENTS D 
                       ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE TO_CHAR(HIRE_DATE, 'YY') IN 07
;
--12.부서별로 가장 적은 급여를 받고 있는 직원의 이름, 부서이름, 급여를 출력하시오.
--이름은 LAST_NAME만 출력하며, 부서이름으로 오름차순 정렬하고, 부서가 같은 경우 이름을 기준으로 오름차순 정렬하여 출력합니다.

SELECT DEPARTMENT_ID,SALARY
FROM EMPLOYEES 
GROUP BY DEPARTMENT_ID,SALARY
;

SELECT  MIN(M.SALARY),D.DEPARTMENT_NAME,E.LAST_NAME,
        RANK() OVER(ORDER BY E.LAST_NAME ASC)
FROM (SELECT DEPARTMENT_ID,SALARY
      FROM EMPLOYEES 
      GROUP BY DEPARTMENT_ID,SALARY) M  INNER JOIN EMPLOYEES E 
                                              ON M.DEPARTMENT_ID = E.DEPARTMENT_ID
                                        INNER JOIN DEPARTMENTS D
                                              ON M.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY M.DEPARTMENT_ID,D.DEPARTMENT_NAME,E.LAST_NAME
ORDER BY D.DEPARTMENT_NAME ASC
;

--13.EMPLOYEES 테이블에서 급여를 많이 받는 순서대로 조회했을 때 6번째부터 10번째 까지의 직원의 LAST_NAEM,FIRST_NAME,SALARY
--를 조회하는 SQL 문장을 작성하시오
SELECT W.* 
FROM (  SELECT LAST_NAME,FIRST_NAME,SALARY,
            RANK() OVER(ORDER BY SALARY DESC) AS RNK
        FROM EMPLOYEES ) W
WHERE W.RNK BETWEEN 6 AND 10
;

--14.'SALES' 부서에 속한 직원이름(퍼스트),급여,부서이름을 조회하시오.
--단, 급여는 100번 부서의 평균보다 적게 받는 직원 정보만 출력되어야한다.

SELECT E.FIRST_NAME,E.SALARY,D.DEPARTMENT_NAME
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D 
                       ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE D.DEPARTMENT_NAME IN 'Sales'
;

SELECT AVG(SALARY) AS AVG_SAL,DEPARTMENT_ID
FROM EMPLOYEES 
WHERE DEPARTMENT_ID IN 100
GROUP BY DEPARTMENT_ID
;
SELECT E3.FIRST_NAME,E3.SALARY,E3.DEPARTMENT_NAME
FROM  ( SELECT E2.*, CASE WHEN E2.SALARY < A.AVG_SAL
                          THEN E2.SALARY
                          ELSE NULL
                          END AS RSAL
        FROM (SELECT AVG(SALARY) AS AVG_SAL,DEPARTMENT_ID
              FROM EMPLOYEES 
              WHERE DEPARTMENT_ID IN 100
              GROUP BY DEPARTMENT_ID) A INNER JOIN (SELECT E.FIRST_NAME,E.SALARY,D.DEPARTMENT_NAME
                                                    FROM EMPLOYEES E INNER JOIN DEPARTMENTS D 
                                                    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                                                    WHERE D.DEPARTMENT_NAME IN 'Sales') E2
                                        ON 1=1 ) E3
WHERE E3.RSAL IS NOT NULL
;
--15.부서별 입사월별 직원수를 출력하시오.
--단, 직원수가 5명 이상인 부서만 출력되어야 하며 출력결과는 부서이름 순으로 한다.
--(결과에서 5명이상 또는 부서원 5명이상)

SELECT DEPARTMENT_ID,TO_CHAR(HIRE_DATE, 'MM'), COUNT(*)
FROM EMPLOYEES 
GROUP BY DEPARTMENT_ID, TO_CHAR(HIRE_DATE, 'MM')
;

SELECT DE.*,D.DEPARTMENT_NAME
FROM DEPARTMENTS D INNER JOIN (SELECT DEPARTMENT_ID,TO_CHAR(HIRE_DATE, 'MM'), COUNT(*) AS CNT
                               FROM EMPLOYEES 
                               GROUP BY DEPARTMENT_ID, TO_CHAR(HIRE_DATE, 'MM')) DE
                    ON D.DEPARTMENT_ID = DE.DEPARTMENT_ID
WHERE DE.CNT >= 5 
ORDER BY D.DEPARTMENT_NAME DESC
;

--16.커며션을 가장 많이 받은 상위 4명의 부서명,직원명(퍼스트),급여,커미션정보를 조회
--출력결과는 커미션을 많이 받는 순서로 출력하되 동일한 커미션에 대해서는 급여가 높은 직원 먼저 출력

SELECT FIRST_NAME,SALARY,COMMISSION_PCT,DEPARTMENT_ID,(SALARY *(COMMISSION_PCT +1)) AS COMM_SAL,
    RANK() OVER(ORDER BY (SALARY *(COMMISSION_PCT +1)) DESC) AS RNK
FROM EMPLOYEES 
WHERE COMMISSION_PCT IS NOT NULL
;







