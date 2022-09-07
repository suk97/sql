-- 6.subQuery.sql
-- 정의 : select 문 내에 포함된 또 다른 select 문
-- 문법 : 비교 연산자(대소비교, 동등비교) 오른쪽에 () 안에 select문 작성 
-- 실행순서 : 서브쿼리가 메인 쿼리보다 먼저 실행
-- 참고 : join 동일한 결과 값

-- 1. SMITH라는 직원 부서명 검색
select deptno
from emp
where ename = 'smith';

select dname
from dept
where deptno = 20;




-- ?join
select e.deptno, d.dname
from emp as e, dept as d
where e.ename = 'smith' and e.deptno = d. deptno;


-- ?서브쿼리(일반 서브쿼리 - where 절에 사용) 먼저 시행
select d.dname
from dept as d
where d.deptno = (select deptno
					from emp
					where ename = 'smith'); 

-- 2. SMITH와 동일한 직급(job)을 가진 사원들 검색(SMITH 포함)
select e2.ename, e2.job
from emp as e, emp as e2
where e.ename = 'smith' and e.job = e2.job;

select ename
from emp
where job = (select job
				from emp
                where ename = 'smith');


-- 3. SMITH와 급여가 동일하거나 더 많은(>=) 사원명과 급여 검색
-- SMITH 제외해서 검색하기
select ename, sal
from emp
where sal >= (select sal
				from emp
                where ename = 'smith') and ename != 'smith';

-- 4. DALLAS에 근무하는 사원의 이름, 부서 번호 검색
			

-- 5. 평균 급여보다 더 많이 받는(>) 사원만 검색
select sal
from emp;

select ename, sal
from emp
where sal > (select avg(sal)
				from emp);



-- 다중행 서브 쿼리(sub query의 결과값이 하나 이상)
-- 6.급여가 3000이상 사원이 소속된 부서에 속한  사원이름, 급여 검색
-- 급여가 3000이상 사원의 부서 번호
-- in 연산자 안에 있는 서브쿼리
select ename, sal, deptno
from emp
where sal >= 3000;

select ename, sal, deptno
from emp
where deptno in (select deptno
					from emp
					where sal >= 3000);


-- 7. in 연산자를 이용하여 부서별로 가장 급여를 많이 받는 사원의 정보(사번, 사원명, 급여, 부서번호) 검색
	-- 사번, 사원명, 급여, 부서번호 
	select max(sal) , ename
    from emp
    group by deptno;


    select empno, ename, sal, deptno
    from emp;
	
	-- 부서별로 가장 급여를 많이 받는 사원
	select empno, ename, sal, deptno
    from emp
    where sal in(select max(sal)
					from emp
					group by deptno)
	
	-- 결과를 부서번호 내림차순 정렬
select empno, ename, sal, deptno
    from emp
    where sal in(select max(sal)
					from emp
					group by deptno)
	order by deptno;
	

-- 8. 직급(job)이 MANAGER인 사람이 속한 부서의 부서 번호와 부서명(dname)과 지역검색(loc)

select *
from dept;

select deptno, dname, loc
from dept 
where deptno in (select deptno
					from emp
					where job = 'manager');
                    
select d.deptno, d.dname, d.loc
from emp e, dept d
where job = 'manager' and e.deptno = d.deptno;

-- 조인 vs 서브쿼리


-- 서브쿼리를 조인으로 대체할 수 없는 경우
-- 1. group by 를 사용한 서브쿼리가 from 절에 있을 때
-- 2. 서브쿼리가 집계된 하나의 값을 반환하고, 그 값을 where 절에서 외부의 쿼리와 비교할 때
-- 3. 서브쿼리가 all 연산자 안에 들어가는 경우


-- union
/*
여러개의 select 결과 값을 하나의 테이블 혹은 집합으로 표현 
! 중복되는 데이터는 제거
! 선택한 필드(컬럼)의 개수, 타입, 순서도 같아야 함
! all 키워드를 붙이게 되면 중복 제거 불가능
*/
select ename
from emp
union
select deptno
from dept;

select ename
from emp
union all
select deptno
from dept;

select ename
from emp
union all
select ename
from emp;

