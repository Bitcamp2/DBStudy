-- 3. WITH
-- SELECT 구문이 시작되기 전에 가상테이블을 먼저 구성하는 방식
-- SELECT문이 시작되고 가상테이블을 생성하는 서브쿼리보다 속도가 빠르기 때문에 많이 사용된다.
-- 서브쿼리를 너무 만히 사용하면 쿼리의 속도가 현저하게 느려지기 때문에 WITH 절을 적절히 잘 사용해야 한다.
-- SELECT 구문 위에 WITH절로 가상테이블을 구성한다.
WITH DNO10 AS (
	SELECT ENO
		 , ENAME
		 , DNO
		FROM EMP
		WHERE DNO = '10'
)
SELECT DNO10.*
	 , D.DNAME
	FROM DNO10
	JOIN DEPT D
	  ON DNO10.DNO = D.DNO;
	  
-- 기말고사 성적의 평균이 50점 이상인 과목번호, 과목이름, 기말고사 성적의 평균점수를 가지는
-- 가상테이블 OVER50를 WITH절로 구현하고 해당 과목을 수강하는 학생들의 학생 정보조회
-- 과목번호, 과목이름, 과목별 기말고사 성적의 평균점수, 학생번호, 학생이름 조회
WITH OVER50 AS (
	SELECT SC.CNO
		 , C.CNAME
		 , AVG(SC.RESULT) AS AVG_RESULT
		FROM SCORE SC
		JOIN COURSE C
		  ON SC.CNO = C.CNO
		GROUP BY SC.CNO, C.CNAME
		HAVING AVG(SC.RESULT) >= 50
)
SELECT OVER50.CNO
	 , OVER50.CNAME
	 , OVER50.AVG_RESULT
	 , ST.SNO
	 , ST.SNAME
	FROM OVER50
	JOIN SCORE SSC
	  ON OVER50.CNO = SSC.CNO
	JOIN STUDENT ST
	  ON ST.SNO = SSC.SNO;

-- WITH 절로 두 개이상의 가상테이블을 만들 때는 ,로 연결해서 만든다.
WITH
	DNO10 AS (
		SELECT ENO
			 , ENAME
			 , DNO
			FROM EMP
			WHERE DNO = '10'
	),
	JOBDEV AS (
		SELECT ENO
			 , ENAME
			 , JOB
			FROM EMP
			WHERE JOB = '개발'
	),
	OVER3000 AS (
		SELECT ENO
			 , ENAME
			 , SAL
			FROM EMP
			WHERE SAL >= 3000
	)
SELECT DNO10.ENO
	 , DNO10.ENAME
	 , DNO10.DNO
	 , JOBDEV.JOB
	 , OVER3000.SAL
	FROM DNO10
	JOIN JOBDEV
	  ON DNO10.ENO = JOBDEV.ENO
	JOIN OVER3000
	  ON DNO10.ENO = OVER3000.ENO;
	  
-- 화학과 1학년 학생의 학생번호, 학생이름, 학년을 가지고 있는 가상테이블 CHMSTU와
-- 과목명에 화학이 포함된 과목의 과목번호, 과목이름, 기말고사 성적, 학생번호를 가지는 가상테이블 CHMRES를 WITH 절로 구현하고
-- 화학과 1학년 학생의 학생번호, 학생이름, 학생의 기말고사 성적의 평균점수(소수점 둘재 자리까지 표시)를 조회
WITH
	CHMSTU AS (
		SELECT SNO
			 , SNAME
			 , SYEAR
			FROM STUDENT
			WHERE MAJOR = '화학'
			  AND SYEAR = 1
	),
	CHMRES AS (
		SELECT SC.CNO
			 , C.CNAME
			 , SC.RESULT
			 , SC.SNO
			FROM COURSE C
			JOIN SCORE SC
			  ON C.CNO = SC.CNO
			WHERE C.CNAME LIKE '%화학%'
	)
SELECT CHMSTU.SNO
	 , CHMSTU.SNAME
	 , ROUND(AVG(CHMRES.RESULT), 2) AS AVG_RESULT 
	FROM CHMSTU
	JOIN CHMRES
	  ON CHMSTU.SNO = CHMRES.SNO
	GROUP BY CHMSTU.SNO, CHMSTU.SNAME
	ORDER BY CHMSTU.SNO;