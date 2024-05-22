--1) 각 과목의 과목명과 담당 교수의 교수명을 검색하라
SELECT C.CNAME 
	 , P.PNO 
	 , P.PNAME 
	FROM COURSE c 
	JOIN PROFESSOR p 
	  ON C.PNO = P.PNO;

--2) 화학과 학생의 기말고사 성적을 모두 검색하라
SELECT S.SNAME
	 , S.MAJOR
	 , SC.RESULT
	FROM STUDENT s 
	JOIN SCORE SC
	  ON S.SNO = SC.SNO 
	WHERE MAJOR = '화학';

--3) 유기화학과목 수강생의 기말고사 시험점수를 검색하라
SELECT S.SNAME
	 , C.CNAME
	 , SC.RESULT
	FROM STUDENT s 
	JOIN SCORE SC
	  ON S.SNO = SC.SNO 
	 JOIN COURSE c 
	   ON SC.CNO = C.CNO
	WHERE c.CNAME = '유기화학';

--4) 화학과 학생이 수강하는 과목을 담당하는 교수의 명단을 검색하라
SELECT S.SNAME
	 , C.CNAME
	 , P.PNAME
	FROM STUDENT s 
	JOIN SCORE s2 
	  ON S.SNO = S2.SNO 
	JOIN COURSE c 
	  ON S2.CNO = C.CNO 
	JOIN PROFESSOR p 
	  ON C.PNO = P.PNO 
	WHERE MAJOR = '화학';
	
	

--5) 모든 교수의 명단과 담당 과목을 검색한다
SELECT P.PNAME
	 , C.CNAME 
	FROM PROFESSOR p 
	LEFT JOIN COURSE c 
	  ON P.PNO = C.PNO;

--6) 모든 교수의 명단과 담당 과목을 검색한다(단 모든 과목도 같이 검색한다)
SELECT P.PNAME
	 , C.CNAME 
	FROM PROFESSOR p 
	FULL JOIN COURSE c 
	  ON P.PNO = C.PNO;
