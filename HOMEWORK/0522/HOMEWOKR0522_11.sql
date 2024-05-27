--1) 각 과목의 과목명과 담당 교수의 교수명을 검색하라
SELECT C.CNO
	 , C.CNAME
	 , P.PNO
	 , P.PNAME
	FROM COURSE C
	JOIN PROFESSOR P
	  ON C.PNO = P.PNO;
	  
--2) 화학과 학생의 기말고사 성적을 모두 검색하라
SELECT ST.SNO
	 , ST.SNAME
	 , ST.MAJOR
	 , SC.RESULT
	FROM STUDENT ST
	JOIN SCORE SC
	  ON SC.SNO = ST.SNO
	  WHERE MAJOR = '화학'
	  ORDER BY RESULT DESC;
	  
--3) 유기화학과목 수강생의 기말고사 시험점수를 검색하라
SELECT ST.SNO
	 , ST.SNAME
	 , C.CNO
	 , C.CNAME
	 , SC.RESULT
	FROM STUDENT ST
	JOIN SCORE SC
	  ON SC.SNO = ST.SNO
	JOIN COURSE C
	  ON C.CNO  = SC.CNO
	  WHERE C.CNAME = '유기화학'
	  ORDER BY RESULT DESC;
	 
--4) 화학과 학생이 수강하는 과목을 담당하는 교수의 명단을 검색하라
SELECT DISTINCT P.PNO
	 , P.PNAME
	 , C.CNAME
	FROM PROFESSOR P
	JOIN COURSE C
	  ON C.PNO = P.PNO
	JOIN SCORE SC
	  ON SC.CNO = C.CNO
	JOIN STUDENT ST
	  ON ST.SNO = SC.SNO
	  WHERE ST.MAJOR = '화학'
	  
--5) 모든 교수의 명단과 담당 과목을 검색한다
SELECT P.PNO
	 , P.PNAME
	 , P.SECTION
	 , C.CNAME
	FROM PROFESSOR P
	LEFT OUTER JOIN COURSE C
	  ON C.PNO = P.PNO;
	  
--6) 모든 교수의 명단과 담당 과목을 검색한다(단 모든 과목도 같이 검색한다)
SELECT P.PNO
	 , P.PNAME
	 , P.SECTION
	 , C.CNAME
	FROM PROFESSOR P
	FULL JOIN COURSE C
	  ON C.PNO = P.PNO;