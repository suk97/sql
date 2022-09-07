use scott;

-- 4.selectGroupFunction.sql
-- 그룹함수란?  다수의 행 데이터를 한번에 처리
/*
1.count

*/


/* 기본 문법
1. select절
2. from 절
3. where절

 * 그룹함수시 사용되는 문법
1. select절 : 검색하고자 하는 속성
2. from절	: 검색 table
3. group by 절 : 특정 조건별 그룹화하고자 하는 속성
4. having 절 : 그룹함수 사용시 조건절
5. order by절 : 검색된 데이터를 정렬

* 실행 순서 : from -> where -> select -> group -> having -> order
*/

-- 1. count() : 개수 확인 함수
-- emp table의 직원이 몇명?

select count(*)
from emp;




-- ? comm 받는 직원 수만 검색 
select count(comm)
from emp;


-- 2. sum() : 합계 함수
-- ? 모든 사원의 월급여(sal)의 합
select sum(sal)
from emp;


-- ? 모든 직원이 받는 comm 합
select sum(comm)
from emp;

-- ?  MANAGER인 직원들의  월급여의 합 
select sum(sal)
from emp
where job ='manager';


-- ? job 종류 counting[절대 중복 불가 = distinct]
-- 데이터 job 확인
select count(distinct job)
from emp;


-- 3. avg() : 평균
-- ? emp table의 모든 직원들의 급여 평균 검색
select avg(sal)
from emp;

select round(avg(sal))
from emp;

-- ? 커미션 받는 사원수, 총 커미션 합, 평균 구하기
select count(comm), sum(comm), avg(comm)
from emp;


-- 4. max(), min() : 최대값, 최소값
-- 숫자, date 타입에 사용 가능

-- 최대 급여, 최소 급여 검색
select max(sal), min(sal)
from emp;

-- ? 최근 입사한 사원의 입사일과, 가장 오래된 사원의 입사일 검색
-- max(), min() 함수 사용해 보기
select max(hiredate), min(hiredate)
from emp;

-- 오늘로부터 입사한지 가장 오래된 일수 계산?
select datediff(sysdate(), min(hiredate))
from emp;

-- *** 
/* group by절
- 특정 컬럼값을 기준으로 그룹화
	가령, 10번 부서끼리, 20번 부서끼리..
*/

-- 부서별 커미션 받는 사원수 
select deptno, count(comm)
from emp
group by deptno;

-- test : count에 포함되어 있는 사원번호도 같이 출력하고 싶다면
select empno, deptno, count(comm)
from emp
group by deptno;
/*
	empno - 12행 / deptno - 4 -> 3행 / count(comm) 3행
*/

-- step01 : 완성된 기본 문장



-- step02 : deptno라는 부서 번호를 오름차순으로 정렬
select deptno, count(comm)
from emp
group by deptno
order by deptno;

select deptno, count(comm)
from emp
group by deptno
order by count(comm) desc;

select deptno, count(comm) as 인원
from emp
group by deptno
order by 인원 desc;

/*
	group by를 사용할 때에는 group by 절에 명시한 컬럼만 select 절에 사용한다
*/

-- step03 : 사원명도 검색



-- ? 부서별(group by deptno) (월급여) 평균 구함(avg())
select deptno, round(avg(sal))
from emp
group by deptno;



-- ? 소속 부서별 급여 총액과 평균 급여 검색[deptno 오름차순 정렬]
select deptno, sum(sal), round(avg(sal))
from emp
group by deptno
order by deptno;


-- ? 소속 부서별 최대 급여와 최소 급여 검색[deptno 오름차순 정렬]
-- 컬럼명 별칭에 여백 포함한 문구를 사용하기 위해서는 쌍따옴표로만 처리
select deptno, max(sal) as "최 대", min(sal) as "최 소"
from emp
group by deptno
order by deptno;




-- *** having절 *** [ 조건을 주고 검색하기 ]
-- 그룹함수 사용시 조건문

-- 1. ? 부서별(group by) 사원의 수(count(*))와 커미션(count(comm)) 받는 사원의 수
select deptno, count(*), count(comm)
from emp
group by deptno;


-- 조건 추가
-- 2. ? 부서별 그룹을 지은후(group by deptno), 
-- 부서별 평균 급여(avg())가 2000 이상인 부서의 번호와 평균 급여 검색 
select deptno, avg(sal) as 평균급여
from emp
group by deptno;

-- step01 : having 절 연습
select deptno, avg(sal) as 평균급여
from emp
group by deptno
having 평균급여 >= 2000;




-- step02 : deptno 로 정렬
select deptno, avg(sal)
from emp
group by deptno
order by deptno;



-- step03 : avg(sal) 평균급여라는 별칭 부여, 평균 급여로 정렬




-- 3. 부서별 급여중 최대값(max)과 최소값(min)을 구하되 최대 급여가 2900이상(having)인 부서만 출력
select deptno, max(sal), min(sal)
from emp
group by deptno
having max(sal) >= 2900;



-- rollup : 중간 합계 with rollup구문 사용되는
select deptno, sum(sal * 12)
from emp
group by deptno
with rollup;

-- 두 문제를 직접 만들어보기

-- 1. 직업별 평균 급여를 구하고, 평균급여가 2500 이상인 직업만 출력
select job, avg(sal)
from emp
group by job
having avg(sal) >= 2500;

-- 2. 부서별로 연봉을 구하고 모든 부서 연봉 총합을 출력하라
select deptno, sum(sal * 12)
from emp
group by deptno
with rollup;

-- 3. 직업별로 가장 급여를 적게 받는 사원
select job, ename, sal
from emp
where sal in(select min(sal)
				from emp
				group by job);


-- 재선
-- Q1. 부서별 1981년 이후에 입사한 사람들 명수를 구하고 그룹별로 몇영인지 나타내시요
select deptno,count(*)
from emp
where hiredate >= '1981.01.01'
group by deptno;

-- Q2. 년도 구분 없이 6월에 입사한 사원 이름 , 입사일 검색
select ename, hiredate
from emp
where hiredate like '%-06-%';


-- Q3. 날짜 문자열('20220906')을 날짜형식으로 변환 
select str_to_date('20220906','%Y%m%d');

-- 동하
-- Q1. 직업별 평균급여를 구하고 평균급여가 높은 순으로 나열하기
select job, avg(sal) as 평균급여
from emp
group by job
order by 평균급여 desc;

-- Q2. 직업이 manager인 사원중 가장 급여를 적게 받는 사원의 사번 , 이름, 직업, 급여 , 부서 번호 출력하기
select empno, ename, job, sal, deptno
from emp
where sal = (select min(sal) 
				from emp 
                where job = 'manager');

-- Q3. loc이 CHICAGO 이고 직업이 MANAGER인 사람 중에서 급여가 큰 순으로 사번 사원명  loc  급여 출력
select e.empno, e.ename, e.job, d.loc, e.sal
from emp as e , dept as d
where d.loc = 'CHICAGO' and e.job ='manager'
order by SAL desc;

-- 용민
-- 1. 각 부서별 최소 급여를 받는 사원의 정보를 검색하고 부서를 오름차순으로 정렬
select *
from emp
where sal in (select min(sal) 
				from emp 
                group by deptno)
order by deptno;

-- 2. 평균 급여보다 적게 받는 사원만 검색
select *
from emp
where sal < (select avg(sal)
					from emp);

-- 3. king 과 동일한 직급을 가진 사원들 검색 (king 포함)
select c.ename 
from emp as e, emp as c
where e.ename = 'king' and e.job = c.job;