-- 6일차 DCL - TCL

-- TCL(Transaction Control Language)
-- COMMIT, ROLLBACK, SAVEPOINT
-- 트랜잭션이란?
-- 한꺼번에 수행되어야 할 최소의 작업 단위를 말함
-- ATM 출금, 계좌이체 등이 트랜잭션의 예시
/* 1. 카드투입
    2. 메뉴선택
    3. 금액입력
    4.비밀번호 입력
    5.출금완료
*/
--계좌이체
/* 1.송금버튼터치
    2.계좌번호 입력
    3. 은행명선택
    4. 금액입력
    5.비밀번호
    6.이체버튼 터치
*/

-- ORACLE DBMS 트랜잭션?
-- - INSERT 수행 OR UPDATE 수행 OR DELETE 수행이 되었다면 그 뒤에 추가작업이
--   있을 것으로 간주하고 처리 → 트랜잭션이 걸렸다.
DESC USER_GRADE;
INSERT INTO USER_GRADE
VALUES(10, '일반회원');

COMMIT;
ROLLBACK;
--TCL 명령어
-- 1. COMMIT : 트랜잭션 작업이 정상 완료되어 변경 내용응ㄹ 영구히 저장(모든 savepoint 삭제)
-- 2. ROLLBACK : 트랜잭션 작업을 모두 취소하고 가장 최근 COMMIT 시점으로 이동.
-- 3. SAVEPOINT <savepoint명> : 현재 트랜잭션 작업 시점에 이름을 지정함.
-- 임시저장이라고 하며 하나의 트랜잭션에서 구역을 나눌 수 있음.

CREATE TABLE USER_TCL(
    USER_NO NUMBER UNIQUE,
    USER_ID VARCHAR2(30) PRIMARY KEY,
    USER_NAME VARCHAR2(20) NOT NULL
);
drop table user_tcl;
INSERT INTO USER_TCL
VALUES(1, 'khuser01', '일용자');
COMMIT;
SELECT * FROM USER_TCL;

INSERT INTO USER_TCL
VALUES(2, 'khuser02', '이용자');

INSERT INTO USER_TCL
VALUES(3, 'khuser03', '삼용자');
SAVEPOINT UNTIL3; -- 세이브포인트 생성

INSERT INTO USER_TCL
VALUES(4, 'khuser04', '사용자');
ROLLBACK TO UNTIL3; -- SAVEPOINT 로 이동
ROLLBACK; -- 최종 커밋한 시점으로 이동 , SAVEPOINT 삭제

-- DCL(Data Control Language)
-- DB에 대한 보안, 무결성, 복구 등 DBMS를 제어하기 위한 언어이다.
-- GRANT, REVOKE, (COMMIT, ROLLBACK)
-- 권한부여 및 회수는 System_계정에서만 가능(red)

SELECT * FROM CHUN.TB_CLASS;

