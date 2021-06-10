INSERT INTO OB(OB_NO,M_NO,OB_CON)
VALUES(OB_SEQ.NEXTVAL, OB_SEQ.CURRVAL, '��ȣ')
;
SELECT *
FROM OB 
;
SELECT COUNT(*) AS CNT
FROM OB O INNER JOIN M M
                  ON O.M_NO = M.M_NO
--1�� ���� ó�� �ȵ� ��
WHERE O.OB_DEL = 1
AND M.M_NM LIKE '%' || '���¸�' || '%'
AND O.OB_CON LIKE '%' || '��' || '%'
;
COMMIT;

SELECT O.OB_NO, O.OB_CON, O.M_NO,O.M_NM
FROM (SELECT O.OB_NO,O.OB_CON,M.M_NO,M.M_NM,
                ROW_NUMBER() OVER(ORDER BY O.OB_NO DESC) AS RNUM
      FROM OB O INNER JOIN M M
                          ON O.M_NO = M.M_NO
      WHERE O.OB_DEL = 1 
      ) O
WHERE O.RNUM BETWEEN 1 AND 10
;

UPDATE OB SET OB_DEL = 0
WHERE OB_NO = '3'
AND M_NO ='1'
;

COMMIT;