--선생님 답 버전 4월19일 HR문제

-서비스 1,공부필요
-- 부서 이동한 사람 중에서 급여가 10000미만인 경우 급여의 50퍼센트 커미션을 주어서
--전체급여(커미션 포함) 순위중 1등부터 5등까지 직원의 정보를 출력하시오.

SELECT E.EMPLOYEE_ID,E.FIRST_NAME,E.SALARY,E.COMMISSION_PCT, E.RSAL,E.RNK
FROM (SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.COMMISSION_PCT,
             CASE WHEN J.EMPLOYEE_ID IS NOT NULL AND E.SALARY < 10000
                  THEN E.SALARY + (E.SALARY * NVL(E.COMMISSION_PCT,0) + (E.SALARY * 0.5))
                  ELSE E.SALARY + (E.SALARY * NVL(E.COMMISSION_PCT,0))
            END AS RSAL,
            RANK() OVER(ORDER BY CASE WHEN J.EMPLOYEE_ID IS NOT NULL AND E.SALARY < 10000
                                      THEN E.SALARY + (E.SALARY * NVL(COMMISSION_PCT, 0) + (E.SALARY * 0.5))
                                      ELSE E.SALARY + (E.SALARY * NVL(COMMISSION_PCT, 0)) 
                                END DESC) AS RNK
                    FROM EMPLOYEES E LEFT OUTER JOIN (SELECT DISTINCT J.EMPLOYEE_ID
                                                      FROM JOB_HISTORY J INNER JOIN EMPLOYEES E 
                                                                                ON J.EMPLOYEE_ID = E.EMPLOYEE_ID
                                                                               AND J.DEPARTMENT_ID != E.DEPARTMENT_ID) J
                                                            ON E.EMPLOYEE_ID = J.EMPLOYEE_ID) E
 WHERE E.RNK BETWEEN 1 AND 5
;
                
                
  SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.COMMISSION_PCT
                    FROM EMPLOYEES E  LEFT OUTER JOIN (SELECT DISTINCT J.EMPLOYEE_ID
                                                      FROM JOB_HISTORY J INNER JOIN EMPLOYEES E 
                                                                                ON J.EMPLOYEE_ID = E.EMPLOYEE_ID
                                                                               AND J.DEPARTMENT_ID != E.DEPARTMENT_ID) J
                                                            ON E.EMPLOYEE_ID = J.EMPLOYEE_ID              
;
  
--서비스2 답확인
-- 이름이 J로 시작하는 직원중에서 가장 많이 속해있는 부서의 상급자를 구하고, 전체 직원에서 그 상급자보다 적은 급여를 받는 직원들의 평균급여를 구하시오.
-- 출력은 소수점 2째자리까지..

SELECT ROUND(AVG(E.SALARY), 2) AS AVG_SAL
FROM EMPLOYEES E INNER JOIN (SELECT E.DEPARTMENT_ID, D.MANAGER_ID, M.SALARY,
                                    RANK() OVER(ORDER BY COUNT(*) DESC ) AS RNK
                             FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
                                                    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                                              INNER JOIN EMPLOYEES M 
                                                    ON D.MANAGER_ID = M.EMPLOYEE_ID
                            WHERE E.FIRST_NAME LIKE 'J%'
                            GROUP BY E.DEPARTMENT_ID, D.MANAGER_ID, M.SALARY)  M
                        ON E.SALARY < M.SALARY
                        AND M.RNK = 1
;
--내버전
SELECT E.DEPARTMENT_ID,COUNT(*),D.MANAGER_ID,M.SALARY,
        RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D 
                        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                INNER JOIN EMPLOYEES M
                        ON D.MANAGER_ID = M.EMPLOYEE_ID
WHERE E.FIRST_NAME LIKE  'J%'
GROUP BY E.DEPARTMENT_ID,D.MANAGER_ID,M.SALARY
;

SELECT  ROUND(AVG(E.SALARY),2)
FROM EMPLOYEES E INNER JOIN(SELECT E.DEPARTMENT_ID,COUNT(*),D.MANAGER_ID,M.SALARY,
                            RANK() OVER (ORDER BY COUNT(*) DESC) AS RNK
                            FROM EMPLOYEES E INNER JOIN DEPARTMENTS D 
                                                 ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                                            INNER JOIN EMPLOYEES M
                                                 ON D.MANAGER_ID = M.EMPLOYEE_ID
                          WHERE E.FIRST_NAME LIKE  'J%'
                      GROUP BY E.DEPARTMENT_ID,D.MANAGER_ID,M.SALARY) J
                      ON E.SALARY < J.SALARY
                      AND J.RNK  =1
;


                
                