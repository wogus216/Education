--�Ի����� ���� ������� ��� 10���� ���Ͻÿ�.,

SELECT HIRE_DATE,FIRST_NAME,
    RANK() OVER(ORDER BY HIRE_DATE DESC) AS RHIR
    
FROM EMPLOYEES
;

SELECT *
FROM (SELECT HIRE_DATE,FIRST_NAME,
    RANK() OVER(ORDER BY HIRE_DATE DESC) AS RHIR
    FROM EMPLOYEES ) E
    
WHERE E.RHIR <=10
;
--�� ������� ������ ���� �������� �� �ּұ޿��� �ִ�޿��� ���Ͻÿ�.
-- ��� : �����, ������, �޿� ,���� �ּұ޿�, ���� �ִ�޿�
SELECT FIRST_NAME,JOB_ID,SALARY,
    RANK() OVER(PARTITION BY JOB_ID ORDER BY SALARY DESC) AS RSAL
FROM EMPLOYEES
;

SELECT E.LAST_NAME,J.JOB_TITLE,E.SALARY, J.MIN_SALARY, J.MAX_SALARY
FROM EMPLOYEES E INNER JOIN JOBS J
                        ON E.JOB_ID = J.JOB_ID
;

--상급자별 부하직원이 가장 많은 업무를 구하시오.
--답 28개
SELECT E.* ,
    RANK() OVER(PARTITION BY E.MANAGER_ID)
FROM EMPLOYEES E INNER JOIN EMPLOYEES E2 
                        ON E.MANAGER_ID = E2.EMPLOYEE_ID

;


SELECT  COUNT(M.JOB_ID),M.JOB_ID,M.MANAGER_ID
FROM ( SELECT E.* 
        FROM EMPLOYEES E INNER JOIN EMPLOYEES E2 
                        ON E.MANAGER_ID = E2.EMPLOYEE_ID
                        ORDER BY E.JOB_ID) M
GROUP BY M.JOB_ID,M.MANAGER_ID
;


--우리문제

SELECT E.LAST_NAME,D.DEPARTMENT_NAME,E.SALARY,
    RANK() OVER( ORDER BY E.SALARY ) AS RNK
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
                                ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
;

SELECT D.DEPARTMENT_NAME
FROM  (SELECT E.LAST_NAME,D.DEPARTMENT_NAME,E.SALARY,
         RANK() OVER( ORDER BY E.SALARY ) AS RNK
            FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
                                ON E.DEPARTMENT_ID = D.DEPARTMENT_ID) D
WHERE RNK = 2
;

---- FIRST_NAME 글자 수가 5글자 미만인 사원들이 가장 많이 포함된 부서명을 구하시오.
-- 출력 : 부서명

SELECT LENGTH(E.FIRST_NAME) AS RNAME,E.JOB_ID, D.DEPARTMENT_ID
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D 
                            ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
;

SELECT COUNT(E2.DEPARTMENT_NAME),E2.DEPARTMENT_NAME,
    RANK() OVER(ORDER BY COUNT(E2.DEPARTMENT_NAME) DESC) 
FROM (SELECT LENGTH(E.FIRST_NAME) AS RNAME,E.JOB_ID, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
                        FROM EMPLOYEES E INNER JOIN DEPARTMENTS D 
                            ON E.DEPARTMENT_ID = D.DEPARTMENT_ID) E2
WHERE RNAME < 5
GROUP BY E2.DEPARTMENT_NAME
;

--상급자중에서 부하직원이 가장많은 사람의 부하직원들 중에서 휴대폰 번호에 4가 2개이상 들어가는 사람들의 
-- 급여가 10,000원이 넘을경우 30% 삭감 랭킹 3위까지 합을 구하시오

SELECT MANAGER_ID, COUNT(MANAGER_ID),
    RANK()OVER(ORDER BY COUNT(MANAGER_ID) DESC) AS CNT
FROM EMPLOYEES 
GROUP BY MANAGER_ID
;

SELECT *
FROM  EMPLOYEES E2 INNER JOIN (SELECT MANAGER_ID, COUNT(MANAGER_ID),
                         RANK()OVER(ORDER BY COUNT(MANAGER_ID) DESC) AS CNT
                        FROM EMPLOYEES 
                        GROUP BY MANAGER_ID) M
                ON E2.MANAGER_ID = M.MANAGER_ID
WHERE CNT = 1
;
--상급자중에서 부하직원이 가장많은 사람의 부하직원들 중에서 휴대폰 번호에 4가 2개이상 들어가는 사람들의 
-- 급여가 10,000원이 넘을경우 30% 삭감 랭킹 3위까지 합을 구하시오
SELECT M2.*,
        CASE WHEN M2.SALARY > 10000
        THEN M2.SALARY * 0.7 
        ELSE M2.SALARY
        END AS RSAL
FROM (SELECT *
FROM  EMPLOYEES E2 INNER JOIN (SELECT MANAGER_ID, COUNT(MANAGER_ID),
                                 RANK()OVER(ORDER BY COUNT(MANAGER_ID) DESC) AS CNT
                                FROM EMPLOYEES 
                                GROUP BY MANAGER_ID) M
                                ON E2.MANAGER_ID = M.MANAGER_ID     
                                WHERE CNT = 1) M2
WHERE M2.PHONE_NUMBER LIKE '%4%4%'
;
SELECT M3.RSAL,
    RANK() OVER (ORDER BY M3.RSAL DESC) AS RNK
FROM (SELECT M2.*,
        CASE WHEN M2.SALARY > 10000
        THEN M2.SALARY * 0.7 
        ELSE M2.SALARY
        END AS RSAL
FROM (SELECT *
            FROM  EMPLOYEES E2 INNER JOIN (SELECT MANAGER_ID, COUNT(MANAGER_ID),
                                 RANK()OVER(ORDER BY COUNT(MANAGER_ID) DESC) AS CNT
                                FROM EMPLOYEES 
                                GROUP BY MANAGER_ID) M
                                ON E2.MANAGER_ID = M.MANAGER_ID     
                                WHERE CNT = 1) M2
            WHERE M2.PHONE_NUMBER LIKE '%4%4%') M3
ORDER BY M3.RSAL DESC
;

SELECT SUM(RSAL)
FROM (SELECT M3.RSAL,
        RANK() OVER (ORDER BY M3.RSAL DESC) AS RNK
        FROM (SELECT M2.*,
        CASE WHEN M2.SALARY > 10000
        THEN M2.SALARY * 0.7 
        ELSE M2.SALARY
        END AS RSAL
                        FROM (SELECT *
                        FROM  EMPLOYEES E2 INNER JOIN (SELECT MANAGER_ID, COUNT(MANAGER_ID),
                                 RANK()OVER(ORDER BY COUNT(MANAGER_ID) DESC) AS CNT
                                FROM EMPLOYEES 
                                GROUP BY MANAGER_ID) M
                                ON E2.MANAGER_ID = M.MANAGER_ID     
                                WHERE CNT = 1) M2
            WHERE M2.PHONE_NUMBER LIKE '%4%4%') M3
            ORDER BY M3.RSAL DESC)M4
        WHERE M4.RNK < 4
;

---- 부서변동이 있었고, 핸드폰 번호 515로 시작하는 사원들 중
-- 급여순위 1위의 급여를 15% 삭감하고 삭감된급여와 이름을 출력하시오

SELECT DISTINCT E.FIRST_NAME,E.SALARY,
    RANK()OVER(ORDER BY E.SALARY DESC) AS RSAL
FROM EMPLOYEES E INNER JOIN JOB_HISTORY J
                            ON E.EMPLOYEE_ID = J.EMPLOYEE_ID
WHERE E.PHONE_NUMBER LIKE '515%'
;

SELECT R.FIRST_NAME,
    CASE WHEN R.RSAL =1
         THEN R.SALARY * 0.85
         END AS MSAL
FROM (SELECT DISTINCT E.FIRST_NAME,E.SALARY,
      RANK()OVER(ORDER BY E.SALARY DESC) AS RSAL
        FROM EMPLOYEES E INNER JOIN JOB_HISTORY J
                            ON E.EMPLOYEE_ID = J.EMPLOYEE_ID
                WHERE E.PHONE_NUMBER LIKE '515%') R
WHERE RSAL =1
;
--2006년에 입사한 사원들이 근무하고있는 도시를 구하고,
--도시별 평균급여가 높은 순서대로 도시명과 평균급여 출력하세요. (소수점 2자리까지)

SELECT L.CITY,ROUND(AVG(E.SALARY),2),
    RANK() OVER(ORDER BY AVG(E.SALARY) DESC) AS RSAL
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D 
                        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                        INNER JOIN LOCATIONS L
                        ON D.LOCATION_ID = L.LOCATION_ID
WHERE TO_CHAR(HIRE_DATE, 'YY') ='06'
GROUP BY L.CITY
;
--입사날짜가 가장 늦은 사람의 JOB_TITLE을 출력하시오

SELECT DISTINCT E2.JOB_TITLE
FROM 
           ( SELECT E.*,J.JOB_TITLE,
            RANK() OVER(ORDER BY HIRE_DATE DESC) AS RNK
            FROM EMPLOYEES E INNER JOIN JOBS J 
                                    ON E.JOB_ID = J.JOB_ID) E2
WHERE E2.RNK=1                                    
;

--상급자별 부하직원이 가장 많은 업무를 구하시오.

SELECT MANAGER_ID,JOB_ID,COUNT(*),
    RANK() OVER (PARTITION BY MANAGER_ID ORDER BY COUNT(*) DESC) AS RNK
FROM EMPLOYEES 
GROUP BY MANAGER_ID, JOB_ID
;

SELECT E.FIRST_NAME, E2.MANAGER_ID,E2.RNK,J.JOB_TITLE
FROM 
        (SELECT MANAGER_ID,JOB_ID,COUNT(*),
              RANK() OVER (PARTITION BY MANAGER_ID ORDER BY COUNT(*) DESC) AS RNK
         FROM EMPLOYEES 
         GROUP BY MANAGER_ID, JOB_ID) E2 INNER JOIN EMPLOYEES E
                                                ON E2.MANAGER_ID = E.EMPLOYEE_ID
                                         INNER JOIN JOBS J 
                                                ON E2.JOB_ID = J.JOB_ID
                                                
WHERE E2.RNK =1
;