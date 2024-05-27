--<단일 행 함수를 이용하세요>
--1) 교수들이 부임한 달에 근무한 일수는 몇 일인지 검색하세요
SELECT PNO
	 , PNAME
	 , HIREDATE 
	 , ROUND(HIREDATE, 'MM') - ROUND(HIREDATE, 'DD') || '일' "부임한 달에 근무한 일수"
	FROM PROFESSOR;

--2) 교수들의 오늘까지 근무한 주가 몇 주인지 검색하세요
SELECT PNO
	 , PNAME
	 , HIREDATE
	 , TRUNC((SYSDATE- HIREDATE)/7) || '주' "오늘까지 근무한 주"
	FROM PROFESSOR;

--3) 1991년에서 1995년 사이에 부임한 교수를 검색하세요
SELECT PNO
	 , PNAME
	 , HIREDATE
	FROM PROFESSOR
	WHERE HIREDATE BETWEEN TO_DATE('19910101', 'YYYYMMDD') AND TO_DATE('19941231', 'YYYYMMDD');

--4) 학생들의 4.5 환산 평점을 검색하세요(단 소수 이하 둘째자리까지)
SELECT SNO
	 , SNAME
	 , TRUNC(AVR * 1.125, 2) 평점
	FROM STUDENT;

--5) 사원들의 오늘까지 근무 기간이 몇 년 몇 개월 며칠인지 검색하세요
SELECT ENO
	 , ENAME
	 , HDATE
	 , TRUNC(SYSDATE - HDATE)
	 , TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), TRUNC(HDATE)) / 12) || '년' 
   ||  TRUNC(MOD(MONTHS_BETWEEN(TRUNC(SYSDATE), TRUNC(HDATE)), 12)) || '개월' 
   ||  TRUNC(SYSDATE - ADD_MONTHS(HDATE, MONTHS_BETWEEN(SYSDATE, HDATE))) || '일' "근무 기간"
	FROM EMP;


