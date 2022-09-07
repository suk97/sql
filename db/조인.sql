-- 5.join.sql

/*
1. 조인이란?
	다수의 table간에  공통된 데이터를 기준으로 검색하는 명령어
	다수의 table이란?
		동일한 table을 논리적으로 다수의 table로 간주
			- self join
		물리적으로 다른 table간의 조인

2. 사용 table 
	1. emp & dept 
	  : deptno 컬럼을 기준으로 연관되어 있음

	 2. emp & salgrade
	  : sal 컬럼을 기준으로 연관되어 있음


3. table에 별칭 사용 
	검색시 다중 table의 컬럼명이 다를 경우 table별칭 사용 불필요, 
	서로 다른 table간의 컬럼명이 중복된 경우,
	컬럼 구분을 위해 정확한 table 소속명을 알려줘야 함
	- table명 또는 table별칭
	- 주의사항 : 컬럼별칭 as[옵션], table별칭 as 사용 불가


4. 조인 종류 
	1. equi 조인
		 = 동등비교 연산자 사용
		 : 사용 빈도 가장 높음
		 : 테이블에서 같은 조건이 존재할 경우의 값 검색 

	2. not-equi 조인
		: 100% 일치하지 않고 특정 범위내의 데이터 조인시에 사용
		: between ~ and(비교 연산자)

	3. self 조인 
		: 동일 테이블 내에서 진행되는 조인
		: 동일 테이블 내에서 상이한 칼럼 참조
			emp의 empno[사번]과 mgr[사번] 관계

	4. outer 조인 
		: 두개 이상의 테이블이 조인될때 특정 데이터가 모든 테이블에 존재하지 않고 컬럼은 존재하나 null값을 보유한 경우
		  검색되지 않는 문제를 해결하기 위해 사용되는 조인
		- left/right outer join : join 명령어 기준 왼쪽(먼저 사용된것)/오른쪽의 모든 데이터 선택 후, 이후 테이블의 데이터와 join
		
*/
/*
	- Inner Join : on절의 조건(결합 조건)이 일치하는 결과만 출력
	- Self Join : 
	- Outer Join : 결합조건을 만족하지 않아도 종류에 따른 특정 테이블의 모든 데이터를 선택 하여 join
		- left/right outer join : join 명령어 기준 왼쪽(먼저 사용된것)/오른쪽의 모든 데이터 선택 후, 이후 테이블의 데이터와 join
*/		
	

-- 1. dept table의 구조 검색
desc dept;
desc salgrade;

-- dept, emp, salgrade table의 모든 데이터 검색
select *
from dept;
/*
deptno : 부서번호
dname : 부서명
loc : 부서위치
*/

select *
from salgrade;
/*
grade : 급여등급 ( 많이 받을수록 높은 등급 )
losal : 해당 등급의 최소 급여
hisal : 해당 등급의 최대 급여
*/



-- *** 1. 동등 조인 ***
-- = 동등 비교
-- 사원들의 이름, 사번, 부서위치 정보 검색 후 출력
select emp.ename, emp.empno, dept.loc
from emp
inner join dept
on emp.deptno = dept.deptno;


-- 2. SMITH 의 이름ename, 사번empno, 근무지역(부서위치)loc 정보를 검색
select emp.ename, emp.empno, dept.loc
from emp
inner join dept
on emp.deptno = dept.deptno
where emp.ename = 'smith';

-- 별칭 사용 : 별칭을 붙이게 되면 별칭으로만 사용해야함
-- 별칭 혹은 테이블 명을 생략할 수 있음 (단, 해당 컬럼 데이터가 다른 테이블에 없을 경우)
select e.ename, e.empno, d.loc
from emp as e inner join dept as d
on e.deptno = d.deptno
where e.ename = 'smith';



-- 3. deptno가 동일한 모든 데이터 검색
-- emp & dept
/*발생 가능한 경우의 수
1. deptno값이 두번 검색(중복 검색)
	- 해결책 : 컬럼명을 명확히 select 절에 작성
2. 40번 부서에 소속된 직원은 없음, 따라서 40번 부서 정보 검색 불가
	- 해결책 : outer join 사용
*/
select *
from emp as e, dept as d
where d.deptno = d.deptno;


-- 4. 2+3 번 항목 결합해서 SMITH에 대한 모든 정보(ename, empno, sal, comm, deptno, loc) 검색하기
select ename, empno, sal, comm, dept.deptno, loc
from emp , dept
where ename = 'smith' and emp.deptno = dept.deptno;




/* 조건 항목의 부족으로 인한 dept의 모든 row들 검색
select 절의 dept만의 컬럼 검색을 안 했다 하더라도
from 절의 dept table 선언으로 인한 dept 의 모든 row 수만큼 데이터 출력
select ename, empno, sal, comm, emp.deptno, loc 
from emp , dept 
where ename='SMITH';

select ename, empno, sal, comm, emp.deptno
from emp , dept 
where ename='SMITH';
*/


-- 5.  SMITH에 대한 이름(ename)과 부서번호(deptno), 부서명(dept의 dname) 검색하기



-- 6. 조인을 사용해서 뉴욕에 근무하는 사원의 이름과 급여를 검색 
-- loc='NEW YORK', ename, sal




-- 7. 조인 사용해서 ACCOUNTING 부서(dname)에 소속된 사원의 이름과 입사일 검색




-- 8. 직급이 MANAGER인 사원의 이름, 부서명 검색




-- *** 2. not-equi 조인 ***

-- salgrade table(급여 등급 관련 table)
-- 9. 사원의 급여가 몇등급인지 검색
-- between ~ and : 포함
desc salgrade;
select *
from salgrade;

select e.ename, e.sal, s.grade
from emp as e, salgrade as s
where e.sal between s.losal and s.hisal;

-- ? 등급이 3등급인 사원들의 이름과 급여 검색
select e.ename, e.sal, s.grade
from emp as e, salgrade as s
where e.sal between s.losal and s.hisal and s.grade = 3;


-- 10. 사원(emp) 테이블의 부서 번호(deptno)로 부서 테이블을 참조하여 사원명, 부서번호, 부서의 이름(dname) 검색


select *
from emp;

-- *** 3. self 조인 ***
/*emp를 마치 두개의 table 인듯 연상
1. 별칭 e : employee 직원 table
2. 별칭 m : manager table */

-- 11. SMITH 직원의 매니저 이름 검색
/* manager table의 ename 검색
   employee table에 ename='SMITH'
	- SMITH라는 이름으로 상사의 사번 검색
	-> 상사의 사번으로 manager의 사번으로 매니저 이름 검색*/
	
select m.ename, m.deptno
from emp as e, emp as m
where e.ename='smith' and e.mgr = m.empno;


-- 추가문제 SMITH 직원의 매니저의 부서번호 검색




-- 12. 매니저가 KING인 사원들의 이름과 직급 검색
select e.ename, e.job, e.mgr
from emp as e, emp as m
where m.ename = 'king' and e.mgr = m.empno;


-- 13. SMITH와 동일한 근무지에서 근무하는 사원의 이름 검색
-- SMITH 데이터 절대 검색 불가 - hint 부정 연산자
-- SMITH동일 근무지 - deptno로 검색
-- deptno가 일치되는 사원의 이름 -  ename
select *
from emp;

select e2.ename, d.loc
from emp as e, emp as e2, dept as d
where e.ename = 'smith' and e.deptno = e2.deptno and e2.deptno = d.deptno and e2.ename !='smith';


-- *** 4. outer join ***
-- 14. 모든 사원명, 매니저 명 검색, 단 매니저가 없는 사원도 검색되어야 함
-- null값을 포함한 검색도 반드시 필수
	-- 데이터 표현이 부족한 쪽에 + 기호 표기
/* empno - 사원번호(12개 즉 직원수 만큼 존재)
    mgr - 매니저 번호(실제 사용 가능한 데이터는 null을 제외한 11개)
           - null이라는 데이터는 empno에는 미존재
    e.mgr = m.empno(+)
    	- 사원의 mgr(e.mgr) - null 또는 4자리 정수값
	- 매니저의 empno(m.empno) - 4자리 정수값만  */


/* 1. 모든 사원의 모든 매니저명 포함해서 검색
   - 매니저가 없는 사원일지라도 해당 사원의 정보 포함해서 검색 
   2. 경우의 수1 : 매니저가 없는 사원이 있을수 있다
      경우의 수2 : 매니저가 있는 사원이 있을수 있다 
     
   3. 발생된 논리적인 오류   
   - 매니저가 없는 사원 정보가 검색 불가능인 경우 
   
   4. 해결책
   1. 모든 사원은 매니저는 KING인 경우는 없지만 다른 사원들은 존재
   2. KING의 mgr 컬럼값은 null이나, 검색이 되어야 함
   3. 매니저 table에는 null이라는 매니저 사번은 존재하지 않음
   4. 검색
      null값이라도 검색이 되어야 함
      매니저 테이블에는 매니저사번이 null이 매니저는 없지만 검색에 포함해야만 사원 table의 KING도 검색
   5. 데이터가 없는 쪽은 사원 table의 mgr과 매니저 table의 매니저사번 
      - 사원 table에는 mgr 컬럼값에 null 보유 
      - 매니저 table의 매니저 사번에는 null 자체가 없음
      - 결론 : 데이터가 없는 쪽은  매니저 table 
      
*/
select *
from emp;

-- self : king = null 값은 출력되지 않음
select e.ename as 사원, m.ename as 매니저
from emp as e, emp as m
where e.mgr = m.empno;

-- outer : 조건에 부합하지 않는 것도 같이 출력 ( 기준 : left, right )
select e.ename as 사원, m.ename as 매니저
from emp as e left outer join emp as m
on e.mgr = m.empno;



-- 15. 모든 직원명, 부서번호, 부서명 검색
-- 부서 테이블의 40번 부서와 조인할 사원 테이블의 부서 번호가 없지만,
-- outer join이용해서 40번 부서의 부서 이름도 검색하기 

select e.ename, e.deptno, d.dname
from emp as e right outer join dept as d
on e.deptno = d.deptno;


