--1) 평점이 3.0에서 4.0사이의 학생을 검색하라(between and)
SELECT SNO
	 , SNAME
	 , SEX
	 , SYEAR
	 , MAJOR
	 , AVR
	FROM STUDENT
	WHERE AVR BETWEEN 3.0 AND 4.0
	ORDER BY SYEAR DESC, AVR DESC;

--2) 1994년에서 1995년까지 부임한 교수의 명단을 검색하라(between and)
SELECT PNO
	 , PNAME
	 , SECTION
	 , ORDERS
	 , HIREDATE
	FROM PROFESSOR
	WHERE HIREDATE BETWEEN 
	TO_DATE('1994/01/01 00:00:00', 'yyyy/MM/dd HH24:Mi:ss') AND TO_DATE('1995/12/31 23:59:59', 'yyyy/MM/dd HH24:Mi:ss');
	
--3) 화학과와 물리학과, 생물학과 학생을 검색하라(in)
SELECT SNO
	 , SNAME
	 , SEX
	 , SYEAR
	 , MAJOR
	 , AVR
	FROM STUDENT
	WHERE MAJOR IN ('화학', '물리', '생물');
	
--4) 정교수와 조교수를 검색하라(in)
SELECT PNO
	 , PNAME
	 , SECTION
	 , ORDERS
	 , HIREDATE
	FROM PROFESSOR
	WHERE ORDERS IN ('정교수', '조교수')
	ORDER BY ORDERS;
	
--5) 학점수가 1학점, 2학점인 과목을 검색하라(in)
SELECT CNO
	 , CNAME
	 , ST_NUM
	 , PNO
	FROM COURSE
	WHERE ST_NUM IN (1, 2);
	
--6) 1, 2학년 학생 중에 평점이 2.0에서 3.0사이인 학생을 검색하라(between and)
SELECT SNO
	 , SNAME
	 , SEX
	 , SYEAR
	 , MAJOR
	 , AVR
	FROM STUDENT
	WHERE SYEAR IN (1, 2)
	AND AVR BETWEEN 2.0 AND 3.0
	ORDER BY SYEAR DESC, AVR DESC;
	
--7) 화학, 물리학과 학생 중 1, 2 학년 학생을 성적순으로 검색하라(in)
SELECT SNO
	 , SNAME
	 , SEX
	 , SYEAR
	 , MAJOR
	 , AVR
	FROM STUDENT
	WHERE MAJOR IN ('화학', '물리')
	AND SYEAR IN (1, 2)
	ORDER BY SYEAR DESC, AVR DESC;
	
--8) 부임일이 1995년 이전인 정교수를 검색하라(to_date)
SELECT PNO
	 , PNAME
	 , SECTION
	 , ORDERS
	 , HIREDATE
	FROM PROFESSOR
	WHERE HIREDATE < TO_DATE ('1994/12/31 23:59:59', 'yyyy/MM/dd HH24:Mi:ss');