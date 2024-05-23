--1) 학생의 평균 평점을 다음 형식에 따라 소수점 이하 2자리까지 검색하세요
--'OOO 학생의 평균 평점은 O.OO입니다.'
SELECT SNAME || '학생의 평균 평점은 ' || ROUND(AVR, 2) || '입니다.' 
FROM STUDENT S;

--2) 교수의 부임일을 다음 형식으로 표현하세요
--'OOO 교수의 부임일은 YYYY년 MM월 DD일입니다.'
SELECT PNAME || '교수의 부임일은 ' || SUBSTR(HIREDATE,1,2) 
			 || '년' || SUBSTR(HIREDATE,4,2) || '월' || SUBSTR(HIREDATE,7,2) || '일 입니다.'
	 FROM PROFESSOR;

--3) 교수중에 3월에 부임한 교수의 명단을 검색하세요
SELECT PNAME 
	 , HIREDATE
	FROM PROFESSOR
	WHERE HIREDATE LIKE '%03%'; 