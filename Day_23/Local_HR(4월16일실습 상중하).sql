--4월 16일 실습문제 선생님 답

--난이도 하
--부하직원이 가장 많은 상급자를 구하시오

SELECT MANAGER_ID,
        RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
FROM EMPLOYEES 
GROUP BY MANAGER_ID
;

SELECT E.FIRST_NAME
FROM EMPLOYEES E INNER JOIN (SELECT MANAGER_ID,
                                        RANK()OVER(ORDER BY COUNT(*) DESC) AS RNK
                              FROM EMPLOYEES 
                              GROUP BY MANAGER_ID ) M
                        ON E.EMPLOYEE_ID = M.MANAGER_ID
                    AND M.RNK = 1
;


--난이도 중
--업무나 부서 변동이 있었던 사원들의 급여평균을 구하시오.

SELECT AVG(E.SALARY) AS AVG_SAL
FROM EMPLOYEES E INNER JOIN ( SELECT DISTINCT EMPLOYEE_ID   
                                FROM JOB_HISTORY ) J
                            ON E.EMPLOYEE_ID = J.EMPLOYEE_ID
;
--난이도 상 
--사원수 1,2등인 부서들의 급여 평균을 구하고, 그 평균의 차이를 구하시오.

SELECT MAX(AVG_SAL) - MIN(AVG_SAL) AS CHA  

FROM
        (SELECT DEPARTMENT_ID, AVG(SALARY) AS AVG_SAL,
                RANK() OVER(ORDER BY COUNT(*) DESC ) AS RNK
        FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID ) E
WHERE E.RNK IN (1,2)
;