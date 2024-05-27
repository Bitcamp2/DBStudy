--1) 송강 교수가 강의하는 과목을 검색한다
SELECT C.CNO
	 , C.CNAME
	 , C.ST_NUM
	 , C.PNO
	 , P.PNAME
	FROM COURSE C
	JOIN PROFESSOR P
	  ON C.PNO = P.PNO
	  WHERE PNAME = '송강';
	  
--2) 화학 관련 과목을 강의하는 교수의 명단을 검색한다
SELECT P.PNO
	 , P.PNAME
	 , P.SECTION
	 , P.ORDERS
	 , P.HIREDATE
	 , C.PNO
	FROM PROFESSOR P
	JOIN COURSE C
	  ON C.PNO = P.PNO
	  WHERE SECTION = '화학';
	  
--3) 학점이 2학점인 과목과 이를 강의하는 교수를 검색한다
SELECT P.PNO
	 , P.PNAME
	 , P.SECTION
	 , P.ORDERS
	 , P.HIREDATE
	 , C.PNO
	 , C.ST_NUM
	FROM PROFESSOR P
	JOIN COURSE C
	  ON C.PNO = P.PNO
	  WHERE ST_NUM = 2;
	  
--4) 화학과 교수가 강의하는 과목을 검색한다
SELECT C.CNO
	 , C.CNAME
	 , C.ST_NUM
	 , C.PNO
	 , P.PNAME
	FROM COURSE C
	JOIN PROFESSOR P
	  ON C.PNO = P.PNO
	  WHERE CNAME LIKE '%화학';
	  
--5) 화학과 1학년 학생의 기말고사 성적을 검색한다
SELECT SNO
	 , SNAME
	 , SEX
	 , SYEAR
	 , MAJOR
	 , AVR
	FROM STUDENT
	WHERE MAJOR LIKE '%화학'
	ORDER BY SYEAR DESC, AVR DESC;

--6) 일반화학 과목의 기말고사 점수를 검색한다---------------------------------------------------
SELECT S.SNO
	 , ST.SNAME
	 , ST.MAJOR
	 , C.CNAME
	 , S.RESULT
	FROM SCORE S
	JOIN COURSE C
	  ON S.CNO = C.CNO
	JOIN STUDENT ST
	  ON ST.SNO = S.SNO
	  WHERE CNAME = '일반화학'
	 ORDER BY RESULT DESC;
	 
--7) 화학과 1학년 학생의 일반화학 기말고사 점수를 검색한다	 
SELECT S.SNO
	 , ST.SNAME
	 , ST.MAJOR
	 , ST.SYEAR
	 , C.CNAME
	 , S.RESULT
	FROM SCORE S
	JOIN COURSE C
	  ON S.CNO = C.CNO
	JOIN STUDENT ST
	  ON ST.SNO = S.SNO
	  WHERE CNAME = '일반화학'
	  AND MAJOR = '화학'
	  AND SYEAR = 1
	 ORDER BY RESULT DESC;
	 
--8) 화학과 1학년 학생이 수강하는 과목을 검색한다	 
SELECT DISTINCT ST.MAJOR 
	 , ST.SYEAR
	 , C.CNAME
	FROM SCORE S
	JOIN COURSE C
	  ON S.CNO = C.CNO
	JOIN STUDENT ST
	  ON ST.SNO = S.SNO
	  WHERE MAJOR = '화학'
	  AND SYEAR = 1
	 
--9) 유기화학 과목의 평가점수가 F인 학생의 명단을 검색한다
SELECT S.SNO
	 , ST.SNAME
	 , ST.MAJOR
	 , ST.SYEAR
	 , C.CNAME
	 , S.RESULT
	 , G.GRADE
	FROM SCORE S
	JOIN COURSE C
	  ON S.CNO = C.CNO
	JOIN STUDENT ST
	  ON ST.SNO = S.SNO
	JOIN SCGRADE G
	  ON S.RESULT BETWEEN G.LOSCORE AND G.HISCORE
	  WHERE CNAME = '유기화학'
	  AND GRADE = 'F'
	 ORDER BY RESULT DESC;	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 