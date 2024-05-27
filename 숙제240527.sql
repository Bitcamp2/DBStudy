--17_GROUPFUNCTION_Question

--1) 각 학과별 학생 수를 검색하세요
SELECT MAJOR
	 , COUNT(*)
	FROM STUDENT
	GROUP BY MAJOR;

--2) 화학과와 생물학과 학생 4.5 환산 평점의 평균을 각각 검색하세요
SELECT MAJOR
	 , SNAME
	 , AVG((AVR / 4.0) * 4.5) AS "4.5"-- 4.5환산 평점.. 이해 부족..
	 FROM STUDENT ST 
	 JOIN SCORE S
	   ON ST.SNO = S.SNO
	 GROUP BY MAJOR, SNAME
	 HAVING MAJOR IN ('화학', '생물');

--3) 부임일이 10년 이상 된 직급별(정교수, 조교수, 부교수) 교수의 수를 검색하세요
SELECT *
	FROM PROFESSOR P
	WHERE HIREDATE BETWEEN TO_CHAR(TO_DATE(HIREDATE, 'YYYY')) AND TO_CHAR(TO_DATE(HIREDATE, 'YYYY')*120) ; -- ???????????????????????

--4) 과목명에 화학이 포함된 과목의 학점 수 총합을 검색하세요 ----화학이란 단어가 포함된 과목들의 학점의 총합을 검색하라
SELECT CNAME
	 , SUM(ST_NUM)
	FROM COURSE
	WHERE CNAME LIKE '%화학%'
	GROUP BY CNAME; -- ???????????????????

--5) 학과별 기말고사 평균을 성적순(성적 내림차순)으로 검색하세요
SELECT MAJOR
	 , AVG(RESULT)
	 FROM STUDENT ST
	 JOIN SCORE S
	   ON ST.SNO = S.SNO 
	   GROUP BY MAJOR
	   ORDER BY AVG(RESULT) DESC;
	
--6) 30번 부서의 업무별 연봉의 평균을 검색하세요(소수점 두자리까지 표시)
SELECT JOB
	 , ROUND(AVG(SAL),2)
	 FROM EMP 
	 WHERE DNO = '30'
	 GROUP BY JOB;
	
--7) 물리학과 학생 중에 학년별로 성적이 가장 우수한 학생의 평점을 검색하세요(학과, 학년, 평점)
SELECT MAJOR
	 , SYEAR
	 , MAX(AVR)
	 FROM STUDENT
	 GROUP BY MAJOR, SYEAR
	 HAVING MAJOR = '물리';

--18_GROUPFUNCTION_Question

--1) 화학과를 제외하고 학과별로 학생들의 평점 평균을 검색하세요
SELECT MAJOR
	 , AVG(AVR)
	FROM STUDENT
	WHERE MAJOR IN ('물리', '식영', '생물', '유공')
	GROUP BY MAJOR;

--2) 화학과를 제외한 각 학과별 평균 평점 중에 평점이 2.0 이상인 정보를 검색하세요
SELECT MAJOR
	 , AVG(AVR)
	FROM STUDENT
	WHERE MAJOR IN ('물리', '식영', '생물', '유공')
	GROUP BY MAJOR
	HAVING AVG(AVR) >= 2.0 ;

--3) 기말고사 평균이 60점 이상인 학생의 정보를 검색하세요
SELECT ST.SNO
	 , SNAME
	 , AVG(RESULT) 
	FROM STUDENT ST
	JOIN SCORE S
	  ON ST.SNO = S.SNO
	GROUP BY ST.SNO, SNAME
	HAVING AVG(RESULT) >= 60;

--4) 강의 학점이 3학점 이상인 교수의 정보를 검색하세요
SELECT P.PNAME
	 , C.ST_NUM
	FROM PROFESSOR P
	JOIN COURSE C
	  ON P.PNO = C.PNO 
	 WHERE ST_NUM >= 3;
	
--5) 기말고사 평균 성적이 핵화학과목보다 우수한 과목의 과목명과 담당 교수명을 검색하세요
SELECT CNAME
	 , PNAME
	 , AVG(RESULT)
	FROM SCORE S
	JOIN COURSE C
	  ON S.CNO = C.CNO
	JOIN PROFESSOR P
	  ON P.PNO = C.PNO
	GROUP BY CNAME, PNAME
	HAVING AVG(RESULT) >= '50.49';

--6) 근무 중인 직원이 4명 이상인 부서를 검색하세요(부서번호, 부서명, 인원수)SELECT D.DNO
	 , D.DNAME
	 , COUNT(DNAME)
	 FROM DEPT D
	 JOIN EMP E
	   ON D.DNO = E.DNO
	 GROUP BY D.DNO, DNAME
	 HAVING COUNT(DNAME) >= 4;	
	
--7) 업무별 평균 연봉이 3000 이상인 업무를 검색하세요
SELECT JOB
	 , AVG(SAL)
	 FROM EMP
	 GROUP BY JOB
	 HAVING AVG(SAL) >= 3000;

--8) 각 학과의 학년별 인원중 인원이 5명 이상인 학년을 검색하세요
SELECT MAJOR
	 , SYEAR
	 , COUNT(SNO)
	FROM STUDENT
	GROUP BY MAJOR, SYEAR
	HAVING COUNT(SNO) >= 5;

--19_GROUPFUNCTION_Question

--1) 각 학과별 학년별 학생 수를 ROLLUP함수로 검색하세요


--2) 화학과와 생물학과 학생 4.5 환산 평점의 평균을 각각 검색하는 데 화학과 생물이 열로 만들어지도록 하세요.(PIVOT 사용)


--3) 학과별 학생이름을 ,로 구분하여 성적순으로(내림차순) 조회하세요.(LISTAGG 사용)


--4) 부서별 업무별 연봉의 평균을 검색하세요(부서와 업무 컬럼의 그룹화 여부도 같이 검색, GROUPING 사용)


--20_ADDITIONALJOIN_Question

--1) 각 과목의 과목번호, 과목명, 담당 교수의 교수번호, 교수명을 검색하라(NATURAL JOIN 사용)


--2) 화학과 학생의 기말고사 성적을 모두 검색하라(JOIN USING 사용)


--3) 화학 관련 과목을 강의하는 교수의 명단을 검색한다(NATURAL JOIN 사용)


--4) 화학과 1학년 학생의 기말고사 성적을 검색한다(NATURAL JOIN 사용)


--5) 일반화학 과목의 기말고사 점수를 검색한다(JOIN USING 사용)


--6) 화학과 1학년 학생이 수강하는 과목을 검색한다(NATURAL JOIN 사용)


--21_MULTIIN_Question

--1) 다중 컬럼 IN절을 이용해서 기말고사 성적이 80점 이상인 과목번호, 학생번호, 기말고사 성적을 모두 조회하세요.


--2) 다중 컬럼 IN절을 이용해서 화학과나 물리학과면서 학년이 1, 2, 3학년인 학생의 정보를 모두 조회하세요.


--3) 다중 컬럼 IN절을 사용해서 부서가 10, 20, 30이면서 보너스가 1000이상인 사원의 사원번호, 사원이름, 부서번호, 부서이름, 업무, 급여, 보너스를 
--   조회하세요.(서브쿼리 사용)


--4) 다중 컬럼 IN절을 사용하여 기말고사 성적의 최고점이 100점인 과목의 과목번호, 과목이름, 학생번호, 학생이름, 기말고사 성적을 조회하세요.(서브쿼리 사용)