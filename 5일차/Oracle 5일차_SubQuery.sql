-- 5일차 서브쿼리(SubQuery)
-- 하나의 SQL문 안에 포함되어 있는 또 다른 SQL문
-- 메인 쿼리가 서브 쿼리를 포함하는 종속적인 관계
-- *서브쿼리는 반드시 소괄호로 묶어야 함*
-- *서브쿼리 안에 ORDER BY는 지원 안됨 주의*

-- 예제1
-- 전지연 직원의 관리자 이름을 출력하세요.
SELECT MANAGER_ID FROM EMPLOYEE
WHERE EMP_NAME = '전지연';

SELECT EMP_NAME FROM EMPLOYEE
WHERE EMP_ID = '214';

SELECT EMP_NAME FROM EMPLOYEE
WHERE EMP_ID = (SELECT MANAGER_ID FROM EMPLOYEE
WHERE EMP_NAME = '전지연');

-- [전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여를 조회하세여]
-- 서브쿼리를 쓰지 않는경우
SELECT AVG(SALARY) FROM EMPLOYEE; -- 3047663

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >=3047663;
-- 서브쿼리를 쓰는경우
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE);

-- 1.2 서브쿼리의 종류
-- 1.2.1 단일행 서브쿼리
-- 1.2.2 다중행 서브쿼리
-- 1.2.3 다중열 서브쿼리
-- 1.2.4 다중행 다중열 서브쿼리
-- 1.2.5 상(호연)관 서브쿼리
-- 1.2.6 스칼라 서브쿼리

-- 1.2.2 다중행 서브쿼리
-- 송종기나 박나라가 속한 부서에 속한 직원들의 전체정보를 출력하세요

SELECT * FROM EMPLOYEE
WHERE EMP_NAME IN ('송종기','박나라'); -- D9, D5

SELECT * FROM EMPLOYEE
WHERE DEPT_CODE IN ('D9','D5');

SELECT * FROM EMPLOYEE
WHERE DEPT_CODE IN (
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN('송종기','박나라')); -- 비효율적이어보이는데.. ㅎ

--@실습문제1
-- 차태연, 전지연 사원으 급여등급과 같은 사원의 직급명, 사원명을 출력하세요.
SELECT SAL_LEVEL FROM EMPLOYEE
WHERE EMP_NAME IN ('차태연','전지연'); -- S5, S4

SELECT JOB_NAME, EMP_NAME FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE SAL_LEVEL IN (
SELECT SAL_LEVEL
FROM EMPLOYEE
WHERE EMP_NAME IN ('차태연','전지연'));

-- @실습문제2
-- Asia1지역에 근무하는 직원의 정보(부서코드, 사원명)를 출력하세요.
-- 서브쿼리를 쓰지 않는경우
SELECT DEPT_CODE, EMP_NAME FROM EMPLOYEE
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
WHERE LOCAL_NAME LIKE UPPER('Asia_');

--서브쿼리를 쓰는경우 -- 서브쿼리는 조인을 대체한다?정도로 이해하면 될듯
SELECT DEPT_CODE, EMP_NAME FROM EMPLOYEE
WHERE DEPT_CODE IN (
SELECT DEPT_ID FROM DEPARTMENT
JOIN LOCATION ON LOCATION_ID = (
SELECT LOCAL_CODE FROM LOCATION
WHERE LOCAL_NAME = UPPER('Asia1')));
--WHERE LOCAL_NAME LIKE UPPER('Asia1'));

-- 1.2.5 상(호연)관 서브쿼리
-- - 메인쿼리의 값이 서브쿼리에 사용되는 것
-- - 메인쿼리의 값을 서브쿼리에 주고 서브쿼리를 수행한 다음 그 결과를 다시메인 쿼리로 반환해서 수행하는 것
-- - 상호연관 관계를 가지고 실행하는 쿼리이다.
-- WHERE 조건절의 참 거짓 여부에 따라서 출력되고 안되고
SELECT *FROM EMPLOYEE WHERE EXISTS(SELECT 1 FROM DUAL);
-- 참이므로 출력됨
SELECT *FROM EMPLOYEE E WHERE EXISTS (SELECT 1 FROM EMPLOYEE WHERE MANAGER_ID = E.EMP_ID);
-- WHERE 조건절이 거짓이므로 아무것도 출력되지 않음

-- SELECT 실행순서
-- FROM - WHERE - SELECT
--      GROUP BY - HAVING
--                      ORDER BY

-- 부하직원이 한명이라도 있는 직원의 정보를 출력하시오.

-- EMP_ID 가 200인경우 부하직원이 있는가?
SELECT 1 FROM EMPLOYEE WHERE MANAGER_ID = '200'; --O
SELECT 1 FROM EMPLOYEE WHERE MANAGER_ID = '201'; --O
SELECT 1 FROM EMPLOYEE WHERE MANAGER_ID = '202'; --X
SELECT 1 FROM EMPLOYEE WHERE MANAGER_ID = '203'; --X
SELECT 1 FROM EMPLOYEE WHERE MANAGER_ID = '204'; --O
SELECT 1 FROM EMPLOYEE WHERE MANAGER_ID = '205'; --X

SELECT * FROM EMPLOYEE WHERE EMP_ID IN ('200','201','204');
-- >너무 불편한 작업이므로 
SELECT * FROM EMPLOYEE E WHERE EXISTS (SELECT 1 FROM EMPLOYEE WHERE MANAGER_ID = E.EMP_ID);

SELECT 1 FROM EMPLOYEE WHERE MANAGER_ID = EMP_ID;
--WHERE절의 값이 다 거짓이라 안나옴

--@실습문제1
-- 가장많은 급여를 받는 직원을 출력하시오.
SELECT EMP_NAME, SALARY FROM EMPLOYEE ORDER BY 2 DESC; -- 선동일씨
SELECT * FROM EMPLOYEE WHERE SALARY = 8000000;
SELECT MAX(SALARY) FROM EMPLOYEE;

--단일행 서브쿼리로 구한것
SELECT * FROM EMPLOYEE WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEE);

-- 상관쿼리로는 어떻게?
SELECT 1 FROM EMPLOYEE WHERE SALARY > 8000000;
SELECT 1 FROM EMPLOYEE WHERE SALARY > 6000000;
-- 23번 반복 

SELECT * FROM EMPLOYEE E WHERE NOT EXISTS ( SELECT 1 FROM EMPLOYEE WHERE SALARY > E.SALARY);

-- @실습문제2
-- 가장 적은 급여를 받는 직원을 출력하시오.
SELECT * FROM EMPLOYEE E WHERE NOT EXISTS ( SELECT 1 FROM EMPLOYEE WHERE SALARY < E.SALARY);

-- @실습문제3
-- 심봉선과 같은 부서의 사원의 부서코드, 사원명, 월평균급여를 조회하시오.
SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '심봉선';

SELECT DEPT_CODE, EMP_NAME, (SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING DEPT_CODE = 'D5')" 월평균 급여"
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '심봉선');

SELECT AVG(SALARY) FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING DEPT_CODE = 'D5';

--1. 심봉선과 같은 부서코드를 가진 행만 출력
-- - 검증쿼리
SELECT 1 FROM EMPLOYEE WHERE DEPT_CODE = 'D1' AND EMP_NAME = '심봉선';
SELECT 1 FROM EMPLOYEE WHERE DEPT_CODE = 'D5' AND EMP_NAME = '심봉선';
-- - 메인쿼리
SELECT DEPT_CODE, EMP_NAME
FROM EMPLOYEE E
WHERE EXISTS (SELECT 1 FROM EMPLOYEE
WHERE DEPT_CODE = E.DEPT_CODE AND EMP_NAME = '심봉선');
-- 2. 월 평균 급여 출력
SELECT DEPT_CODE, EMP_NAME, (SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE WHERE DEPT_CODE = E.DEPT_CODE AND EMP_NAME = '심봉선') "월평균급여"
FROM EMPLOYEE E
WHERE EXISTS (SELECT 1 FROM EMPLOYEE
WHERE DEPT_CODE = E.DEPT_CODE AND EMP_NAME = '심봉선');

-- @실습문제4
-- 직급이 J1, J2, J3이 아닌 사원중에서 자신의 부서별 평균급여보다 많은 급여를 받는
-- 직원의 부서코드, 사원명, 급여, (부서별 급여평균) 정보를 출력하시오.



-- 1.2.6 스칼라 서브쿼리

