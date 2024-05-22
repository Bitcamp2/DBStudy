-- #1

--1) 모든 학생의 정보를 검색해라
SELECT *
	FROM STUDENT s ;


--2) 모든 과목의 정보를 검색해라
SELECT DISTINCT CNAME
	FROM COURSE c  ;


--3) 기말고사 시험점수를 검색해라
SELECT RESULT AS "기말고사점수"
	FROM SCORE s  ;


--4) 학생들의 학과와 학년을 검색해라
SELECT SNAME
	 , MAJOR 
	 , SYEAR
	FROM STUDENT s ;


--5) 각 과목의 이름과 학점을 검색해라
SELECT CNAME
	 , ST_NUM
	FROM COURSE c ;


--6) 모든 교수의 직위를 검색해라
SELECT PNAME
	 , ORDERS
	FROM PROFESSOR p 
	
-- #2
	
--1) 각 학생의 평점을 검색하라(별칭을 사용)
SELECT SNAME AS "이름"
	 , AVR AS "평점"
	FROM STUDENT s ;

--2) 각 과목의 학점를 검색하라(별칭을 사용)
SELECT CNAME AS "과목이름"
	 , ST_NUM AS "학점"
	FROM COURSE c ;


--3) 각 교수의 지위를 검색하라(별칭을 사용)
SELECT PNAME AS "교수이름"
	 , ORDERS AS "직위"
	FROM PROFESSOR p 


--4) 급여를 10%인상했을 때 연간 지급되는 급여를 검색하라(별칭을 사용)
SELECT SAL*1.1 AS "10%인상된 급여"
	FROM EMP e ;


--5) 현재 학생의 평균 평점은 4.0만점이다. 이를 4.5만점으로 환산해서 검색하라(별칭을 사용)
SELECT AVR*1.125 AS "평균 평점"
	FROM STUDENT s ;
	
-- #3

--1) '__학과인 __학생의 현재 평점은 __입니다' 형태로 학생의 정보를 출력하라
SELECT MAJOR || '학과인 ' || SNAME || '학생의 현재 평점은 ' || AVR || '입니다.'
	FROM STUDENT s ;


--2) '__과목은 __학점 과목입니다.' 형태로 과목의 정보를 출력하라
SELECT CNAME || '과목은 ' || ST_NUM || '학점 과목입니다.'
	FROM COURSE c ;

--3) '__교수는 __학과 소속입니다.' 형태로 교수의 정보를 출력하라
SELECT PNAME || '교수는 ' || SECTION || '소속 입니다.'
	FROM PROFESSOR p 

--4) 학교에는 어떤 학과가 있는지 검색한다(학생 테이블 기반으로 검색한다)
SELECT *
	FROM STUDENT s 
	INNER JOIN PROFESSOR p 
	ON S.MAJOR = P."SECTION" ;


--5) 학교에는 어떤 학과가 있는지 검색한다(교수 테이블 기반으로 검색한다)
SELECT *
	FROM PROFESSOR p 
	INNER JOIN STUDENT s 
	ON S.MAJOR = P.SECTION ;

--6) 교수의 지위는 어떤 것들이 있는지 검색한다
SELECT DISTINCT ORDERS AS "교수직위"
	FROM PROFESSOR p ;

-- #4

--1) 성적순으로 학생의 이름을 검색하라
SELECT *
	FROM STUDENT s 
	INNER JOIN SCORE s2 
	ON S.SNO = S2.SNO
	ORDER BY RESULT DESC;


--2) 학과별 성적순으로 학생의 정보를 검색하라
SELECT *
	FROM STUDENT s 
	INNER JOIN SCORE s2 
	ON s.SNO = s2.SNO
	ORDER BY MAJOR, RESULT DESC;


--3) 학년별 성적순으로 학생의 정보를 검색하라
SELECT *
	FROM STUDENT s 
	INNER JOIN SCORE s2 
	ON s.SNO = s2.SNO
	ORDER BY SYEAR DESC, RESULT DESC;


--4) 학과별 학년별로 학생의 정보를 성적순으로 검색하라
SELECT *
	FROM STUDENT s 
	INNER JOIN SCORE s2 
	ON s.SNO = s2.SNO
	ORDER BY MAJOR, SYEAR DESC, RESULT DESC;

--5) 학점순으로 과목 이름을 검색하라
SELECT CNAME AS "과목이름"
	 , ST_NUM  AS "학점"
	FROM COURSE c 
	ORDER BY ST_NUM DESC;


--6) 각 학과별로 교수의 정보를 검색하라
SELECT *
	FROM PROFESSOR p 
	ORDER BY "SECTION";


--7) 지위별로 교수의 정보를 검색하라
SELECT *
	FROM PROFESSOR p 
	ORDER BY ORDERS ;


--8) 각 학과별로 교수의 정보를 부임일자 순으로 검색하라
SELECT *
	FROM PROFESSOR p 
	ORDER BY "SECTION" , HIREDATE ;

-- #5

--1) 화학과 학생을 검색하라
SELECT *
	FROM STUDENT s 
	WHERE MAJOR = '화학';


--2) 평점이 2.0 미만인 학생을 검색하라
SELECT *
	FROM STUDENT s 
	WHERE AVR <=2.0;


--3) 관우 학생의 평점을 검색하라
SELECT *
	FROM STUDENT s 
	WHERE SNAME = '관우';


--4) 정교수 명단을 검색하라
SELECT PNAME AS "교수명단"
	 , ORDERS AS "직위"
	FROM PROFESSOR p 
	WHERE ORDERS = '정교수';


--5) 화학과 소속 교수의 명단을 검색하라
SELECT PNAME AS "교수명단"
	 , SECTION AS "전공"
	FROM PROFESSOR p 
	WHERE "SECTION" = '화학';


--6) 송강 교수의 정보를 검색하라
SELECT *
	FROM PROFESSOR p 
	WHERE PNAME = '송강';


--7) 학년별로 화학과 학생의 성적을 검색하라
SELECT AVR AS "성적"
	 , MAJOR AS "학과"
	FROM STUDENT s 
	WHERE MAJOR = '화학'
	ORDER BY AVR DESC;


--8) 2000년 이전에 부임한 교수의 정보를 부임일순으로 검색하라
SELECT *
	FROM PROFESSOR p 
	WHERE HIREDATE  <= TO_DATE('20000101 00:00:00', 'yyyy-MM-dd:HH24:mi:ss');
	ORDER BY HIREDATE;


--9) 담당 교수가 없는 과목의 정보를 검색하라
SELECT CNAME
	FROM COURSE c 
	WHERE PNO IS NULL;
	
-- #6

--1) 유공과와 생물과, 식영과 학생을 검색하라
SELECT *
	FROM STUDENT s 
	WHERE MAJOR IN ('유공', '생물', '식영');


--2) 화학과가 아닌 학생중에 1학년 학생을 검색하라
SELECT *
	FROM STUDENT s 
	WHERE MAJOR != '화학' AND SYEAR = 1;


--3) 물리학과 3학년 학생을 검색하라
SELECT *
	FROM STUDENT s 
	WHERE MAJOR = '물리' AND SYEAR = 3;


--4) 평점이 2.0에서 3.0사이인 학생을 검색하라
SELECT *
	FROM STUDENT s 
	WHERE AVR >= 2.0 AND AVR <= 3.0;


--5) 교수가 지정되지 않은 과목중에 학점이 3학점인 과목을 검색하라
SELECT *
	FROM COURSE c 
	WHERE PNO IS NULL AND ST_NUM =3;


--6) 화학과 관련된 과목중 학 점이 2학점 이하인 과목을 검색하라
SELECT *
	FROM COURSE c 
	WHERE CNAME LIKE '%화학%' AND ST_NUM <=2;

--7) 화학과 정교수를 검색하라
SELECT *
	FROM PROFESSOR p 
	WHERE p."SECTION" = '화학' AND ORDERS = '정교수';


--8) 물리학과 학생중에 성이 사마씨인 학생을 검색하라
SELECT *
	FROM STUDENT s 
	WHERE MAJOR = '물리' AND SNAME LIKE '사%';


--9) 성과 이름이 각각 1글자인 교수를 검색하라
SELECT *
	FROM PROFESSOR p 
	WHERE PNAME LIKE '__';