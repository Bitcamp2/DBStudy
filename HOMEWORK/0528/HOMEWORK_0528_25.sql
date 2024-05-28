--1) WITH 절을 이용하여 정교수만 모여있는 가상테이블 하나와 일반과목(과목명에 일반이 포함되는)들이 모여있는 가상테이블 하나를 생성하여 
--   일반과목들을 강의하는 교수의 정보 조회하세요.(과목번호, 과목명, 교수번호, 교수이름)
WITH FULL_PROFESSOR AS (
						SELECT PRO.PNO
							 , PRO.PNAME
							 , CO.CNAME
							FROM PROFESSOR PRO
							JOIN COURSE CO
							  ON PRO.PNO = CO.PNO
							WHERE ORDERS = '정교수'
						),
NORMAL_COURSE AS (
					  SELECT COR.CNO
					  	   , COR.CNAME
					  	   , PR.PNO
					  	   FROM COURSE COR
					  	   JOIN PROFESSOR PR
					  	     ON COR.PNO = PR.PNO
					  	   WHERE CNAME LIKE '%일반%'
					  )
SELECT C.CNO
	 , C.CNAME
	 , P.PNO
	 , P.PNAME
	FROM NORMAL_COURSE C
	JOIN FULL_PROFESSOR P
	  ON P.PNO = C.PNO;
	
--2) WITH 절을 이용하여 급여가 3000이상인 사원정보를 갖는 가상테이블 하나와 보너스가 500이상인 사원정보를 갖는 가상테이블 하나를 생성하여
--   두 테이블에 모두 속해있는 사원의 정보를 모두 조회하세요.
WITH OVER3000SAL AS (
					SELECT ENO
						 , ENAME
						 , SAL
						FROM EMP
						WHERE SAL >= 3000
					),
OVER500COMM AS (
				SELECT ENO
					 , ENAME
					 , COMM
					FROM EMP
					WHERE COMM >= 500
				)
SELECT S.ENO
	 , C.ENAME
	 , S.SAL
	 , C.COMM
	FROM OVER3000SAL S
	JOIN OVER500COMM C
	  ON C.ENO = S.ENO;

--3) WITH 절을 이용하여 평점이 3.3이상인 학생의 목록을 갖는 가상테이블 하나와 학생별 기말고사 평균점수를 갖는 가상테이블 하나를 생성하여
--   평점이 3.3이상인 학생의 기말고사 평균 점수를 조회하세요.
WITH OVERAVR AS (
				SELECT SNO
					 , SNAME
					 , AVR
					FROM STUDENT
					WHERE AVR >= 3.3
				),
AVGRESULT AS (
			SELECT ST.SNO
				 , ST.SNAME
				 , AVG(SC.RESULT) AS AVG_RESULT
				FROM STUDENT ST
				JOIN SCORE SC
				  ON ST.SNO = SC.SNO
				GROUP BY ST.SNO, ST.SNAME
			)
SELECT AVR.SNO
	 , AVR.SNAME
	 , AVR.AVR
	 , AVGR.AVG_RESULT
	FROM OVERAVR AVR
	JOIN AVGRESULT AVGR
	  ON AVR.SNO = AVGR.SNO

--4) WITH 절을 이용하여 부임일자가 25년이상된 교수정보를 갖는 가상테이블 하나와 과목번호, 과목명, 학생번호, 학생이름, 교수번호, 기말고사성적을
--   갖는 가상테이블 하나를 생성하여 기말고사 성적이 90이상인 과목번호, 과목명, 학생번호, 학생이름, 교수번호, 교수이름, 기말고사성적을 조회하세요.
WITH OVERHIRE AS (
				SELECT PNO
					 , PNAME
					 , HIREDATE
					FROM PROFESSOR
					WHERE MONTHS_BETWEEN(SYSDATE, HIREDATE) >= 300
				),
COSTSCP AS (
			SELECT C.CNO
				 , C.CNAME
				 , ST.SNO
				 , ST.SNAME
				 , P.PNO
				 , SC.RESULT AS COST_RESULT
				FROM COURSE C
				JOIN SCORE SC
				  ON C.CNO = SC.CNO
				JOIN STUDENT ST
				  ON ST.SNO = SC.SNO
				JOIN PROFESSOR P
				  ON C.PNO = P.PNO
			)
SELECT COST.CNO
	 , COST.CNAME
	 , COST.SNO
	 , COST.SNAME
	 , COST.PNO
	 , OV.PNAME
	 , COST.COST_RESULT
	  FROM OVERHIRE OV
	  JOIN COSTSCP COST
	    ON OV.PNO = COST.PNO
	  WHERE COST_RESULT >= 90;
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  