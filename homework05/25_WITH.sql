--1) WITH 절을 이용하여 정교수만 모여있는 가상테이블 하나와 일반과목(과목명에 일반이 포함되는)들이 모여있는 가상테이블 하나를 생성하여 
--   일반과목들을 강의하는 교수의 정보 조회하세요.(과목번호, 과목명, 교수번호, 교수이름)
WITH CHUNG AS (
	SELECT PNO
		 , PNAME
		FROM PROFESSOR
		WHERE ORDERS = '정교수'
)
SELECT CHUNG.*
	 , C.CNO
	 , C.CNAME
	 FROM CHUNG
	 JOIN COURSE C
	   ON CHUNG.PNO = C.PNO;

--2) WITH 절을 이용하여 급여가 3000이상인 사원정보를 갖는 가상테이블 하나와 보너스가 500이상인 사원정보를 갖는 가상테이블 하나를 생성하여
--   두 테이블에 모두 속해있는 사원의 정보를 모두 조회하세요.
WITH SAL3000 AS (
		SELECT ENO
			 , ENAME
			 , SAL
			FROM EMP
			WHERE SAL >= 3000
	 ),
	 COMM500 AS (
	 	SELECT ENO
	 		 , COMM 
	 		FROM EMP
	 		WHERE COMM >= 500
	 )
SELECT SAL3000.*
	 , C.COMM
	FROM SAL3000
	JOIN COMM500 C
	  ON SAL3000.ENO = C.ENO;

--3) WITH 절을 이용하여 평점이 3.3이상인 학생의 목록을 갖는 가상테이블 하나와 학생별 기말고사 평균점수를 갖는 가상테이블 하나를 생성하여
--   평점이 3.3이상인 학생의 기말고사 평균 점수를 조회하세요.
WITH AVR33 AS (
		SELECT SNO
			 , SNAME
			 , AVR
			FROM STUDENT
			WHERE AVR >= 3.3
	),
	AVGRES AS (
		SELECT ST.SNO
			 , ST.SNAME
			 , AVG(SC."RESULT") AS AR
			FROM STUDENT ST
			JOIN SCORE SC
			  ON ST.SNO = SC.SNO
			GROUP BY ST.SNO, ST.SNAME
	)
SELECT AVR33.*
	 , AVGRES.AR
	 FROM AVR33
	 JOIN AVGRES
	   ON AVR33.SNO = AVGRES.SNO;

--4) WITH 절을 이용하여 부임일자가 25년이상된 교수정보를 갖는 가상테이블 하나와 과목번호, 과목명, 학생번호, 학생이름, 교수번호, 기말고사성적을
--   갖는 가상테이블 하나를 생성하여 기말고사 성적이 90이상인 과목번호, 과목명, 학생번호, 학생이름, 교수번호, 교수이름, 기말고사성적을 조회하세요.
WITH HD25 AS (
		SELECT PNO
			 , PNAME
			FROM PROFESSOR 
			WHERE ADD_MONTHS(HIREDATE, 25*12) >= SYSDATE
	),
	CSP AS (
		SELECT C.CNO
			 , C.CNAME
			 , ST.SNO
			 , ST.SNAME
			 , P.PNO
			 , SC."RESULT"
			FROM COURSE C
			JOIN PROFESSOR P
			  ON C.PNO = P.PNO
			JOIN SCORE SC
			  ON SC.CNO = C.CNO
			JOIN STUDENT ST
			  ON SC.SNO = ST.SNO
	)
SELECT CSP.CNO
	 , CSP.CNAME
	 , CSP.SNO
	 , CSP.SNAME
	 , HD25.PNO
	 , HD25.PNAME
	 , CSP."RESULT"
	FROM HD25
	JOIN CSP
	  ON HD25.PNO = CSP.PNO
	WHERE CSP."RESULT" >= 90;


