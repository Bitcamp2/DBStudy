-- #3

--1) 학생중에 동명이인을 검색한다
SELECT *
	FROM STUDENT S1
	JOIN STUDENT S2
	  ON S1.SNAME = S2.SNAME
	WHERE S1.SNAME = S2.SNAME AND S1.SNO != S2.SNO;
	
--2) 전체 교수 명단과 교수가 담당하는 과목의 이름을 학과 순으로 검색한다
SELECT P.PNAME
	 , C.CNAME
	FROM COURSE C
	JOIN PROFESSOR P
	  ON C.PNO = P.PNO
	ORDER BY P."SECTION";


--3) 이번 학기 등록된 모든 과목과 담당 교수의 학점 순으로 검색한다
SELECT C.CNAME
	 , C.ST_NUM
	FROM COURSE C
	JOIN PROFESSOR P
	  ON C.PNO = P.PNO 
	ORDER BY C.ST_NUM DESC;