SHOW USER;
DROP TABLE TB_DEPARTMENT;
DROP TABLE TB_STUDENT;
DROP TABLE TB_CLASS;
DROP TABLE TB_CLASS_PROFESSOR;
DROP TABLE TB_PROFESSOR;
DROP TABLE TB_GRADE;

--------------- 학과 TB_DEPARTMENT ----------------------------
CREATE TABLE TB_DEPARTMENT(
    DEPARTMENT_NO VARCHAR2(10) PRIMARY KEY,
    DEPARTMENT_NAME VARCHAR2(20) NOT NULL,
    CATEGORY VARCHAR2(20),
    OPEN_YN CHAR(1),
    CAPACITY NUMBER
);

COMMENT ON COLUMN TB_DEPARTMENT.DEPARTMENT_NO IS '학과 번호';
COMMENT ON COLUMN TB_DEPARTMENT.DEPARTMENT_NAME IS '학과 이름';
COMMENT ON COLUMN TB_DEPARTMENT.CATEGORY IS '계열';
COMMENT ON COLUMN TB_DEPARTMENT.OPEN_YN IS '개설 여부';
COMMENT ON COLUMN TB_DEPARTMENT.CAPACITY IS '정원';

--------------- 학생 TB_STUDENT ----------------------------
CREATE TABLE TB_STUDENT(
    STUDENT_NO VARCHAR2(10) PRIMARY KEY,
    DEPARTMENT_NO VARCHAR2(10) NOT NULL,
    STUDENT_NAME VARCHAR2(30) NOT NULL,
    STUDENT_SSN VARCHAR2(14),
    STUDENT_ADDRESS VARCHAR2(100),
    ENTRANCE_DATE DATE,
    ABSENCE_YN CHAR(1),
    COACH_PROFESSOR_NO VARCHAR2(10)
)

COMMENT ON COLUMN TB_STUDENT.STUDENT_NO IS '학생 번호';
COMMENT ON COLUMN TB_STUDENT.DEPARTMENT_NO IS '학과 번호';
COMMENT ON COLUMN TB_STUDENT.STUDENT_NAME IS '학생 이름';
COMMENT ON COLUMN TB_STUDENT.STUDENT_SSN IS '학생 주민번호';
COMMENT ON COLUMN TB_STUDENT.STUDENT_ADDRESS IS '학생 주소';
COMMENT ON COLUMN TB_STUDENT.ENTRANCE_DATE IS '입학 일자';
COMMENT ON COLUMN TB_STUDENT.ABSENCE_YN IS '휴학 여부';
COMMENT ON COLUMN TB_STUDENT.COACH_PROFESSOR_NO IS '지도 교수 번호';

--------------- 과목 TB_CLASS ----------------------------
CREATE TABLE TB_CLASS(
    CLASS_NO VARCHAR2(20) PRIMARY KEY,
    DEPARTMENT_NO VARCHAR(10) NOT NULL,
    PREATTENDING_CLASS_NO VARCHAR2(10),
    CLASS_NAME VARCHAR2(30) NOT NULL,
    CLASS_TYPE VARCHAR2(10)    
);

COMMENT ON COLUMN TB_CLASS.CLASS_NO IS '과목 번호';
COMMENT ON COLUMN TB_CLASS.DEPARTMENT_NO IS '학과 번호';
COMMENT ON COLUMN TB_CLASS.PREATTENDING_CLASS_NO IS '선수 과목 번호';
COMMENT ON COLUMN TB_CLASS.CLASS_NAME IS '과목 이름';
COMMENT ON COLUMN TB_CLASS.CLASS_TYPE IS '과목 구분';


--------------- 과목 교수 TB_CLASS_PROFESSOR ----------------------------
CREATE TABLE TB_CLASS_PROFESSOR (
    CLASS_NO VARCHAR2(10) PRIMARY KEY,
    PROFESSOR_NO VARCHAR2(10) PRIMARY KEY
);


--------------- 교수 TB_PROFESSOR ----------------------------
CREATE TABLE TB_PROFESSOR (
    PROFESSOR_NO VARCHAR2(10) PRIMARY KEY,
    PROFESSOR_NAME VARCHAR2(30) NOT NULL,
    PROFESSOR_SSN VARCHAR2(14),
    PROFESSOR_ADDRESS VARCHAR2(100),
    DEPARTMENT_NO VARCHAR2(10) INTEGER TB_DEPARTMENT
);

--------------- 성적 TB_GRADE ----------------------------




==========================================================================

