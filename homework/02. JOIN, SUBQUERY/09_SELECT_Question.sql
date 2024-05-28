--1) 송강 교수가 강의하는 과목을 검색한다
SELECT C.CNAME
	 , C.PNO 
	 , P.PNAME
	FROM COURSE c 
	JOIN PROFESSOR p 
	  ON C.PNO = P.PNO 
	WHERE P.PNAME = '송강';

--2) 화학 관련 과목을 강의하는 교수의 명단을 검색한다
SELECT C.CNAME
	 , C.PNO 
	 , P.PNAME
	FROM PROFESSOR p 
	JOIN COURSE c 
	  ON P.PNO = C.PNO 
	WHERE C.CNAME LIKE ('%화학%');

--3) 학점이 2학점인 과목과 이를 강의하는 교수를 검색한다
SELECT C.CNAME 
	 , C.PNO 
	 , C.ST_NUM 
	 , P.PNAME 
	FROM COURSE c 
	JOIN PROFESSOR p 
	  ON C.PNO = P.PNO 
	WHERE C.ST_NUM = '2';

--4) 화학과 교수가 강의하는 과목을 검색한다
SELECT C.CNAME
	 , C.PNO 
	 , P.PNAME
	FROM COURSE c 
	JOIN PROFESSOR p 
	  ON C.PNO = P.PNO 
	WHERE C.CNAME LIKE '%화학%';

--5) 화학과 1학년 학생의 기말고사 성적을 검색한다
SELECT S.SNAME
	 , S.SNO 
	 , SC.RESULT
	 , S.SYEAR 
	 , S.MAJOR
	FROM STUDENT s 
	JOIN SCORE SC
	  ON S.SNO = SC.SNO 
	WHERE S.SYEAR = '1'
      AND S.MAJOR = '화학';

--6) 일반화학 과목의 기말고사 점수를 검색한다
SELECT C.CNAME 
	 , C.CNO 
	 , S."RESULT" 
	FROM COURSE c 
	JOIN SCORE s 
	  ON C.CNO = S.CNO 
	WHERE CNAME = '일반화학'

--7) 화학과 1학년 학생의 일반화학 기말고사 점수를 검색한다
SELECT S.SNAME
	 , S.SNO 
	 , SC.RESULT
	 , S.SYEAR 
	 , S.MAJOR
	 , C.CNAME 
	FROM STUDENT s 
	JOIN SCORE SC
	  ON S.SNO = SC.SNO 
	JOIN COURSE c 
	  ON SC.CNO = C.CNO
	WHERE S.SYEAR = '1'
      AND S.MAJOR = '화학'
      AND C.CNAME = '일반화학';

--8) 화학과 1학년 학생이 수강하는 과목을 검색한다
SELECT S.SNAME
	 , S.SNO 
	 , S.SYEAR 
	 , S.MAJOR
	 , C.CNAME 
	FROM STUDENT s 
	JOIN SCORE s2 
	  ON S.SNO = S2.SNO 
	JOIN COURSE c 
	  ON S2.CNO = C.CNO 
	WHERE S.SYEAR = '1'
      AND S.MAJOR = '화학';
      

--9) 유기화학 과목의 평가점수가 F인 학생의 명단을 검색한다
SELECT S.SNAME
	 , S.SNO
	 , C.CNAME 
	 , S2.GRADE 
	FROM STUDENT s 
	JOIN SCORE SC 
	 ON S.SNO = SC.SNO 
	JOIN COURSE c 
	 ON SC.CNO = C.CNO 
	JOIN SCGRADE s2 
	 ON SC."RESULT" BETWEEN S2.LOSCORE AND S2.HISCORE 
	WHERE C.CNAME = '유기화학'
	  AND S2.GRADE = 'F';

