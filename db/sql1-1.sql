-- 2. 해당 계정의 모든 table 목록 검색
SHOW TABLES;

-- 3. emp table의 모든 정보 검색

SELECT *
FROM EMP;

-- 4. emp table의 구조 검색 [묘사]
DESCRIBE EMP;
DESC EMP;

-- 5. emp table의 사번(empno)과 이름(ename)만 검색
SELECT EMPNO, ENAME
FROM EMP;

-- 6.emp table의 입사일(hiredate) 검색
-- 검색 결과 : 날짜 타입 yy/mm/dd, 차후에 함수로 가공
SELECT ENAME, HIREDATE
FROM EMP;
	
-- 7. emp table의 검색시 칼럼명 empno를 사번이란 별칭으로 검색 
SELECT EMPNO AS 사번
FROM EMP;

-- 8. emp table에서 부서번호 검색시 중복 데이터 제거후 검색 
-- 키워드 : 중복제거 키워드 - distinct
-- 사원들이 소속된 부서 번호(deptno)만 검색
SELECT DISTINCT DEPTNO
FROM EMP;

-- 9. 데이터를 오름차순(asc)으로 검색하기(순서 정렬)
-- 키워드 : 정렬 키워드 - order by
-- asc : 오름차순, desc : 내림차순
-- ?사번을 오름차순으로 정렬해서 사번만 검색

SELECT *
FROM EMP
ORDER BY EMPNO DESC;

-- ? 부서번호 정렬(중복제거 후 내림차순으로 정렬)
SELECT DISTINCT DEPTNO
FROM EMP
ORDER BY DEPTNO DESC;

-- 10.emp table 에서 deptno 내림차순 정렬 적용해서 ename과 deptno 검색하기
SELECT ENAME, DEPTNO
FROM EMP
ORDER BY DEPTNO DESC;

-- ?empno와 deptno를 검색하되 단 deptno는 오름차순으로
SELECT EMPNO, DEPTNO
FROM EMP
ORDER BY EMPNO ASC, DEPTNO DESC;

-- 11. 입사일(date 타입의 hiredate) 검색, date 타입은 정렬가능 따라서 경력자(입사일이 오래된 직원)부터 검색(asc)
SELECT HIREDATE
FROM EMP
ORDER BY HIREDATE;

-- ? sql 기반의 사고하는 힘
-- order by 절이 가장 마지막에 실행되는 순서를 간단한 sql 문장으로 입증해 주세요? 힌트 : 컬럼의 별칭

SELECT EMPNO AS 사번
FROM EMP
ORDER BY 사번 DESC; 

-- 12. emp table의 모든 직원명(ename), 월급여(sal), 연봉(sal*12) 검색
-- 단 sal 컴럼값은 comm을 제외한 sal만으로 연봉 검색
SELECT *
FROM EMP;

-- 13. 모든 직원의 연봉 검색(sal *12 + comm) 검색
-- null 값을 보유한 컬럼들은 연산시에 데이터 존재 자체가 무시
-- null값 보유한 컬럼의 연산은 어떤 방법으로 전처리를 해야 하나요?
-- null값의 컬럼을 0으로 수치화 해서 연산 : ifnull/nvl(컬럼명, 변경하고자 하는 수치값)

-- STEP01
SELECT ENAME, IFNULL(COMM, 0)
FROM EMP; 

SELECT ENAME, SAL, SAL*12 + IFNULL(COMM, 0) AS 연봉
FROM EMP;

-- *** 조건식 ***
-- where
-- deptno가 10인 사원 검색
SELECT *
FROM EMP
WHERE DEPTNO=10;

-- ename이 smith 인 사원검색
select *
from emp
where ename='smith';

-- comm 조건 검색을 할때에는? (null 은 어떻게 처리할지?)
select *
from emp
where comm = null;

-- 14. comm이 null인 사원에 대한 검색(ename, comm)
-- sql 연산식 : is or is not
select *
from emp
where comm is null;

-- 15. comm이 null이 아닌 사원에 대한 검색(ename, comm)
select *
from emp
where comm is not null;


-- 16. ename, 전체연봉... comm 포함 연봉 검색


-- 17. emp table에서 deptno 값이 20인(조건식 where) 직원 정보 모두(*) 출력하기 모두(*) 출력하기 : = [sql 동등비교 연산자]
select *
from emp
where deptno=20;


-- ? 검색된 데이터의 sal 값이 내림차순으로 정렬검색
select ename, sal
from emp
where deptno=20
order by sal desc;


-- 18. emp table에서 ename이 smith(SMITH)에 해당하는 deptno값 검색
-- ename 컬럼값, 동등비교 =
select deptno from emp where ename = 'SMITH';
-- 참고 : mysql/mariaDB에서는 문자열에서 대소문자를 구분하지 않음
-- 정확하게 대소문자를 구분하고 싶다면?


-- 19. sal가 900이상(>=)인 직원들의 이름(ename), sal 검색
select ename, sal
from emp
where sal >= 900;

-- 20. deptno가 10이고(and) job이 메니저인 사원이름 검색 
select ename
from emp
where deptno = 10 and job = 'manager';

-- 21. ?deptno가 10이거나(or) job이 메니저(MANAGER)인 사원이름(ename) 검색
-- or 연산자
select ename, deptno, job
from emp
where job = 'manager' or deptno=10;

-- 실행결과 manager가 위 아래 모두 manager 위주로 결과 출력, 그 이유는??


-- 22. deptno가 10이 아닌 모든 사원명(ename) 검색
-- 아니다 : not 부정 연산자, !=, <>
select ename, deptno
from emp
where deptno <> 10;

-- !=


-- 23. sal이 2000 이하(sal<=2000)이거나(or) 3000이상인(sal>=3000) 사원명(ename) 검색
select ename, sal
from emp
where sal <=2000 or sal>=3000;



-- 24. comm이 300 or 500 or 1400인 사원명, comm 검색
-- in 연산자 활용
-- or로 처리되는 모든 데이터를 in (값1, 값2, ...)

select ename, comm
from emp
where comm in(300, 500, 1400);
	

-- 25. ?comm이 300 or 500 or 1400이 아닌(not) 사원명, comm 검색
select ename, comm
from emp
where comm not in(300, 500, 1400);

-- ?comm이 null 인 사원들도 모두 출력하려면?
select ename, comm
from emp
where not comm in(300, 500, 1400) or comm is null;

select ename, comm
from emp
where not ifnull(comm, 0) in(300, 500, 1400);

-- 26. 81년도에 입사한 사원 이름 검색
	-- * oracle db 날짜타입인 date 타입은 대소비교 가능, 값 표현시 ' ' 처리
	-- 함수로 포멧 변경 예정
	-- 81년 1월 1일 ~ 81년 12월 31일까지 범위 
	-- oracle의 date 타입도 대소 비교 연산자 적용 
-- between ~ and

select ename, hiredate
from emp
where hiredate between '1981-01-01' and '1981-12-31';  


-- 27. ename이 M으로 시작되는 모든 사원번호(empno), 이름(ename) 검색  
-- 연산자 like : 한 음절 _ , 음절 개수 무관하게 검색할 경우 %
select empno, ename
from emp
where ename like 'm%';

-- 28. ename이 M으로 시작되는 전체 자리수가 두음절의 사원번호, 이름 검색
select empno, ename
from emp
where ename like 'm_';

-- 29. 두번째 음절의 단어가 M인 모든 사원명 검색 

select ename
from emp
where ename like '_m%';

-- 30. 단어가 M을 포함한 모든 사원명 검색 

select ename
from emp
where ename like '%m%';

-- 연산자 정리
select empno, ename, deptno
from emp
where deptno in (10, 20);

-- any
-- 서브쿼리()로 실행한 모든 결과를 or 연결 해준 것과 같다 ==> in
select empno, sal
from emp
where sal >= any(select sal from emp where sal > 1000 );

select empno, sal
from emp
where sal = any(select sal from emp where sal > 1000 );

-- 결론 : = any는 in과 같다

-- all
-- 서브쿼리()로 실행한 모든 결과를 and 연결 해준 것과 같다
select empno, sal
from emp
where sal = all(select sal from emp where sal > 1000 );

-- 조건을 만족하는 데이터의 존재 여부를 확인할 때 사용하는 연산자
-- exists, not exists
select ename, comm
from emp
where not exists (select ename from emp where ename = 'bbs');



