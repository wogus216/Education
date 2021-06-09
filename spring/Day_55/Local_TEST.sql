INSERT INTO M(M_NO,M_ID,M_PW,M_NM,M_BIRTH,M_JOINDT)
VALUES (2,'SPRING','1234','���¸�',SYSDATE,SYSDATE)
;
SELECT  M.M_NO,M.M_ID,M.M_NM,M.BIRTH,M.DT
FROM (SELECT M_NO,M_ID,M_NM,TO_CHAR(M_BIRTH,'YY-MM-DD') AS BIRTH, TO_CHAR(M_JOINDT, 'YY-MM-DD') AS DT,
                ROW_NUMBER() OVER(ORDER BY M_NO DESC) AS RNUM
      FROM M
      WHERE 1=1
        -- AND M_ID LIKE '%' || 'P' ||'%'
        -- AND M_ID LIKE '%' || 'P' ||'%'
        -- AND M_NM LIKE '%' || 'P' ||'%' 
        ) M
WHERE M.RNUM BETWEEN 1 AND 20
;

SELECT COUNT(*)
FROM M
;

COMMIT;