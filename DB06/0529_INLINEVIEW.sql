--1) 4.5 환산 평점이 가장 높은 3인의 학생을 검색하세요.
SELECT ROWNUM
	 , A.SNAME
	 , A.AVG_F
	FROM (
		SELECT SNAME
			 , AVR * 1.125 AS AVG_F
			FROM STUDENT
			ORDER BY AVG_F DESC
			) A
	WHERE ROWNUM <= 3;

--2) 기말고사 과목별 평균이 높은 3과목을 검색하세요.
SELECT ROWNUM
	 , A.CNAME
	FROM (
		SELECT C.CNAME
	 		 , AVG(SC.RESULT) AS AVG_RES
			FROM COURSE C
			JOIN SCORE SC
	  		  ON C.CNO = SC.CNO
    		GROUP BY C.CNAME
    		ORDER BY AVG_RES DESC
    )A		
WHERE ROWNUM <= 3;    
--3) 학과별, 학년별, 기말고사 평균이 순위 3까지를 검색하세요.(학과, 학년, 평균점수 검색)
SELECT ROWNUM
	 , A.MAJOR
	 , A.SYEAR
	 , A.AVG_RES
	FROM (
			SELECT S.MAJOR
	 			 , S.SYEAR
	 			 , AVG(SC.RESULT) AS AVG_RES
				FROM STUDENT S
				JOIN SCORE SC
	  			  ON S.SNO = SC.SNO
				GROUP BY S.MAJOR, S.SYEAR
				ORDER BY AVG_RES DESC
	)A
	WHERE ROWNUM <= 3;

--4) 기말고사 성적이 높은 과목을 담당하는 교수 3인을 검색하세요.(교수이름, 과목명, 평균점수 검색)

SELECT ROWNUM
	 , P.PNAME
	 , A.CNAME
	 , A.AVG_RES
	FROM(
			SELECT C.CNAME
				 , C.PNO
	 			 , AVG(SC.RESULT) AS AVG_RES
				FROM COURSE C
				JOIN SCORE SC
	  			  ON C.CNO = SC.CNO
				GROUP BY C.CNAME, C.PNO
				ORDER BY AVG_RES DESC
	)A
	JOIN PROFESSOR P
	  ON A.PNO = P.PNO
	WHERE ROWNUM <= 3;

--5) 교수별로 현재 수강중인 학생의 수를 검색하세요.
SELECT P.PNAME 
	 , COUNT(S.SNO)
	FROM STUDENT S
	JOIN SCORE SC
	  ON S.SNO = SC.SNO 
	JOIN COURSE C
	  ON SC.CNO = C.CNO
	JOIN PROFESSOR P
	  ON C.PNO = P.PNO
	GROUP BY P.PNAME;