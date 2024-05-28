--1) WITH 절을 이용하여 정교수만 모여있는 가상테이블 하나와 일반과목(과목명에 일반이 포함되는)들이 모여있는 가상테이블 하나를 생성하여 
--   일반과목들을 강의하는 교수의 정보 조회하세요.(과목번호, 과목명, 교수번호, 교수이름)

WITH PRO_ORDER AS(
					SELECT *
						FROM PROFESSOR
						WHERE ORDERS LIKE '정교수'
	 ),
	 COU_NAME AS(
	 				SELECT *
	 					FROM COURSE
	 					WHERE CNAME LIKE '%일반%'
	 )
	 SELECT COU_NAME.CNO,
	 		COU_NAME.CNAME,
	 		PRO_ORDER.PNO,
	 	 	PRO_ORDER.PNAME
	 	 FROM COU_NAME
	 	 JOIN PRO_ORDER
	 	   ON COU_NAME.PNO = PRO_ORDER.PNO;
	 	 	
	 		

--2) WITH 절을 이용하여 급여가 3000이상인 사원정보를 갖는 가상테이블 하나와 보너스가 500이상인 사원정보를 갖는 가상테이블 하나를 생성하여
--   두 테이블에 모두 속해있는 사원의 정보를 모두 조회하세요.
	 	  
WITH EINFO_01 AS (
					SELECT *
						FROM EMP
						WHERE SAL >= 3000
	),
	 EINFO_02 AS (
	 				SELECT *
	 					FROM EMP
	 					WHERE COMM >= 500
	)
SELECT *
	FROM EINFO_01
	INNER JOIN EINFO_02
	  ON EINFO_01.ENAME = EINFO_02.ENAME;
						


--3) WITH 절을 이용하여 평점이 3.3이상인 학생의 목록을 갖는 가상테이블 하나와 학생별 기말고사 평균점수를 갖는 가상테이블 하나를 생성하여
--   평점이 3.3이상인 학생의 기말고사 평균 점수를 조회하세요.
	 
WITH ST_AVR AS (
					SELECT *
						FROM STUDENT
						WHERE AVR >= 3.3
	),
	 ST_RES AS (
	 				SELECT ST.SNO
	 					 , AVG(RESULT) AS AVG_RESULT
	 					FROM SCORE S
	 					JOIN STUDENT ST
	 					  ON S.SNO = ST.SNO
	 					GROUP BY ST.SNO
	 )
SELECT AVG_RESULT
	 , AVR
	 FROM ST_AVR
	 JOIN ST_RES
	   ON ST_AVR.SNO = ST_RES.SNO;


--4) WITH 절을 이용하여 부임일자가 25년이상된 교수정보를 갖는 가상테이블 하나와 과목번호, 과목명, 학생번호, 학생이름, 교수번호, 기말고사성적을
--   갖는 가상테이블 하나를 생성하여 기말고사 성적이 90이상인 과목번호, 과목명, 학생번호, 학생이름, 교수번호, 교수이름, 기말고사성적을 조회하세요.
WITH PRO_HIRE AS (
					SELECT *
						FROM PROFESSOR
						WHERE TRUNC((SYSDATE - HIREDATE)/365) >= 25
	),
	 TOTAL_RES AS (
	 				SELECT C.CNO
	 					 , C.CNAME
	 					 , S.SNO
	 					 , S.SNAME
	 					 , P.PNO
	 					 , SC.RESULT
	 					FROM COURSE C
	 					JOIN SCORE SC
	 					  ON C.CNO = SC.CNO
	 					JOIN STUDENT S
	 					  ON SC.SNO = S.SNO
	 					JOIN PROFESSOR P
	 					  ON C.PNO = P.PNO
	 )
SELECT TOTAL_RES.CNO
	 , TOTAL_RES.CNAME
	 , TOTAL_RES.SNO
	 , TOTAL_RES.SNAME
	 , TOTAL_RES.PNO
	 , PRO_HIRE.PNAME
	 , TOTAL_RES.RESULT
	FROM PRO_HIRE
	JOIN TOTAL_RES
	  ON PRO_HIRE.PNO = TOTAL_RES.PNO
	WHERE TOTAL_RES.RESULT >= 90;