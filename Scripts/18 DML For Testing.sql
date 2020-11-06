/* 랜덤 이름 함수 */SELECT * FROM guest;

CREATE OR REPLACE FUNCTION GET_KORNM
(V_FROM IN VARCHAR2,
V_TO IN VARCHAR2)
RETURN VARCHAR2
IS
	OUT_REAL_NM VARCHAR2(100);
	TYPE V_ARR IS TABLE OF VARCHAR2(10);
	V_FIRST V_ARR;
	V_LAST V_ARR;
	V_MID V_ARR; 
BEGIN
	V_LAST:=V_ARR('김','이','박','최','정'
					,'강','조','윤','장','임'
					,'오','한','신','서','권'
					,'황','안','송','유','홍'
					,'전','고','문','손','양'
					,'배','조','백','허','남');
    V_MID:=V_ARR('민','현','동','인','지'
    				,'현','재','우','건','준'
    				,'승','영','성','진','준'
    				,'정','수','광','영','호'
    				,'중','훈','후','우','상'
    				,'연','철','아','윤','은');
    V_FIRST:=V_ARR('유','자','도','성','상'
    				,'남','식','일','철','병'
    				,'혜','영','미','환','식'
    				,'숙','자','희','순','진'
    				,'서','빈','정','지','하'
    				,'연','성','공','안','원');              
    SELECT SUBSTR(V_LAST(ROUND(DBMS_RANDOM.VALUE(1,30),0))||
    				V_MID(ROUND(DBMS_RANDOM.VALUE(1,30),0))||
    				V_FIRST(ROUND(DBMS_RANDOM.VALUE(1,30),0))
    				,V_FROM,V_TO)
    INTO OUT_REAL_NM
   	FROM DUAL;
   	RETURN OUT_REAL_NM;
END;

SELECT get_KORNM('1', '3') FROM dual;

/* 비회원  코드*/
INSERT INTO GUEST(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_EMAIL, GUEST_GENDER, GUEST_JOIN_DATE, GUEST_NOTE, DEL_YN, INFO_YN)
VALUES('nonmember', 'admin', '비회원', NULL, '0', NULL, NULL, NULL, NULL, 'n', 'n');

/* TEST용 회원 */
-- 아이디 test 생일설정
SELECT * FROM GUEST;
INSERT INTO GUEST(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_EMAIL, GUEST_GENDER, GUEST_JOIN_DATE, GUEST_NOTE, DEL_YN, INFO_YN)
VALUES('test', 'tt123', '테스트유저', to_date('19921104', 'YYYYMMDD'), '010-1234-5678', 'test@test.co.kr', 0, sysdate, '머리카락이 약하심', 'n', 'y');
INSERT INTO GUEST(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_EMAIL, GUEST_GENDER, GUEST_JOIN_DATE, GUEST_NOTE, DEL_YN, INFO_YN)
VALUES('abcd', 'efghijk', '에이비', to_date('19960115', 'YYYYMMDD'), '010-1234-5678', 'abcd@test.co.kr', 1, sysdate, null, 'n', 'n');
INSERT INTO GUEST(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_EMAIL, GUEST_GENDER, GUEST_JOIN_DATE, GUEST_NOTE, DEL_YN, INFO_YN)
VALUES('test4321', '43211234', '사삼이', to_date('20001021', 'YYYYMMDD'), '010-1234-5678', 'test4321@test.co.kr', 1, sysdate, '탈모끼 있음', 'n', 'y');
--생일쿠폰 테스트할 고객
--job에 이벤트번호 생일쿠폰으로 수정 / 생일 오늘로 수정해라
--INSERT INTO GUEST(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_EMAIL, GUEST_GENDER, GUEST_JOIN_DATE, GUEST_NOTE, DEL_YN, INFO_YN)
--VALUES('test111', 'tt123', '생일테스트', to_date('19921104', 'YYYYMMDD'), '010-1234-5678', 'test@test.co.kr', 0, sysdate, '머리카락이 약하심', 'n', 'y');

INSERT INTO guest(guest_id, guest_pwd, );
SELECT
	DBMS_RANDOM.STRING('L',  10) guest_id,
	DBMS_RANDOM.STRING('X',  10) guest_pwd,
	TO_DATE(TO_CHAR(DBMS_RANDOM.VALUE(1980,2004), 'FM0000') || TO_CHAR(DBMS_RANDOM.VALUE(1,12), 'FM00') || TO_CHAR(DBMS_RANDOM.VALUE(1,28), 'FM00'), 'YYYY-MM-DD') guest_birthday,
	'010-' || TO_CHAR(DBMS_RANDOM.VALUE(1001,9999), 'FM0000') || '-' ||TO_CHAR(DBMS_RANDOM.VALUE(1001,9999), 'FM0000') AS guest_phone,
	DBMS_RANDOM.STRING('L', 9) || '@' || DBMS_RANDOM.STRING('L', 6) || '.co.kr' guest_email,
	TO_DATE(TO_CHAR(DBMS_RANDOM.VALUE(2016,2020), 'FM0000') || TO_CHAR(DBMS_RANDOM.VALUE(1,12), 'FM00') || TO_CHAR(DBMS_RANDOM.VALUE(1,28), 'FM00'), 'YYYY-MM-DD') guest_join_date,
	CEIL(DBMS_RANDOM.VALUE(0,2)) guest_gender
FROM dual
CONNECT BY LEVEL <= 10;

SELECT 

