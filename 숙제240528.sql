--25_WITH_Question

--1) WITH 절을 이용하여 정교수만 모여있는 가상테이블 하나와 일반과목(과목명에 일반이 포함되는)들이 모여있는 가상테이블 하나를 생성하여 
--   일반과목들을 강의하는 교수의 정보 조회하세요.(과목번호, 과목명, 교수번호, 교수이름)
WITH OPRO AS (
			  SELECT *
			  		FROM PROFESSOR
			  		WHERE ORDERS = '정교수'
),
CCOURSE AS (
			SELECT *
				 FROM COURSE
				 WHERE CNAME LIKE '%일반%'
)
SELECT C.CNO
	 , C.CNAME
	 , O.PNO
	 , O.PNAME
	FROM OPRO O
	JOIN CCOURSE C
	  ON O.PNO = C.PNO;

--2) WITH 절을 이용하여 급여가 3000이상인 사원정보를 갖는 가상테이블 하나와 
-- 보너스가 500이상인 사원정보를 갖는 가상테이블 하나를 생성하여
--   두 테이블에 모두 속해있는 사원의 정보를 모두 조회하세요.
WITH OVER3000 AS (
				  SELECT *
				  		FROM EMP
				  		WHERE SAL >= 3000
),
OVER500 AS (
				  SELECT *
				  		FROM EMP
				  		WHERE COMM >= 500
)
SELECT S.ENO
	 , S.ENAME
	 , C. JOB
	 , C. SAL
	 , C. COMM
	FROM OVER3000 S
	JOIN OVER500 C
	  ON S.ENO = C.ENO;

--3) WITH 절을 이용하여 평점이 3.3이상인 학생의 목록을 갖는 가상테이블 하나와 
-- 학생별 기말고사 평균점수를 갖는 가상테이블 하나를 생성하여
--   평점이 3.3이상인 학생의 기말고사 평균 점수를 조회하세요.
WITH AVR3 AS (
			  SELECT *
			  		FROM STUDENT
			  		WHERE AVR >= 3.3
),
AVGR AS (
		 SELECT SNO
		 	  , AVG(RESULT)
		 	  FROM SCORE
		 	  GROUP BY SNO
)
SELECT *
	FROM AVR3 A
	JOIN AVGR R
	  ON A.SNO = R.SNO;
	 
--4) WITH 절을 이용하여 부임일자가 25년이상된 교수정보를 갖는 가상테이블 하나와 
--과목번호, 과목명, 학생번호, 학생이름, 교수번호, 기말고사성적을 갖는 가상테이블 하나를 생성하여 
-- 기말고사 성적이 90이상인 과목번호, 과목명, 학생번호, 학생이름, 교수번호, 교수이름, 기말고사성적을 조회하세요.
WITH OVER25Y AS (
				 SELECT *
				 	   FROM PROFESSOR
				 	   WHERE ADD_MONTHS(HIREDATE, 300) <= SYSDATE -- 서연님ㄳ ㅠㅠ 
),
RES AS (
	    SELECT C.CNO
	    	 , C.CNAME
	    	 , S.SNO
	    	 , ST.SNAME
	    	 , P.PNO
	    	 , S.RESULT
	    	 FROM COURSE C
	    	 JOIN SCORE S
	    	   ON C.CNO = S.CNO
	    	 JOIN STUDENT ST
	    	   ON S.SNO = ST.SNO
	    	 JOIN PROFESSOR P
	    	   ON P.PNO = C.PNO
)
SELECT R.CNO
	 , R.CNAME
	 , R.SNO
	 , R.SNAME
	 , O.PNO
	 , O.PNAME
	 , R.RESULT
	FROM OVER25Y O
	JOIN RES R
	  ON O.PNO = R.PNO
   WHERE R.RESULT >= 90
   ORDER BY R.RESULT DESC;


--26_DML_DDL_Question

--1) STUDENT 테이블을 참조하여 ST_TEMP 테이블을 만들고 모든 학생의 성적을 4.5만점 기준으로 수정하세요
CREATE TABLE ST_TEMP
	AS SELECT * FROM STUDENT;

UPDATE ST_TEMP
   SET 
   	   AVR = (AVR / 4.0) * 4.5;
   	      
COMMIT;
-- 참고자료			--		 해당 부서의 사원들의 보너스를 50% 인상 (*1.5)
					--		UPDATE EMP_DNO30
					--		   SET 
					--		       DNO = '60',
					--		       COMM = COMM * 1.5
					--		 WHERE DNO = '20'
					--		    OR DNO = '30';
					--		
					--		 COMMIT;
---------------------------------------------------------------------------
--2) PROFESSOR 테이블을 참조하여 PF_TEMP 테이블을 만들고 모든 교수의 부임일자를 100일 앞으로 수정하세요
CREATE TABLE PF_TEMP
	AS SELECT * FROM PROFESSOR;

UPDATE PF_TEMP
   SET 
   	   HIREDATE = HIREDATE - 100;
COMMIT;

--3) ST_TEMP 테이블에서 화학과 2학년 학생의 정보를 삭제하세요
DELETE FROM ST_TEMP
	WHERE SNO IN (
					SELECT SNO
					FROM ST_TEMP
					WHERE SYEAR = '2'
	);
COMMIT;

--4) PF_TEMP 테이블에서 조교수의 정보를 삭제하세요
DELETE FROM PF_TEMP
	WHERE PNO IN (
				  SELECT PNO
					  FROM PROFESSOR
					  WHERE ORDERS LIKE '%조%'
	);
COMMIT;

--5) EMP 테이블을 참조하여 EMP2 테이블을 만들고 DNO 
--   DNO = 30인 사원의 보너스를 15프로 상승시킨 값으로 변경하시고 
--   DNO = 10인 사원의 보너스를 5프로 상승시킨 값으로 변경,
--   DNO = 20인 사원의 급여를 10프로 상승시킨 값으로 변경하세요.
CREATE TABLE EMP2
	AS SELECT * FROM EMP;

UPDATE EMP2
   SET COMM = COMM * 1.15
   WHERE DNO = '30';
COMMIT;  
  
UPDATE EMP2
   SET COMM = COMM * 1.05
   WHERE DNO = '10';
COMMIT;   
   
UPDATE EMP2
   SET SAL = SAL * 1.1
   WHERE DNO = '20';
COMMIT;

--6) 화학과 2학년 학생중 기말고사 성적의 등급이 A, B인 정보를 갖는 테이블 SCORE_STGR을 생성하세요.(SNO, SNAME, MAJOR, SYEAR, CNO, CNAME, RESULT, GRADE) 과목에 대한 등급
CREATE TABLE SCORE_STGR(SNO, SNAME, MAJOR, SYEAR, CNO, CNAME, RESULT, GRADE)
	 AS SELECT ST.SNO
			 , ST.SNAME
			 , ST.MAJOR
			 , ST.SYEAR
			 , C.CNO
			 , C.CNAME
			 , S.RESULT
			 , SG.GRADE
			 FROM STUDENT ST
			 JOIN SCORE S
			   ON ST.SNO = S.SNO
			 JOIN COURSE C
			   ON S.CNO = C.CNO
			 JOIN SCGRADE SG
			   ON RESULT BETWEEN SG.LOSCORE AND SG.HISCORE
			 WHERE MAJOR = '화학'
			   AND SYEAR = '2'
			   AND GRADE IN ('B','A');

--7) 생물학과 학생중 평점이 2.7이상인 학생이 수강중인 과목의 정보를 갖는 테이블 ST_COURSEPF를 생성하세요. (SNO, SNAME, CNO, CNAME, PNO, PNAME, AVR)
CREATE TABLE ST_COURSEPF(SNO, SNAME, CNO, CNAME, PNO, PNAME, AVR)
	AS SELECT ST.SNO
	 , ST.SNAME
	 , C.CNO
	 , C.CNAME
	 , P.PNO
	 , P.PNAME
	 , ST.AVR
	FROM STUDENT ST
	JOIN SCORE S
	  ON ST.SNO = S.SNO
	JOIN COURSE C
	  ON S.CNO = C.CNO
    JOIN PROFESSOR P
      ON P.PNO = C.PNO
   WHERE MAJOR = '생물'
     AND AVR >= 2.7;