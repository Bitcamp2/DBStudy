--1) 각 학과별 학생 수를 검색하세요
SELECT MAJOR
	 , COUNT(SNO)
	FROM STUDENT
	GROUP BY MAJOR;

--2) 화학과와 생물학과 학생 4.5 환산 평점의 평균을 각각 검색하세요
SELECT *
	FROM (
		SELECT MAJOR
		     , AVR
		  FROM STUDENT
		 )
		 PIVOT (
		 		AVG(AVR * 1.125) 
		 		FOR MAJOR IN (
		 		  '화학' AS "화학"
		 		, '생물' AS "생물"
		 				   )
		 	   );

--3) 부임일이 10년 이상 된 직급별(정교수, 조교수, 부교수) 교수의 수를 검색하세요
SELECT ORDERS
	 , COUNT(*) 
	FROM PROFESSOR
	WHERE HIREDATE <= ADD_MONTHS(HIREDATE, +120) 
	GROUP BY ORDERS;

--4) 과목명에 화학이 포함된 과목의 학점수 총합을 검색하세요
SELECT SUM(ST_NUM)
	FROM COURSE C
	WHERE C.CNAME LIKE '%화학%';
	  

--5) 학과별 기말고사 평균을 성적순(성적 내림차순)으로 검색하세요
SELECT MAJOR
	 , AVG(RESULT)	
	FROM STUDENT SC
	JOIN SCORE S
	  ON SC.SNO = S.SNO  
	GROUP BY MAJOR
	ORDER BY AVG(RESULT) DESC;

--6) 30번 부서의 업무별 연봉의 평균을 검색하세요(소수점 두자리까지 표시)
SELECT *
	FROM (
		SELECT E.DNO
		     , E.SAL
		  FROM EMP E
		  JOIN DEPT D
		    ON E.DNO = D.DNO
		 )
		 PIVOT (
		 		AVG(SAL) 
		 		FOR DNO IN (
		 		  '30' AS "30"
		 				   )
		 	   );

--7) 물리학과 학생 중에 학년별로 성적이 가장 우수한 학생의 평점을 검색하세요(학과, 학년, 평점)
SELECT *
	FROM(
			SELECT MAJOR
				 , SYEAR
				 , AVR
				 , AVG(RESULT) AS AVG_RESULT
				FROM STUDENT S
				JOIN SCORE SC
				  ON S.SNO = SC.SNO
				GROUP BY MAJOR, SYEAR, AVR
		)
		 PIVOT(
		 	MAX(AVG_RESULT)
		 	 FOR MAJOR IN (
		 	 			'물리' AS "물리"
		 	 			  )
		 	  );
		
	
	
	
	
	
	
	
	
	
	
	
	
	