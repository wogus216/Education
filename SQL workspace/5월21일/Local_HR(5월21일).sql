--���빰��
--1. seattle�� �ٹ��ϴ� ����� �̸�, �ش� ����� �Ŵ����̸�, ����� �μ����� ���ϰ� �������� ������ �ű�ÿ�. 
--����̸� ������������ ����Ͻÿ�. 
--����ʵ� : �����(last_name), �Ŵ����̸�(last_name), �μ���, ����, ��������

SELECT E.*,L.CITY,D.DEPARTMENT_NAME,E2.LAST_NAME
FROM LOCATIONS L INNER JOIN DEPARTMENTS D
                        ON L.LOCATION_ID = D.LOCATION_ID
                 INNER JOIN EMPLOYEES E
                        ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
                 INNER JOIN EMPLOYEES E2
                        ON E.MANAGER_ID = E2.EMPLOYEE_ID
;
--1������
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
--2. �� �μ��� �ִ� �޿��� �� �μ��̵��� ������ ����� LAST_NAME, �޿�, �μ���, ���� �μ��� ��� �޿��� ���ϰ�, 
--�� LAST_NAME�� 5���� �̻��� ����� ����ϰ� LAST_NAME ������������ �����Ͻÿ�
--����ʵ� : last_name, �޿�, �޿����

SELECT   E.*
FROM  ( SELECT LAST_NAME ,DEPARTMENT_ID, SALARY,EMPLOYEE_ID,
            RANK() OVER (PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS RNK
        FROM EMPLOYEES  ) E 
WHERE E.RNK =1 
;
--2������
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
--�μ���ձ��ϱ�
SELECT DEPARTMENT_ID, AVG(SALARY) AS DE_AVG
FROM  EMPLOYEES 
GROUP BY DEPARTMENT_ID
;
--������ ����
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
--3. �Ƹ޸�ī ������� �ٹ��ϴ� ��� �� emp id�� 180�����̸鼭 ��ü ����� �޿� ��� �̻��� ����� ���Ͻÿ�. ��, �Ի����� ���� 3���� �̸�(last_name)������� �����Ͻÿ� 
--����ʵ� : �Ի���, �̸�(last_name), ������, �Ի��� ����

--�Ƹ޸�ī ������� �ٹ��ϴ� ��� �� emp id�� 180����
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

--��ü �޿� ���
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
--3������
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


--<HR 1��>

--�������� �ٹ��ϰ� �ִ� ��� �� FIRST_NAME �� 5���� �̻��� ����� ���ϰ�, 
--�ٹ����ÿ� �μ���, �޿����� 5������(�ߺ����) ���Ͻÿ�.
--��� : �����(FIRST_NAME) , �ٹ����� , �޿�, �μ����� ������� �����Ͽ� ����Ͻÿ�.

SELECT *
FROM LOCATIONS L RIGHT OUTER JOIN DEPARTMENTS D
                        ON L.LOCATION_ID = D.LOCATION_ID
WHERE COUNTRY_ID = 'UK'                        
;
--����
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

--<HR 2��>
--������� FIRST_NAME�� J�� �����ϸ鼭 SALARY�� 8000�̻��� ����� ���� ���ÿ� ��� 
--������� �ִ� �޿��� �ּұ޿��� ���̸� ���Ͻÿ�.
--��� : ����

SELECT COUNT(*),D.LOCATION_ID,MAX(E.SALARY)-MIN(E.SALARY)
FROM EMPLOYEES E  LEFT OUTER JOIN DEPARTMENTS D 
                        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.FIRST_NAME LIKE 'J%' AND E.SALARY >= 8000 
GROUP BY D.LOCATION_ID
;
--<HR 3��>
--�ּҰ� 10���� �̻��� ���� �� �����̸��� 10���� ������ �����̸��� �ּұ��� ������������ ����Ͻÿ�.
-- ��� : �ּ� , �����̸� , �ּұ���
--����
SELECT L.STREET_ADDRESS,C.COUNTRY_NAME,LENGTH(L.STREET_ADDRESS) AS LENGTH, L.CITY
FROM LOCATIONS L INNER JOIN COUNTRIES C 
                        ON L.COUNTRY_ID = C.COUNTRY_ID
WHERE LENGTH(L.STREET_ADDRESS) >= 10 AND LENGTH(L.CITY) <= 10
ORDER BY LENGTH(L.STREET_ADDRESS) ASC
;

--����1)

-- ���������� �־��� ����� �޿��� 60%�λ��Ͽ� ��ü����� �޿������� ���ϰ� 1��~5�������� ����� �޿� ���� ���Ͻÿ�. 

-- ��³��� : RSAL(����� �޿� ��)

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
--����2)

-- CITY:'Southlake'���� �ٹ��ϴ� David�� �޿� �̻��� �޴� David���� ������ �Ű� 1�� �̿ܿ� David���� �޿��� 50% �λ��ϰ� ����� ���Ͻÿ�.
 -- ���: ��� (�Ҽ� ��°�ڸ� �ݿø�)
 
 SELECT
 FROM LOCATION L INNER JOIN DEPART
 ;
 