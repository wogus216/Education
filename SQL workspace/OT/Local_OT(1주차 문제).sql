-- 오더 STATUS가 'Canceled' 상태인  사원들이 가장 많이 모시고 있는 매니저를 출력하시오
--출력: 사원번호,이름(퍼스트+라스트),이메일,JOB_TITLE
SELECT E.EMPLOYEE_ID,E.FIRST_NAME || E.LAST_NAME AS FULL_NAME,E.EMAiL,E.job_title
FROM (SELECT E.MANAGER_ID,COUNT(*),
               RANK() OVER(ORDER BY COUNT(*) DESC) AS RNK
        FROM EMPLOYEES E INNER JOIN ORDERS O
                               ON EMPLOYEE_ID = SALESMAN_ID
                               AND O.STATUS IN 'Canceled'
        GROUP BY E.MANAGER_ID ) M RIGHT OUTER JOIN EMPLOYEES E
                                                ON M.MANAGER_ID = E.EMPLOYEE_ID
WHERE M.RNK = 1    
;

---- 문제2)
-- 주문이 취소된 물건이 가장 많이나온 웹사이트 고객의 풀네임과 글자수와
-- 글자수가 같은 사람들을 직원들중에서 출력하시오
-- 출력필드: 사원번호, 사원풀네임, 직업

SELECT 
FROM CUSTOMERS C INNER JOIN ORDERS O
                         ON C.CUSTOMER_ID = O.CUSTOMER_ID
;

--문제3.
-- 제품ID가 200번대이면서 수량이 200개이상인 제품중 마진(판매가격-표준원가)이 가장 큰 제품과 가장 작은 제품의 차이를 구하고
--그 차이보다 큰 판매가격을 가진 제품들중 가장 많은 카테고리의 카테고리 이름을 구하시오.