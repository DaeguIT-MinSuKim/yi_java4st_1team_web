/*
-- 2016 - 2020 예약일시 랜덤
SELECT TO_DATE(TO_CHAR(DBMS_RANDOM.VALUE(2016,2020), 'FM0000') || '-' || TO_CHAR(DBMS_RANDOM.VALUE(1,12), 'FM00') || '-' || TO_CHAR(DBMS_RANDOM.VALUE(1,28), 'FM00') || ' ' || TO_CHAR(DBMS_RANDOM.VALUE(9,19), 'FM00') || ':' ||  DECODE(CEIL(DBMS_RANDOM.VALUE(0,2)), 1, '00', '30'), 'YYYY-MM-DD hh24:Mi') FROM dual;
*/

/* 1. 비회원  코드*/
INSERT INTO GUEST(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_EMAIL, GUEST_GENDER, GUEST_JOIN_DATE, GUEST_NOTE, DEL_YN, INFO_YN)
VALUES('nonmember', 'admin', '비회원', NULL, '0', NULL, NULL, NULL, NULL, 'n', 'n');

/* 2. TEST용 회원 */
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


/* 3. 랜덤 아이디 */
INSERT INTO guest(guest_id, guest_pwd, guest_name, guest_birthday, guest_phone, guest_email, guest_join_date, guest_gender, DEL_YN)
SELECT
	DBMS_RANDOM.STRING('L',  10) guest_id,
	DBMS_RANDOM.STRING('X',  10) guest_pwd,
	'이헤헤', /*여기만 바꿔서 삽입 해주세요. 동명이인 self */
	TO_DATE(TO_CHAR(DBMS_RANDOM.VALUE(1980,2004), 'FM0000') || TO_CHAR(DBMS_RANDOM.VALUE(1,12), 'FM00') || TO_CHAR(DBMS_RANDOM.VALUE(1,28), 'FM00'), 'YYYY-MM-DD') guest_birthday,
	'010-' || TO_CHAR(DBMS_RANDOM.VALUE(1001,9999), 'FM0000') || '-' ||TO_CHAR(DBMS_RANDOM.VALUE(1001,9999), 'FM0000') AS guest_phone,
	DBMS_RANDOM.STRING('L', 9) || '@' || DBMS_RANDOM.STRING('L', 6) || '.co.kr' guest_email,
	TO_DATE(TO_CHAR(DBMS_RANDOM.VALUE(2016,2020), 'FM0000') || TO_CHAR(DBMS_RANDOM.VALUE(1,12), 'FM00') || TO_CHAR(DBMS_RANDOM.VALUE(1,28), 'FM00'), 'YYYY-MM-DD') guest_join_date,
	CEIL(DBMS_RANDOM.VALUE(0,2)) guest_gender,
	DECODE(CEIL(DBMS_RANDOM.VALUE(0,2)), 1, 'y', 'n') del_yn
FROM dual
CONNECT BY LEVEL <= 10;

				
/* 4. booking_hairs 기존 6건에 200건 삽입 */
INSERT INTO BOOKING_HAIRS(BOOK_NO, HAIR_NO, HAIR_QUANTITY)
SELECT LEVEL+6 AS book_no, ceil(DBMS_RANDOM.VALUE(1, 22)) AS hair_no, ceil(DBMS_RANDOM.VALUE(0, 2)) AS hair_quantity
FROM dual CONNECT BY LEVEL <= 200;


/* 5. booking_hairs에 연결하는 booking 200건 삽입. 유저는 어쩔 수 없음 ㅠㅠ 한 명한테 몰빵... */
INSERT INTO BOOKING(BOOK_NO, GUEST_ID, BOOK_TIME, DE_NO)
SELECT
	LEVEL+6 AS book_no,
	'test' AS guest_id,
	TO_DATE(TO_CHAR(DBMS_RANDOM.VALUE(2016,2020), 'FM0000') || '-' || TO_CHAR(DBMS_RANDOM.VALUE(1,12), 'FM00') || '-' || TO_CHAR(DBMS_RANDOM.VALUE(1,28), 'FM00') || ' ' || TO_CHAR(DBMS_RANDOM.VALUE(9,19), 'FM00') || ':' ||  DECODE(CEIL(DBMS_RANDOM.VALUE(0,2)), 1, '00', '30'), 'YYYY-MM-DD hh24:Mi') AS book_time,
	ceil(DBMS_RANDOM.VALUE(0, 6)) AS de_no
FROM dual CONNECT BY LEVEL <= 200;



/* 6. 주문 넣기. 쿠폰 사용한 데이터는 없음. 헤어 같은 거... ㅠㅠ */
SELECT * FROM order_detail;
INSERT INTO ORDER_DETAIL(ORDERS_NO, HAIR_NO, OD_PRICE, OD_QUANTITY)
	SELECT
		ORDERS_NO,
		HAIR_NO,
		HAIR_PRICE ,
		ceil(DBMS_RANDOM.VALUE(0, 2)) AS od_quantity
	FROM hair, (SELECT level AS ORDERS_NO FROM DUAL CONNECT BY LEVEL <= 10)
	WHERE hair_no = ceil(DBMS_RANDOM.VALUE(0, 22));

SELECT level FROM DUAL CONNECT BY LEVEL <= 10;


INSERT INTO orders(orders_no, guest_id, de_no)
SELECT
	LEVEL AS ORDERS_NO,
	'test',
	ceil(DBMS_RANDOM.VALUE(0, 6)) AS de_no
FROM DUAL CONNECT BY LEVEL <= 10;

