--41_PLSQL_Question

--1) 과목번호, 과목이름, 과목별 평균 기말고사 성적을 갖는 레코드의 배열을 만들고
--   기본 LOOP문을 이용해서 모든 과목의 과목번호, 과목이름, 과목별 평균 기말고사 성적을 출력하세요.
-- 레코드 배열, 기본 LOOP문, 성적 출력 .... 커서
SELECT *
	FROM COURSE;

CREATE TABLE ST -- 요구 테이블 생성
	AS SELECT C.CNO
	        , C.CNAME
	        , ROUND(AVG(S.RESULT), 2) AS AVG_R
	       FROM SCORE S
	       JOIN COURSE C
	         ON S.CNO = C.CNO
	      GROUP BY C.CNO, C.CNAME;
-----------------------------------------------
DECLARE 
	CURSOR ST_CUR(P_CNO VARCHAR2) IS -- 검색할 수 있게 파라미터 받는 커서 생성
		SELECT CNO
			 , CNAME
			 , AVG_R -- 처음엔 이 부분을 별칭으로 안 적어서 고생함.
			 FROM ST
			WHERE CNO = P_CNO;
			 
	TYPE ST_REC IS RECORD(
		 CNO ST.CNO%TYPE,
		 CNAME ST.CNAME%TYPE,
		 AVG_R NUMBER -- 타입도 간단하게 NUMBER
	);

	STREC ST_REC;

BEGIN
	OPEN ST_CUR('1212'); -- 원하는 과목번호 CNO 검색

	LOOP
		FETCH ST_CUR INTO STREC;
	
		DBMS_OUTPUT.PUT_LINE(STREC.CNO);
		DBMS_OUTPUT.PUT_LINE(STREC.CNAME);
		DBMS_OUTPUT.PUT_LINE(STREC.AVG_R); -- 여기도 별칭으로 하면 됌.
	
		EXIT WHEN ST_CUR%NOTFOUND;
	END LOOP;
	CLOSE ST_CUR;
END;


--2) 학생번호, 학생이름과 학생별 평균 기말고사 성적을 갖는 테이블 T_STAVGSC를 만들고
--   커서를 이용하여 학생번호, 학생이름, 학생별 평균 기말고사 성적을 조회하고 
--   조회된 데이터를 생성한 테이블인 T_STAVGSC에 저장하세요.
CREATE TABLE T_STAVGSC -- 테이블 생성
	AS SELECT S.SNO
		  	, SNAME
		  	, ROUND(AVG(RESULT), 2) AS AVGR
			FROM STUDENT ST
			JOIN SCORE S
			  ON ST.SNO = S.SNO
		   GROUP BY S.SNO, SNAME;
		  
SELECT *
	FROM STUDENT;
------------------------------------
DECLARE
	CURSOR AR_CUR(P_SNO NUMBER) IS
		SELECT SNO
			 , SNAME
			 , AVGR
			 FROM T_STAVGSC
			 WHERE SNO = P_SNO;
			
	TYPE SSS_REC IS RECORD(
		SNO T_STAVGSC.SNO%TYPE,
		SNAME T_STAVGSC.SNAME%TYPE,
		AVGR NUMBER
	);

	SSSREC SSS_REC;
	
BEGIN
	OPEN AR_CUR(915301); -- 조회

	LOOP
		FETCH AR_CUR INTO SSSREC;
	
		EXIT WHEN AR_CUR%NOTFOUND;
	
		DBMS_OUTPUT.PUT_LINE(SSSREC.SNO);		
		DBMS_OUTPUT.PUT_LINE(SSSREC.SNAME);
		DBMS_OUTPUT.PUT_LINE(SSSREC.AVGR);
	
		INSERT INTO T_STAVGSC(SNO, SNAME, AVGR)	 -- 각 필드를 명시적으로 지정하여 INSERT
		VALUES (SSSREC.SNO, SSSREC.SNAME, SSSREC.AVGR);
	
	END LOOP;
	COMMIT;
	CLOSE AR_CUR;
END;


