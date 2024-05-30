--1) SCORE 테이블과 동일한 구조를 갖는 SCORE_CHK를 생성하고 RESULT 60이상 90이하만 입력 가능하도록 하세요.
CREATE TABLE SCORE_CHK(
	SNO VARCHAR2(8),
	CNO VARCHAR2(8),
	RESULT NUMBER(3) CHECK(RESULT BETWEEN 60 AND 90)
);

INSERT INTO SCORE_CHK
VALUES('1111', '1111', 78.1);
COMMIT;

SELECT *
	FROM SCORE_CHK;

--2) STUDENT 테이블과 동일한 구조를 갖는 STUDENT_COPY 테이블을 생성하면서 SNO은 PK로 SNAME은 NOT NULL로 SYEAR의 DEFAULT는 1로 
--   설정하세요.
CREATE TABLE STUDENT_COPY(
	SNO VARCHAR2(8) PRIMARY KEY,
	SNAME VARCHAR2(20) NOT NULL,
	SEX VARCHAR2(3),
	SYEAR NUMBER(1, 0) DEFAULT 1,
	MAJOR VARCHAR2(20),
	AVR NUMBER(4, 2)
);
INSERT INTO STUDENT_COPY
VALUES('1111', NULL, '남', '3', '컴공', 99.99);
COMMIT;
SELECT *
	FROM STUDENT_COPY;

--3) COURSE 테이블과 동일한 구조를 갖는 COURSE_CONTSRAINT 테이블을 생성하면서 CNO, CNAME을 PK로 PNO은 PROFESSOR_PK의 PNO을 참조하여
--   FK로 설정하고 ST_NUM은 DEFAULT 2로 설정하세요.
CREATE TABLE PROFESSOR_PK
AS SELECT * FROM PROFESSOR;

ALTER TABLE PROFESSOR_PK
ADD CONSTRAINT PK_PROFESSOR_PK_PNO PRIMARY KEY(PNO);
COMMIT;

CREATE TABLE COURSE_CONSTRAINT (
	CNO VARCHAR2(8),
	CNAME VARCHAR2(20),
	ST_NUM NUMBER(1,0) DEFAULT 2,
	PNO VARCHAR2(8) REFERENCES PROFESSOR_PK(PNO),
	CONSTRAINT PK_COURSE_CONSTRAINT_CNO_CNAME PRIMARY KEY (CNO, CNAME)
);
INSERT INTO COURSE_CONSTRAINT
VALUES('1211', '일반화학1', '3', '1001');
COMMIT;
SELECT *
	FROM COURSE_CONSTRAINT;