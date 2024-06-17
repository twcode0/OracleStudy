SHOW USER;

CREATE TABLE EMPLOYEE(
    NAME VARCHAR2(20),
    T_CODE VARCHAR2(10),
    D_CODE VARCHAR2(10),
    AGE NUMBER
);
-- 1. 컬럼의 데이터 타입 없이 테이블 생성하여 오류남
-- → 데이터타입 작성
-- 2. 권한도 없이 테이블을 생성하여 오류남
-- → System_계정에서 RESOURCE 권한 부여
-- 3. ★접속해제 후 접속, 새로운 워크시트 말고 기존 워크시트에서 접속을 선택하여
-- 명령어 재실행

INSERT INTO EMPLOYEE(NAME, T_CODE, D_CODE, AGE)
VALUES('일용자', 'T1', 'D1', 33);
--어떤 테이블에 값을 넣는 것
-- 오라클은 쌍따옴표를 쓸 일이 없음 !

INSERT INTO EMPLOYEE(NAME, T_CODE, D_CODE, AGE)
VALUES('이용자', 'T2', 'D1', 44);

INSERT INTO EMPLOYEE
VALUES('삼용자', 'T1', 'D2', 32);

INSERT INTO EMPLOYEE
VALUES('일용자', 'T2', 'D1', 43);

DROP TABLE EMPLOYEE;
-- 테이블 전체 삭제// 테이블을 CREATE 다시 해야함
-- 쓰지않도록 조심하자..
DELETE FROM EMPLOYEE;
-- 테이블 안에 있는것을 전부 삭제
-- 쓰지않도록 조심하자..
DELETE FROM EMPLOYEE WHERE NAME = '일용자' AND T_CODE = 'T2';
-- ★DELETE 는 반드시 WHERE절이랑 같이쓴다★

UPDATE EMPLOYEE SET T_CODE = 'T3' WHERE NAME = '일용자';
-- 쓰지않도록 조심하자..
-- 이름이 일용자인 TCODE를 T3로 변경

SELECT NAME, T_CODE, D_CODE, AGE FROM EMPLOYEE
WHERE NAME = '일용자';
--명령어로 조회하는 방법

SELECT * FROM EMPLOYEE;
--모든 컬럼에 대해서 조사하는 것

-- 이름이 STUDENT_TBL인 테이블을 만드세요
-- 이름, 나이, 학년, 주소를 저장할 수 있도록 하며
-- 일용자, 21 ,1 , 서울시 중구를 저장해주세요
-- 일용자를 사용자로 바꿔주세요.
-- 데이터를 삭제하는 쿼리문을 작성하고 삭제를 확인하고
-- 테이블을 삭제하는 쿼리문을 작성 테이블이 사라진 것을 확인하세요.

CREATE TABLE STUDENT_TBL(
    NAME VARCHAR2(20),
    AGE NUMBER,
    GRADE NUMBER,
    ADDRESS VARCHAR2(20)
);
--테이블 생성

SELECT * FROM STUDENT_TBL;
-- STUDENT_TBL을 모두 나타내용~

INSERT INTO STUDENT_TBL(NAME, AGE, GRADE, ADDRESS)
VALUES('일용자', 21, 1, '서울시 중구');
--저장
COMMIT;
-- 완전 저장
ROLLBACK;
-- 한단계 전으로 COMMIT 하면 COMMIT 앞부분까지롤백

UPDATE STUDENT_TBL
SET NAME = '사용자';
--데이터 수정

DELETE FROM STUDENT_TBL;
-- 테이블 안의 데이터를 삭제

DROP TABLE STUDENT_TBL;
--테이블 전체 삭제

-- 아이디가 KHUSER02 비밀번호가 KHUSER02인 계정을 생성하고
-- 접속이 되도록하고 테이블도 만들 수 있도록 하세요.
-- → 시스템에서 CREATE// GRANT 하기 

CREATE USER KHUSER02 IDENTIFIED BY KHUSER02;
--①KHUSER02 계정 생성 → System_계정으로 실행해야함

GRANT CONNECT TO KHUSER02;
--②커넥트 권한 부여 → System_계정으로 실행해야함
--③초록더하기로 열기


