-- ���� STATUS�� 'Canceled' ������  ������� ���� ���� ��ð� �ִ� �Ŵ����� ����Ͻÿ�
--���: �����ȣ,�̸�(�۽�Ʈ+��Ʈ),�̸���,JOB_TITLE
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

---- ����2)
-- �ֹ��� ��ҵ� ������ ���� ���̳��� ������Ʈ ���� Ǯ���Ӱ� ���ڼ���
-- ���ڼ��� ���� ������� �������߿��� ����Ͻÿ�
-- ����ʵ�: �����ȣ, ���Ǯ����, ����

SELECT 
FROM CUSTOMERS C INNER JOIN ORDERS O
                         ON C.CUSTOMER_ID = O.CUSTOMER_ID
;

--����3.
-- ��ǰID�� 200�����̸鼭 ������ 200���̻��� ��ǰ�� ����(�ǸŰ���-ǥ�ؿ���)�� ���� ū ��ǰ�� ���� ���� ��ǰ�� ���̸� ���ϰ�
--�� ���̺��� ū �ǸŰ����� ���� ��ǰ���� ���� ���� ī�װ��� ī�װ� �̸��� ���Ͻÿ�.