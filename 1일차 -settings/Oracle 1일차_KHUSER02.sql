SHOW USER;

CREATE TABLE STUDENT_TBL
(
    NAME VARCHAR2(20),
    AGE NUMBER,
    GRADE NUMBER,
    ADDRESS VARCHAR2(200)
);
-- ⑥마참내 KHUSER02에 테이블이 생성이 가능해짐! → KHUSER02 계정으로 실행

GRANT RESOURCE TO KHUSER02;
-- ④소스 사용권한 부여 → SYSTEM 계정으로 실행
-- ⑤접속 한번 해제하고 다시 접속해야함

