--DUAL : 임시뷰
SELECT 1+2*3
FROM DUAL
;


SELECT *
FROM EMP
WHERE COMM IS  NULL
;



--각 직원들의 실 지급액을 출력하시오.
--실 지급액 : 급여+커미션
--출력 : 이름, 급여, 커미션, 실 지급액
--NULL+A는 NULL
SELECT ENAME, SAL, COMM, SAL+COMM
FROM EMP;

--NVL(값1,값2) : 값1이 NULL이면 값2로 교체 <오라클>
--IFNULL(값1,값2) <MYSQL>
--ISNULL(값1,값2) <MSSQL>
--AS+명칭 : SELECT에서만 사용가능
SELECT ENAME, SAL, COMM, SAL+NVL(COMM, 0) AS REAL
FROM EMP;


--REAL SAL로 작성하면 띄어쓰기 때문에 다른 문법으로 인식 -> " "로 묶는다.
--' '는 문자열 " "는 문법
SELECT ENAME, SAL,COMM,SAL+NVL(COMM,0) AS "REAL SAL"
FROM EMP;

--문자열
SELECT 'HELLO' || 'WORLD' || '!!'
FROM DUAL;

SELECT CONCAT(CONCAT('HELLO', 'WORLD'), '!!')
FROM DUAL;

--자르기
--SUBSTR 몇번째 글자부터
SELECT SUBSTR('HELLO WORLD!!',4)
FROM DUAL;

--몇번째 글자부터 N개까지
SELECT SUBSTR('HELLO WORLD!!',8,5)
FROM DUAL;

--길이
SELECT LENGTH('KAY')
FROM DUAL;

--변경
SELECT REPLACE ('HELLO WORLD!!', 'L', 'K')
FROM DUAL;

SELECT REPLACE('KKKKI', 'K', 'J')
FROM DUAL;

--찾기
SELECT INSTR('HELLO WORLD!!', 'L')
FROM DUAL;

SELECT INSTR('KWON', 'N')
FROM DUAL;

--나올 수 없는 숫자는 0
SELECT INSTR('HELLO WORLD!!', 'K')
FROM DUAL;

--INSTR(값, 값1) : 값에서 값1이 몇번째 글자인지 돌려줌. 없으면 0
SELECT INSTR('HELLO WORLD!!', 'H',1)
FROM DUAL;

--INSTR(값, 값1, 숫자) : 위와 동일 단, 숫자번째 글자부터
SELECT INSTR('HELLO WORLD!!', 'L',  1, 2)
FROM DUAL;
--INSTR(값, 값1, 숫자1, 숫자2) : 위와 동일 단, 숫자1번째 부터 숫자2번째
SELECT INSTR('HELLO WORLD!!', 'D', 4, 2)
FROM DUAL;

--숫자로 변환
SELECT TO_NUMBER('123')+4
FROM DUAL;

SELECT '123'+4
FROM DUAL;

--대소문자
SELECT LOWER('HELLO'), UPPER('WORLD')
FROM DUAL;

--문자열을 날짜로 변환
SELECT TO_DATE('2021-04-09')
FROM DUAL;

--그냥 문자열
SELECT '2021-04-09'
FROM DUAL;

--현재시간
SELECT SYSDATE
FROM DUAL;

--문자열 형태변화 TO_CHAR(값, 형태)
--Y, YY, YYY, YYYY : 연도
--MM : 월
--MON : 월
--DD : 일
--DAY : 요일
--D : 몇번째날

SELECT TO_CHAR (SYSDATE, 'YYYY-MM-DD DAY D')
FROM DUAL;

--AM, PM : 오전 오후
--HH : 시간(12시간 기준)
--HH24 : 시간(24시간 기준)
--MI : 분
--SS : 초
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS')
FROM DUAL;

--TO_CHAR 사용 시 형태에 한글X
-- -(하이픈)
-- :(콜른)
-- .(점)
--,(컴마)    사용가능

--몇주차
-- W : 해당 월의 1일기준 몇주차인지(1일부터 한주)
-- WW : 1월 1일 기준 몇주차인지
-- IW : 첫째 월요일 기준 몇주차인지(월요일부터 한주)
SELECT TO_CHAR(SYSDATE, 'W'), TO_CHAR(SYSDATE, 'WW'), TO_CHAR(SYSDATE, 'IW')
FROM DUAL;
-- Q : 분기
SELECT TO_CHAR(SYSDATE, 'Q')
FROM DUAL;

-- 날짜+-숫자 : 해당 일자만큼 증감
SELECT SYSDATE - 30
FROM DUAL;

--TO_CHAR에서 형태에 9가 오는 경우 해당 위치에 숫자를 넣는다는 의미
--소숫점을 표시할 경우 아래 자리수는 자동 반올림
--L : 해당 오라클 설치 장치의 언어셋팅에 따른 통화기호 제공
SELECT TO_CHAR(123456, '999999')
FROM DUAL;
SELECT TO_CHAR(123456.789, 'L999,999,999.99')
FROM DUAL;
SELECT TO_CHAR(14367, '99999')
FROM DUAL;



SELECT 1+2*3/4
FROM DUAL;
--MOD(값1, 값2) : 값1을 값2로 나눈 나머지
SELECT MOD(3,2)
FROM DUAL;

--CEIL : 올림, ROUND : 반올림, FLOOR : 버림
--반올림의 경우 ROUND(값, 숫자) : 값에서 소숫점 숫자 개수까지 반올림
SELECT CEIL(3.1415), ROUND(3.1455, 2), FLOOR(3.1415)
FROM DUAL;

--절대값
SELECT ABS(-2.7)
FROM DUAL;

--DBMS_RANDOM.VALUE(값1, 값2) : 값1부터 값2까지 사이의 난수를 구한다.
--DBMS_RANDOM.STRING(형태, 개수) : 형태로 지정된 규칙대로 개수만큼 불특정 문자열을 만든다.
--U : 대문자, L : 소문자, A : 대소문자, X : 대문자숫자, P : 출력 가능한 모든 경우의 수
SELECT DBMS_RANDOM.STRING('P',10), DBMS_RANDOM.VALUE(2,3)
FROM DUAL;

--급여가 1500이하인 사원들의 급여를 10% 인상하고, 나머지는 그대로 출력하시오.
--출력 : 이름, 급여, 변경급여
--CASE WHEN 조건1 THEN 값1  ELSE 값N : 조건 1이 TRUE면 값1을 돌려줌. TRUE가 없으면 값N을 돌려줌
--CASE WHEN THEN END  필수, ELSE 선택
SELECT ENAME, SAL,
            CASE WHEN SAL <=1500
                    THEN SAL *1.1
                    ELSE SAL
            END AS RSAL
FROM EMP;

SELECT ENAME, SAL,
    CASE WHEN SAL >= 3000
        THEN SAL * 1.1
        ELSE SAL
        END AS REAL
FROM EMP;
--업무가 점원인 사원들의 급여를 10%인상하고 나머지는 그대로 출력하시오.
SELECT ENAME, SAL, JOB,
            CASE WHEN JOB = 'CLERK'
                    THEN SAL *1.1
                 WHEN JOB = 'SALESMAN'
                THEN SAL * 0.5
                    ELSE SAL
            END AS RSAL
FROM EMP;

--DECODE(값, 값1, 값1-1, ..., 값N)
--값이 값1과 같으면 값1-1을 돌려준다.  값, 값1, 값1-1필수
--같은 것이 없으면 값 N을 돌려준다.
SELECT ENAME, JOB, SAL,
            DECODE(JOB, 'CLERK', SAL * 1.1, SAL) AS RSAL
FROM EMP;
--홀수월에 입사한 사원들의 급여를 50%인상하고, 짝수월에 입사한 사원들의 급여를 50%감봉하여 사원 정보를 출력하시오.
--출력 : 이름, 입사월, 기존급여, 변경급여
SELECT ENAME, TO_CHAR(HIREDATE, 'MM'), SAL,
        CASE WHEN MOD(TO_CHAR(HIREDATE, 'MM'),2)=1
                 THEN SAL*1.5
                 ELSE SAL*0.5
        END AS RSAL
FROM EMP;
--급여 인상 퍼센트 계산법 인상 : (100+인상폭)*10
--급여 인하 퍼센트 : (100-인하폭)*10

SELECT ENAME, TO_CHAR(HIREDATE,'MM')입사월, SAL, 
    DECODE(MOD(TO_CHAR(HIREDATE,'MM'),2),0,SAL*0.5,SAL*1.5) as RESAL
FROM EMP;

--점원들의 급여를 50%인상하고 나머지 급여는 그대로 적용하여 변경급여가 1500이하인 사원들을 구하시오.
--불가능
SELECT ENAME, JOB, SAL,
    DECODE(JOB, 'CLERK', SAL*1.5, SAL) AS REAL
FROM EMP
;
--서브쿼리 사용, 서브쿼리는 효율성을 위해 FROM에서 쓰고 정 안될경우, WHERE에서 IN 사용해주기
SELECT ENAME, JOB, SAL, RSAL
FROM (SELECT ENAME, JOB, SAL, DECODE(JOB, 'CLERK', SAL * 1.5, SAL) AS RSAL
            FROM EMP)
WHERE RSAL<=1500;
--응용
SELECT ENAME, JOB, SAL, RSAL
FROM(SELECT ENAME, JOB, SAL,
    DECODE(JOB, 'CLERK', SAL*1.5, SAL) AS RSAL
FROM EMP)
WHERE RSAL<3000;