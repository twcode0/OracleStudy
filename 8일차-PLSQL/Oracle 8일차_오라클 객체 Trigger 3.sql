-- 8일차 
-- 오라클 객체 Trigger
-- 트리거 : 방아쇠, 연쇄반응
-- 특정 이벤트나 DDL, DML 문장이 실행되었을 때
-- 자동적으로 일련의 동작(Operation) 처리가 수행되도록 하는 데이터베이스 객체 중 하나임
-- 예시) 회원탈퇴가 이루어진 경우 탈퇴한 회원 정보를 일정기간 저장해야 하는 경우
-- 예시2) 데이터 변경이 있을 때, 조작한 데이터에 대한 로그(이력)을 남겨야 하는 경우

-- 트리가 사용 방법
-- CREATE TRIGGER 트리거명
-- BEFORE (OR AFTER)
-- DELETE (OR UPDATE OR INSERT) ON 테이블명
-- [FOR EACH ROW]
-- BEGIN
--      (실행문)
-- END;
-- /

-- 예제. 사원 테이블에 새로운 데이터가 들어오면 '신입사원이 입사하였습니다.'를 출력하기
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, PHONE, JOB_CODE, SAL_LEVEL)
VALUES((SELECT MAX(EMP_ID)+1 FROM EMPLOYEE), '이용자', '000624-3223444', '01028272733', 'J5', 'S5');
-- 트리거 생성 후 지정된 테이블에 명령어를 실행하면 트리거가 동작됨.
-- 신입사원이 입사하였습니다.
-- 1 행 이(가) 삽입되었습니다.


CREATE OR REPLACE TRIGGER TRG_EMP_NEW
AFTER
INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원이 입사하였습니다.');
END;
/
--Trigger TRG_EMP_NEW이(가) 컴파일되었습니다.











