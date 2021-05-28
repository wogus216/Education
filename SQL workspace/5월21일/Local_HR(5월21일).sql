--유통물류
--1. seattle에 근무하는 사원의 이름, 해당 사원의 매니저이름, 사원의 부서명을 구하고 연봉으로 순위를 매기시오. 
--사원이름 오름차순으로 출력하시오. 
--출력필드 : 사원명(last_name), 매니저이름(last_name), 부서명, 연봉, 연봉순위

SELECT E.*,L.CITY,D.DEPARTMENT_NAME,E2.LAST_NAME
FROM LOCATIONS L INNER JOIN DEPARTMENTS D
                        ON L.LOCATION_ID = D.LOCATION_ID
                 INNER JOIN EMPLOYEES E
                        ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
                 INNER JOIN EMPLOYEES E2
                        ON E.MANAGER_ID = E2.EMPLOYEE_ID
;
--1번정답
SELECT E3.LAST_NAME,E3.MG_NAME,E3.DEPARTMENT_NAME,E3.SALARY, E3.CITY,
        RANK() OVER(ORDER BY E3.SALARY DESC) AS RNK_SAL
FROM           (SELECT E.*,L.CITY,D.DEPARTMENT_NAME,E2.LAST_NAME AS MG_NAME
                FROM LOCATIONS L INNER JOIN DEPARTMENTS D
                                    ON L.LOCATION_ID = D.LOCATION_ID
                                INNER JOIN EMPLOYEES E
                                    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
                                INNER JOIN EMPLOYEES E2
                                    ON E.MANAGER_ID = E2.EMPLOYEE_ID) E3
WHERE E3.CITY IN 'Seattle'
ORDER BY E3.LAST_NAME DESC
;
--2. 각 부서별 최대 급여자 중 부서이동이 없었던 사람의 LAST_NAME, 급여, 부서명, 속한 부서의 평균 급여를 구하고, 
--단 LAST_NAME이 5글자 이상인 사원만 출력하고 LAST_NAME 오름차순으로 정렬하시오
--출력필드 : last_name, 급여, 급여평균

SELECT   E.*
FROM  ( SELECT LAST_NAME ,DEPARTMENT_ID, SALARY,EMPLOYEE_ID,
            RANK() OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS RNK
        FROM EMPLOYEES  ) E 
WHERE E.RNK =1 
;
--2번정답
SELECT  E2.LAST_NAME, E2.SALARY, A.DE_AVG
FROM JOB_HISTORY J RIGHT OUTER JOIN (SELECT   E.*
                              FROM  ( SELECT LAST_NAME ,DEPARTMENT_ID, SALARY,EMPLOYEE_ID,
                                        RANK() OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS RNK
                                      FROM EMPLOYEES  ) E 
                                      WHERE E.RNK =1 ) E2
                        ON J.EMPLOYEE_ID = E2.EMPLOYEE_ID  INNER JOIN (SELECT DEPARTMENT_ID, AVG(SALARY) AS DE_AVG
                                                                       FROM  EMPLOYEES 
                                                                       GROUP BY DEPARTMENT_ID) A
                                                            ON E2.DEPARTMENT_ID = A.DEPARTMENT_ID
WHERE J.EMPLOYEE_ID IS  NULL AND LENGTH (E2.LAST_NAME) >= 5
ORDER BY LAST_NAME ASC
;                                     
--부서평균구하기
SELECT DEPARTMENT_ID, AVG(SALARY) AS DE_AVG
FROM  EMPLOYEES 
GROUP BY DEPARTMENT_ID
;
--수빈이 정답
select last_name,salary,avg_sal
from (
select *
from employees e1 inner join (
select d.department_id,max(e.salary) as max_sal,round(avg(e.salary)) as avg_sal
from employees e inner join departments d
on e.department_id = d.department_id
group by d.department_id) a
on e1.department_id = a.department_id
and e1.salary = a.max_sal
where employee_id not in (select distinct employee_id
from job_history))
where length(last_name) >= 5
order by last_name;
;
SELECT E2.LAST_NAME,E2.SALARY,A.DE_AVG,E2.EMPLOYEE_ID
FROM (SELECT DEPARTMENT_ID, AVG(SALARY) AS DE_AVG
      FROM  EMPLOYEES 
     GROUP BY DEPARTMENT_ID) A  INNER JOIN (SELECT DISTINCT E.LAST_NAME,E.DEPARTMENT_ID,D.DEPARTMENT_NAME,E.SALARY,E.EMPLOYEE_ID,
                                            RANK() OVER(PARTITION BY E.DEPARTMENT_ID ORDER BY E.SALARY DESC) AS RNK
                                            FROM EMPLOYEES E 
                                        INNER JOIN JOB_HISTORY J
                                              ON E.EMPLOYEE_ID != J.EMPLOYEE_ID
                                              AND E.DEPARTMENT_ID = J.DEPARTMENT_ID
                                        INNER JOIN DEPARTMENTS D 
                                              ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                                 ORDER BY E.DEPARTMENT_ID DESC) E2
                        ON A.DEPARTMENT_ID = E2.DEPARTMENT_ID
WHERE E2.RNK = 1 AND LENGTH(E2.LAST_NAME) >= 5
ORDER BY E2.LAST_NAME ASC
;
--3. 아메리카 대륙에서 근무하는 사원 중 emp id가 180이하이면서 전체 사원의 급여 평균 이상인 사람을 구하시오. 단, 입사일이 빠른 3명을 이름(last_name)순서대로 정렬하시오 
--출력필드 : 입사일, 이름(last_name), 업무명, 입사일 순서

--아메리카 대륙에서 근무하는 사원 중 emp id가 180이하
SELECT E.LAST_NAME,E.HIRE_DATE,E.SALARY,E.JOB_ID
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D 
                        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                 INNER JOIN LOCATIONS L 
                        ON D.LOCATION_ID = L.LOCATION_ID
                 INNER JOIN COUNTRIES C
                        ON L.COUNTRY_ID = C.COUNTRY_ID
                 INNER JOIN REGIONS R
                        ON C.REGION_ID = R.REGION_ID
WHERE R.REGION_NAME = 'Americas' AND E.EMPLOYEE_ID <= 180
;

--전체 급여 평균
SELECT AVG(SALARY) AS AVG_SAL
FROM EMPLOYEES 
;

SELECT  E.*, CASE WHEN E.SALARY > A.AVG_SAL
                  THEN E.SALARY 
                  ELSE NULL
                  END AS RSAL,
        RANK() OVER (ORDER BY E.HIRE_DATE ASC) AS R_HIRE
FROM (SELECT AVG(SALARY) AS AVG_SAL
        FROM EMPLOYEES ) A INNER JOIN (SELECT E.LAST_NAME,E.HIRE_DATE,(E.SALARY)
                                        FROM EMPLOYEES E 
                                    INNER JOIN DEPARTMENTS D 
                                        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                                    INNER JOIN LOCATIONS L 
                                        ON D.LOCATION_ID = L.LOCATION_ID
                                    INNER JOIN COUNTRIES C
                                        ON L.COUNTRY_ID = C.COUNTRY_ID
                                    INNER JOIN REGIONS R
                                        ON C.REGION_ID = R.REGION_ID
                                        WHERE R.REGION_NAME = 'Americas' AND E.EMPLOYEE_ID <= 180) E
                            ON 1=1
;
--3번정답
SELECT E2.*,J.JOB_iD
FROM JOBS J INNER JOIN (SELECT  E.*, CASE WHEN E.SALARY > A.AVG_SAL
                  THEN E.SALARY 
                  ELSE NULL
                  END AS RSAL,
        RANK() OVER (ORDER BY E.HIRE_DATE ASC) AS R_HIRE
                     FROM (SELECT AVG(SALARY) AS AVG_SAL
                           FROM EMPLOYEES ) A   INNER JOIN (SELECT E.LAST_NAME,E.HIRE_DATE,E.SALARY,E.JOB_ID
                                                            FROM EMPLOYEES E 
                                                INNER JOIN DEPARTMENTS D 
                                                    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                                                INNER JOIN LOCATIONS L 
                                                    ON D.LOCATION_ID = L.LOCATION_ID
                                                INNER JOIN COUNTRIES C
                                                    ON L.COUNTRY_ID = C.COUNTRY_ID    
                                                INNER JOIN REGIONS R
                                                    ON C.REGION_ID = R.REGION_ID
                                            WHERE R.REGION_NAME = 'Americas' AND E.EMPLOYEE_ID <= 180) E
                                    ON 1=1) E2
                                ON J.JOB_ID = E2.JOB_ID
WHERE E2.R_HIRE BETWEEN 1 AND 3
ORDER BY E2.LAST_NAME ASC
;


--<HR 1번>

--영국에서 근무하고 있는 사람 중 FIRST_NAME 이 5글자 이상인 사원을 구하고, 
--근무도시와 부서명, 급여순위 5위까지(중복허용) 구하시오.
--출력 : 사원명(FIRST_NAME) , 근무도시 , 급여, 부서명을 순위대로 정렬하여 출력하시오.

SELECT *
FROM LOCATIONS L RIGHT OUTER JOIN DEPARTMENTS D
                        ON L.LOCATION_ID = D.LOCATION_ID
WHERE COUNTRY_ID = 'UK'                        
;
--정답
SELECT E.FIRST_NAME,U.CITY,E.SALARY, U.DEPARTMENT_NAME,
        RANK() OVER (ORDER BY E.SALARY DESC) AS RNK 
FROM (SELECT *
      FROM LOCATIONS L RIGHT OUTER JOIN DEPARTMENTS D
                        ON L.LOCATION_ID = D.LOCATION_ID
      WHERE COUNTRY_ID = 'UK'    ) U LEFT OUTER JOIN EMPLOYEES E 
                                        ON U.DEPARTMENT_ID = E.DEPARTMENT_ID
WHERE LENGTH(E.FIRST_NAME) >=5 
;
?

--<HR 2번>
--사원명이 FIRST_NAME이 J로 시작하면서 SALARY가 8000이상인 사원중 같은 도시에 사는 
--사원들의 최대 급여와 최소급여의 차이를 구하시오.
--출력 : 차이

SELECT COUNT(*),D.LOCATION_ID,MAX(E.SALARY)-MIN(E.SALARY)
FROM EMPLOYEES E  LEFT OUTER JOIN DEPARTMENTS D 
                        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.FIRST_NAME LIKE 'J%' AND E.SALARY >= 8000 
GROUP BY D.LOCATION_ID
;
--<HR 3번>
--주소가 10글자 이상인 나라 중 도시이름이 10글자 이하인 나라이름을 주소길이 오름차순으로 출력하시오.
-- 출력 : 주소 , 나라이름 , 주소길이
--정답
SELECT L.STREET_ADDRESS,C.COUNTRY_NAME,LENGTH(L.STREET_ADDRESS) AS LENGTH, L.CITY
FROM LOCATIONS L INNER JOIN COUNTRIES C 
                        ON L.COUNTRY_ID = C.COUNTRY_ID
WHERE LENGTH(L.STREET_ADDRESS) >= 10 AND LENGTH(L.CITY) <= 10
ORDER BY LENGTH(L.STREET_ADDRESS) ASC
;

--문제1)

-- 업무변경이 있었던 사원의 급여를 60%인상하여 전체사원의 급여순위를 구하고 1위~5위까지의 변경된 급여 합을 구하시오. 

-- 출력내용 : RSAL(변경된 급여 합)

SELECT DISTINCT E.*,CASE WHEN J.JOB_ID IS NOT NULL
            THEN E.SALARY * 1.6
            ELSE E.SALARY
            END AS RSAL
FROM EMPLOYEES E LEFT OUTER JOIN JOB_HISTORY J
                            ON E.EMPLOYEE_ID = J.EMPLOYEE_ID
                            AND E.JOB_ID != J.JOB_ID
;

SELECT E2.RSAL,RANK() OVER (ORDER BY E2.RSAL DESC) AS RNK
    FROM (SELECT DISTINCT E.*,CASE WHEN J.JOB_ID IS NOT NULL
            THEN E.SALARY * 1.6
            ELSE E.SALARY
            END AS RSAL
    FROM EMPLOYEES E INNER JOIN JOB_HISTORY J
                            ON E.EMPLOYEE_ID = J.EMPLOYEE_ID
                            AND E.JOB_ID != J.JOB_ID ) E2
;

SELECT
FROM EMPLOYEES E LEFT OUTER JOIN (SELECT J.*
                                  FROM (SELECT COUNT(*) AS CNT,EMPLOYEE_ID
                                  FROM JOB_HISTORY 
                                  GROUP BY EMPLOYEE_ID) J
                                  WHERE J.CNT > 1) J2
;
--문제2)

-- CITY:'Southlake'에서 근무하는 David의 급여 이상을 받는 David들의 순위를 매겨 1위 이외에 David들의 급여를 50% 인상하고 평균을 구하시오.
 -- 출력: 평균 (소수 둘째자리 반올림)
 
 SELECT
 FROM LOCATION L INNER JOIN DEPART
 ;
 