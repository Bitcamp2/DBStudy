--1) 평점이 3.0에서 4.0사이의 학생을 검색하라(between and)
SELECT S.SNAME
	 , S.AVR
	FROM STUDENT S
	WHERE S.AVR BETWEEN 3.0 AND 4.0;

--2) 1994년에서 1995년까지 부임한 교수의 명단을 검색하라(between and)
SELECT P.PNAME
	 , P.HIREDATE
	FROM PROFESSOR p 
	WHERE HIREDATE BETWEEN TO_DATE('1994-01-01:00:00:00', 'YYYY-MM-DD:HH24:MI:SS')
			  AND TO_DATE('1995-01-01:00:00:00', 'YYYY-MM-DD:HH24:MI:SS');

--3) 화학과와 물리학과, 생물학과 학생을 검색하라(in)
SELECT S.SNAME
	 , S.MAJOR
	FROM STUDENT s 
	WHERE MAJOR IN('화학', '물리');

--4) 정교수와 조교수를 검색하라(in)
SELECT P.PNAME
	 , P.ORDERS
	FROM PROFESSOR p
	WHERE ORDERS IN ('정교수', '조교수');

--5) 학점수가 1학점, 2학점인 과목을 검색하라(in)
SELECT C.CNAME 
	 , C.ST_NUM 
	FROM COURSE c
	WHERE C.ST_NUM IN ('1','2');

--6) 1, 2학년 학생 중에 평점이 2.0에서 3.0사이인 학생을 검색하라(between and)
SELECT S.SNAME
	 , S.AVR
	FROM STUDENT s 
	WHERE S.AVR BETWEEN 2.0 AND 3.0;
	

--7) 화학, 물리학과 학생 중 1, 2 학년 학생을 성적순으로 검색하라(in)
SELECT S.SNAME
	 , S.MAJOR
	 , S.SYEAR 
	 , S.AVR
	FROM STUDENT s 
	WHERE S.SYEAR IN ('1','2')
	ORDER BY AVR DESC;
	

--8) 부임일이 1995년 이전인 정교수를 검색하라(to_date)
SELECT P.PNAME
	 , P.HIREDATE
	 , P.ORDERS 
	FROM PROFESSOR p 
	WHERE HIREDATE < TO_DATE('1995-01-01:00:00:00', 'YYYY-MM-DD:HH24:MI:SS')