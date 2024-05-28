--1) WITH 절을 이용하여 정교수만 모여있는 가상테이블 하나와 일반과목(과목명에 일반이 포함되는)들이 모여있는 가상테이블 하나를 생성하여 
--   일반과목들을 강의하는 교수의 정보 조회하세요.(과목번호, 과목명, 교수번호, 교수이름)
WITH JPRO AS (SELECT P.PNO, P.PNAME, P.ORDERS FROM PROFESSOR p WHERE P.ORDERS = '정교수'),
     NCOR AS (SELECT C.CNO, C.CNAME, C.PNO FROM COURSE c WHERE C.CNAME LIKE '%일반%') 
SELECT NCOR.CNO, NCOR.CNAME , JPRO.PNO, JPRO.PNAME FROM NCOR JOIN JPRO ON NCOR.PNO = JPRO.PNO;

--2) WITH 절을 이용하여 급여가 3000이상인 사원정보를 갖는 가상테이블 하나와 보너스가 500이상인 사원정보를 갖는 가상테이블 하나를 생성하여
--   두 테이블에 모두 속해있는 사원의 정보를 모두 조회하세요.
WITH SA3000 AS (SELECT ENO, ENAME, SAL FROM EMP WHERE SAL >= 3000)
   , BO500 AS (SELECT ENO, ENAME, COMM FROM EMP WHERE COMM >= 500)
SELECT SA3000.ENO, SA3000.ENAME, SA3000.SAL, BO500.COMM 
FROM SA3000 JOIN BO500 ON SA3000.ENO = BO500.ENO;

--3) WITH 절을 이용하여 평점이 3.3이상인 학생의 목록을 갖는 가상테이블 하나와 학생별 기말고사 평균점수를 갖는 가상테이블 하나를 생성하여
--   평점이 3.3이상인 학생의 기말고사 평균 점수를 조회하세요.
WITH AV33 AS (SELECT SNO, SNAME, AVR FROM STUDENT WHERE AVR >= 3.3)
   , AVGR AS (SELECT SNO, AVG(RESULT) AS AVG_LIST FROM SCORE GROUP BY SNO)
SELECT AV33.SNAME, AV33.AVR, AVGR.AVG_LIST FROM AV33 JOIN AVGR ON AV33.SNO = AVGR.SNO;

--4) WITH 절을 이용하여 부임일자가 25년이상된 교수정보를 갖는 가상테이블 하나와 과목번호, 과목명, 학생번호, 학생이름, 교수번호, 기말고사성적을
--   갖는 가상테이블 하나를 생성하여 기말고사 성적이 90이상인 과목번호, 과목명, 학생번호, 학생이름, 교수번호, 교수이름, 기말고사성적을 조회하세요.
WITH HD25 AS (SELECT P.HIREDATE, P.PNO FROM PROFESSOR P WHERE HIREDATE <= ADD_MONTHS(SYSDATE, -300))
   , EVR AS (SELECT C.CNO, C.CNAME, S.SNO, S.SNAME, PP.PNO, PP.PNAME, SC.RESULT 
   			 FROM PROFESSOR PP JOIN COURSE C ON PP.PNO = C.PNO 
   			 JOIN SCORE SC ON C.CNO = SC.CNO JOIN STUDENT s ON SC.SNO = S.SNO)
SELECT EVR.CNO, EVR.CNAME, EVR.SNO, EVR.SNAME, EVR.PNO, EVR.PNAME, EVR.RESULT
	FROM HD25 JOIN EVR ON HD25.PNO = EVR.PNO
	WHERE EVR.RESULT >= 90
	ORDER BY CNO;






