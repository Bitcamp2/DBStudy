--1) 과목번호, 과목이름, 과목별 평균 기말고사 성적을 갖는 레코드의 배열을 만들고
--   기본 LOOP문을 이용해서 모든 과목의 과목번호, 과목이름, 과목별 평균 기말고사 성적을 출력하세요.
DECLARE
	TYPE CO_REC IS RECORD(
		 CNO COURSE.CNO%TYPE,
		 CNAME COURSE.CNAME%TYPE,
		 

	)
BEGIN
	LOOP
		
	END LOOP
	
END





SELECT  









--2) 학생번호, 학생이름과 학생별 평균 기말고사 성적을 갖는 테이블 T_STAVGSC를 만들고
--   커서를 이용하여 학생번호, 학생이름, 학생별 평균 기말고사 성적을 조회하고 
--   조회된 데이터를 생성한 테이블인 T_STAVGSC에 저장하세요.
CREATE TABLE T_STAVGSC
AS SELECT S.SNO
		, S.SNAME
		, AVG(SC.RESULT)
		FROM STUDENT S
		JOIN SCORE SC
		  ON S.SNO = SC.SNO
		GROUP BY S.SNO, S.SNAME;

--DECLARE
	CURSOR ST_AVG IS
		SELECT ST.SNO
			 , ST.SNAME
			 , AVG(SCO.RESULT)
			FROM STUDENT ST
			JOIN SCORE SCO
			  ON ST.SNO = SCO.SNO
			GROUP BY ST.SNO, ST.SNAME


		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		