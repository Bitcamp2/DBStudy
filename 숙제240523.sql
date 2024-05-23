--13_FUNCTION_Question

--<단일 행 함수를 사용하세요>
--1) 이름이 두 글자(공백포함 3)인 학생의 이름을 검색하세요
SELECT RPAD(SNAME, 4, '   ')
	FROM STUDENT;

--2) '공'씨 성을 가진 학생의 이름을 검색하세요
SELECT SNAME
	FROM STUDENT
	 WHERE SUBSTR(SNAME, 1, 1) = '공';

--3) 교수의 지위를 한글자로 검색하세요(ex. 조교수 -> 조)
SELECT PNAME
	 , ORDERS
	 FROM PROFESSOR
	 WHERE SUBSTR(ORDERS, 1, 1) = '조';

--4) 일반 과목을 기초 과목으로 변경해서 모든 과목을 검색하세요
--  (ex. 일반화학 -> 기초화학)
SELECT TRANSLATE('일반화학', '일반', '기초') -- 결과값 : --rld -f -ar 
	FROM COURSE;
   
--5) 만일 입력 실수로 student테이블의 sname컬럼에 데이터가 입력될 때
--   문자열 마지막에 공백이 추가되었다면 검색할 때 이를 제외하고
--   검색하는 SELECT 문을 작성하세요
SELECT TRIM(SNAME) 
	FROM STUDENT;
   
--14_FUNCTION_Question


--<단일 행 함수를 이용하세요>
--1) 교수들이 부임한 달에 근무한 일수는 몇 일인지 검색하세요
SELECT PNAME
	 , TRUNC(HIREDATE, 'DD')
	 , LAST_DAY(HIREDATE) - HIREDATE
	FROM PROFESSOR;

--2) 교수들의 오늘까지 근무한 주가 몇 주인지 검색하세요
SELECT PNAME
	 , TRUNC(HIREDATE, 'DD')
	 , TRUNC(SYSDATE, 'DD')
	 , MONTHS_BETWEEN(SYSDATE, HIREDATE) * 4 AS 주_단위
	 FROM PROFESSOR;

--3) 1991년에서 1995년 사이에 부임한 교수를 검색하세요
SELECT PNAME
	 , HIREDATE
	 FROM PROFESSOR
	WHERE HIREDATE BETWEEN TO_DATE('1991', 'YYYY') AND TO_DATE('1995', 'YYYY');

--4) 학생들의 4.5 환산 평점을 검색하세요(단 소수 이하 둘째자리까지)
SELECT SNAME
	 , AVR AS 기본평점
	 , ROUND(AVR * 1.125, 2) AS 환산
	 FROM STUDENT
	 ORDER BY AVR DESC;

--5) 사원들의 오늘까지 근무 기간이 몇 년 몇 개월 며칠인지 검색하세요
SELECT ENAME
	 , HDATE
--	 SELECT MONTHS_BETWEEN(TRUNC(SYSDATE, 'DD'), TO_DATE('20230523', 'YYYYMMDD'))
	 , TRUNC(MONTHS_BETWEEN(SYSDATE, HDATE) / 12) || '년' 
	 || TRUNC(MONTHS_BETWEEN(SYSDATE, HDATE) - TRUNC(MONTHS_BETWEEN(SYSDATE, HDATE) / 12) * 12) || '개월' 
--	 || TRUNC((MONTHS_BETWEEN(SYSDATE, HDATE) - TRUNC(MONTHS_BETWEEN(SYSDATE, HDATE) - TRUNC(MONTHS_BETWEEN(SYSDATE, HDATE) / 12) * 12)) / 24) -- 틀린 일수
	 || TRUNC(SYSDATE - ADD_MONTHS(HDATE, MONTHS_BETWEEN(SYSDATE, HDATE))) -- 망할 근무한 일수
	 || '일' AS 오늘까지근무기간
	 FROM EMP;

--15_FUNCTION_Question

--1) 학생의 평균 평점을 다음 형식에 따라 소수점 이하 2자리까지 검색하세요
--'OOO 학생의 평균 평점은 O.OO입니다.'
SELECT SNAME || '학생의 평균 평점은 ' || ROUND(AVR, 2) || '입니다.' 
	FROM STUDENT;

--2) 교수의 부임일을 다음 형식으로 표현하세요
--'OOO 교수의 부임일은 YYYY년 MM월 DD일입니다.'
--SELECT PNAME || '교수의 부임일은 ' || TRUNC(HIREDATE, 'YYYY') || '년' || TRUNC(HIREDATE, 'MM') || '월'
SELECT PNAME || '교수의 부임일은' || TO_DATE(HIREDATE, 'YYYYMMDD')
	FROM PROFESSOR;


--3) 교수중에 3월에 부임한 교수의 명단을 검색하세요
SELECT PNAME
	 , HIREDATE
	 FROM PROFESSOR;
	 WHERE HIREDATE = TO_DATE('YYYYMMDD'); 
	
	
