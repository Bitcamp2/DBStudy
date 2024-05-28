--1) 학생중에 동명이인을 검색한다
SELECT S.SNAME 
	 FROM STUDENT s 
	 JOIN STUDENT s2 
	   ON S.SNAME = S2.SNAME  
	  AND S.SNAME != S2.SNAME;
	  
	 

--2) 전체 교수 명단과 교수가 담당하는 과목의 이름을 학과 순으로 검색한다
SELECT P.PNAME 
	 , P."SECTION" 
	 , C.CNAME 
	FROM PROFESSOR p 
	LEFT JOIN COURSE c 
	  ON P.PNO = C.PNO 
	ORDER BY C.CNAME ;

--3) 이번 학기 등록된 모든 과목과 담당 교수의 학점 순으로 검색한다
SELECT C.CNAME 
	 , C.ST_NUM 
	 , P.PNAME 
	FROM COURSE c 
	LEFT JOIN PROFESSOR p 
	  ON C.PNO = P.PNO 
	ORDER BY ST_NUM ;