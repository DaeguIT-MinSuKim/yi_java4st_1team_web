--INSERT INTO GUEST(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_EMAIL, GUEST_GENDER, GUEST_NOTE)
--VALUES();
SELECT * FROM BOOKING_HAIRS;

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

SELECT TO_CHAR(DBMS_RANDOM.VALUE(1980,2004), 'FM0000') year, TO_CHAR(DBMS_RANDOM.VALUE(1,12), 'FM00') MONTH, TO_CHAR(DBMS_RANDOM.VALUE(1,28), 'FM00') DAY
FROM dual
CONNECT BY LEVEL <= 10;

/* hair_kind */
SELECT * FROM HAIR_KIND;
INSERT INTO HAIR_KIND(KIND_NAME) VALUES('샴푸');
INSERT INTO HAIR_KIND(KIND_NAME) VALUES('드라이');
INSERT INTO HAIR_KIND(KIND_NAME) VALUES('커트');
INSERT INTO HAIR_KIND(KIND_NAME) VALUES('펌');
INSERT INTO HAIR_KIND(KIND_NAME) VALUES('컬러');
INSERT INTO HAIR_KIND(KIND_NAME) VALUES('클리닉');
INSERT INTO HAIR_KIND(KIND_NAME) VALUES('헤드스파');


/* hair */
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('릴렉싱 샴푸', 15000, NULL, NULL, 1);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('붙임머리 샴푸', 30000, NULL, NULL, 1);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('남성 스타일링', 15000, NULL, NULL, 2);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('블로우 드라이', 30000, NULL, NULL, 2);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('아이롱 드라이', 40000, NULL, NULL, 2);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('붙임머리 드라이', 60000, NULL, NULL, 2);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('앞머리 커트', 5000, NULL, NULL, 3);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('주니어 커트', 10000, NULL, NULL, 3);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('디자인 커트', 20000, NULL, NULL, 3);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('스켈링 커트', 30000, NULL, NULL, 3);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('다운펌', 30000, NULL, NULL, 4);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('앞머리펌/부분펌', 40000, NULL, NULL, 4);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('베이직펌', 80000, NULL, NULL, 4);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('셋팅/디지털펌', 100000, NULL, NULL, 4);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('매직셋팅', 160000, NULL, NULL, 4);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('베이직 염색', 80000, NULL, NULL, 5);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('탈색', 70000, NULL, NULL, 5);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('프리미엄 염색', 100000, NULL, NULL, 5);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('이너 케어', 120000, NULL, NULL, 6);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('인-아웃 케어', 160000, NULL, NULL, 6);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('프리미엄 케어', 200000, NULL, NULL, 6);
INSERT INTO HAIR(HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT, KIND_NO) VALUES('두피 케어', 100000, NULL, NULL, 7);
SELECT * FROM hair;



/* event */
INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT)
VALUES ('생일 쿠폰', 0.2, to_date('2020-11-01','yyyy-MM-dd'),to_date('9999-12-30','yyyy-MM-dd'), 'bd_event.jpg', '고객님의 생일을 축하드립니다. <br>생일 당일 발급되며 생일로부터 14일 이내에 사용가능합니다.');
INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT)
VALUES ('오픈 기념 가입 쿠폰', 0.1, to_date('2020-11-01','yyyy-MM-dd'), to_date('2020-12-01','yyyy-MM-dd'), 'open_event.jpg', '가입한 날짜로부터 30일 이내에 사용가능합니다.');


SELECT * FROM BOOKING;

--생일인 사람 쿠폰 수동 삽입
-- INSERT INTO COUPON(guest_id, EVENT_NO, EVENT_START, EVENT_END)
--		SELECT guest_id, 1/*이벤트번호*/, "thisyear_bd" AS event_start, "thisyear_bd" + 14 - 1 / (24*60*60) + 1 AS event_end
--		FROM (
--		SELECT guest_id, guest_birthday, TO_DATE(TO_CHAR(sysdate, 'YYYY-') || TO_CHAR(GUEST_BIRTHDAY, 'MM-DD')) AS "thisyear_bd", 1 AS fake FROM guest g
--		) gb WHERE TO_CHAR(sysdate, 'YYYY-MM-DD') = TO_CHAR("thisyear_bd", 'YYYY-MM-DD');


SELECT * FROM event;
-- 모든 테스트 회원에게 오픈 기념 쿠폰 발행 -> 가입시 자동했음
INSERT INTO coupon(guest_id, event_no, event_start, event_end) 
SELECT 'test', event_no ,sysdate, to_date(to_char(sysdate, 'yyyy-MM-dd')) + 30 - 1 / (24*60*60) + 1 FROM event WHERE event_no = 2;
INSERT INTO coupon(guest_id, event_no, event_start, event_end) 
SELECT 'test4321', event_no ,sysdate, to_date(to_char(sysdate, 'yyyy-MM-dd')) + 30 - 1 / (24*60*60) + 1 FROM event WHERE event_no = 2;
INSERT INTO coupon(guest_id, event_no, event_start, event_end) 
SELECT 'abcd', event_no ,sysdate, to_date(to_char(sysdate, 'yyyy-MM-dd')) + 30 - 1 / (24*60*60) + 1 FROM event WHERE event_no = 2;

/* designer */

SELECT * FROM DESIGNER;
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES ('손승완', '웬디', '원장', 'designer/images/wd.jpg','#찰떡스타일링 #정형화되지않은스타일 #얼굴형보완 #내츄럴웨이브 #연예인머리 #컨셉세팅펌');
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES ('강슬기', '슬기', '디자이너', 'designer/images/sk.jpg','#클래식 #고급스러움 #단발머리 #단발컷 #풍성한웨이브 #로맨틱웨이브 #드라마틱볼륨 #글램웨이브 #러블리헤어');
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES ('김예림', '예리', '디자이너', 'designer/images/yr.jpg','#단발컷 #태슬컷 #내츄럴웨이브펌 #볼륨레이어컷 #볼륨펌');
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES ('박수영', '조이', '디자이너', 'designer/images/joy.jpg','#레이어드컷 #단발레이어드컷 #풍성한볼륨 #볼륨매직 #글램웨이브 #긴머리웨이브 #러블리헤어 ');
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES ('신유나', '유나', '스탭', 'designer/images/yn.jpg','#내추럴컷 #레이어드컷 #스타일링커트 #루즈컷 #유럽피안컷 #팜므파탈 #손질없이커트만으로멋나는 #얼굴보완컷 #퍼스널컬러디렉팅');
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES ('신류진', '류진', '스탭', 'designer/images/rj.jpg','#단발머리 #다채로운단발스타일링 #디자인컷 #커트만으로멋나는단발 #남자컷 #연예인컷 #연예인염색');


/* coupon */
SELECT * FROM event;
SELECT * FROM coupon ORDER BY COUPON_ID;


/*HB_CATEGORY*/
SELECT * FROM HB_CATEGORY;
INSERT INTO HB_CATEGORY(HB_CATENAME) VALUES ('숏헤어');
INSERT INTO HB_CATEGORY(HB_CATENAME) VALUES ('미디움헤어');
INSERT INTO HB_CATEGORY(HB_CATENAME) VALUES ('롱헤어');
INSERT INTO HB_CATEGORY(HB_CATENAME) VALUES ('맨헤어');



/* hair_board*/
SELECT * FROM HAIR_BOARD;
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (1,'s1', NULL, 'hair/images/1-1.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (1,'s2', NULL, 'hair/images/1-2.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (1,'s3', NULL, 'hair/images/1-3.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (1,'s4', NULL, 'hair/images/1-4.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (1,'s5', NULL, 'hair/images/1-5.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (1,'s5', NULL, 'hair/images/1-6.jpg', sysdate);

INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (2,'m1', NULL, 'hair/images/2-1.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (2,'m2', NULL, 'hair/images/2-2.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (2,'m3', NULL, 'hair/images/2-3.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (2,'m4', NULL, 'hair/images/2-4.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (2,'m5', NULL, 'hair/images/2-5.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (2,'m6', NULL, 'hair/images/2-6.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (2,'m7', NULL, 'hair/images/2-7.jpg', sysdate);

INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (3,'l1', NULL, 'hair/images/3-1.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (3,'l2', NULL, 'hair/images/3-2.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (3,'l3', NULL, 'hair/images/3-3.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (3,'l4', NULL, 'hair/images/3-4.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (3,'l5', NULL, 'hair/images/3-5.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (3,'l6', NULL, 'hair/images/3-6.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (3,'l7', NULL, 'hair/images/3-7.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (3,'l8', NULL, 'hair/images/3-8.jpg', sysdate);

INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (4,'m1', NULL, 'hair/images/4-1.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (4,'m2', NULL, 'hair/images/4-2.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (4,'m3', NULL, 'hair/images/4-3.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (4,'m4', NULL, 'hair/images/4-4.jpg', sysdate);
INSERT INTO HAIR_BOARD (HBOARD_CATENO, HBOARD_TITLE,HBOARD_CONTENT,HBOARD_PIC,HBOARD_REGDATE) VALUES (4,'m5', NULL, 'hair/images/4-5.jpg', sysdate);



/* hair_board */
SELECT * FROM HAIR_BOARD;


/* booking & booking_hairs */
-- test용으로 시퀀스 사용하지 않고 60번부터 시작하는 데이터 삽입
SELECT * FROM hair;
SELECT * FROM booking;
SELECT * FROM booking_hairs;
/*

INSERT INTO BOOKING(BOOK_NO, GUEST_ID, BOOK_TIME, HAIR_NO, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE)
VALUES(60, 'test', sysdate + 10 - 6/24, 9, 2, sysdate, 1, null);
INSERT INTO BOOKING(BOOK_NO, GUEST_ID, BOOK_TIME, HAIR_NO, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE)
VALUES(61, 'test4321', sysdate + 12 - 2/24, 14, 2, sysdate, 1, null);
INSERT INTO BOOKING(BOOK_NO, GUEST_ID, BOOK_TIME, HAIR_NO, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE)
VALUES(62, 'test', sysdate + 10 - 6/24, 9, 2, sysdate, 1, null);

INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(60, 16, 1);
INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(60, 14, 2);
INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(61, 11, 1);
INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(62, 10, 1);
INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(62, 12, 2);
*/

/*booking data*/
SELECT * FROM BOOKING ORDER BY BOOK_NO;
SELECT * FROM BOOKING_HAIRS ORDER BY BOOK_NO;
INSERT INTO BOOKING(GUEST_ID, BOOK_TIME, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE)
VALUES('test', sysdate + 2 - 6/24, 2, sysdate, 1, null);
INSERT INTO BOOKING(GUEST_ID, BOOK_TIME, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE)
VALUES('abcd', sysdate + 1 - 2/24, 2, sysdate, 1, null);
INSERT INTO BOOKING(GUEST_ID, BOOK_TIME, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE)
VALUES('test4321', sysdate + 1 - 6/24, 2, sysdate, 1, null);

INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(1, 16, 1);
INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(2, 14, 2);
INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(2, 11, 1);
INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(3, 10, 1);
INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(3, 12, 2);


INSERT INTO BOOKING(GUEST_ID, BOOK_TIME, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE)
VALUES('test', sysdate + 2 - 6/24, 2, sysdate, 1, null);
INSERT INTO BOOKING(GUEST_ID, BOOK_TIME, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE)
VALUES('test', sysdate + 2 - 6/24, 2, sysdate, 1, null);
INSERT INTO BOOKING(GUEST_ID, BOOK_TIME, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE)
VALUES('test', sysdate + 2 - 6/24, 2, sysdate, 1, null);
INSERT INTO BOOKING(GUEST_ID, BOOK_TIME, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE)
VALUES('test', sysdate + 2 - 6/24, 2, sysdate, 1, null);
INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(5, 16, 1);
INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(5, 14, 2);
INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(6, 11, 1);
INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(6, 10, 1);
INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(7, 12, 2);
INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(12, 12, 2);
INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(13, 15, 2);
INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(14, 16, 2);

/*주문*/
SELECT * FROM orders;
SELECT * FROM ORDER_DETAIL;

/*테스트 admin*/
INSERT INTO ADMIN VALUES ('testadmin','1234','testadmin');

/*notice*/
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT) values('사이트 운영공지','사이트운영방침에 따라 이번년도는 1명의 운영자로 운영할 예정');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT) values('사기 조심','헤어랑을 빙자해서 선예약금 지불 사례발생 조심해주세요.');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT) values('일부 상품 가격 조정','이번년도 물가가 올라서 일부 상품들의 가격이 올라갑니다.');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT) values('사이트 11월1일정기정검',' 사이트 정기정검을 할 예정입니다.');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT) values('사이트 11월 5일정기정검',' 사이트 정기정검을 할 예정입니다.');

INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT,NOTICE_REGDATE,NOTICE_DELYN ) values('사이트 10월 15일정기정검',' 사이트 정기정검을 할 예정입니다.','2020-10-15','y');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT,NOTICE_REGDATE,NOTICE_DELYN ) values('사이트 10월 3일정기정검',' 사이트 정기정검을 할 예정입니다.','2020-10-03','y');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT,NOTICE_REGDATE,NOTICE_DELYN ) values('사이트 9월 26일정기정검',' 사이트 정기정검을 할 예정입니다.','2020-09-26','y');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT,NOTICE_REGDATE,NOTICE_DELYN ) values('사이트 9월 3일정기정검',' 사이트 정기정검을 할 예정입니다.','2020-09-03','y');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT,NOTICE_REGDATE,NOTICE_DELYN ) values('사이트 9월 1일정기정검',' 사이트 정기정검을 할 예정입니다.','2020-09-01','y');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT,NOTICE_REGDATE,NOTICE_DELYN ) values('사이트 5월 3일정기정검',' 사이트 정기정검을 할 예정입니다.','2020-05-03','y');

INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT,NOTICE_REGDATE,NOTICE_DELYN ) values('사이트 12월 1일정기정검',' 사이트 정기정검을 할 예정입니다.','2019-12-01','y');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT,NOTICE_REGDATE,NOTICE_DELYN ) values('사이트 11월 4일정기정검',' 사이트 정기정검을 할 예정입니다.','2019-11-04','y');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT,NOTICE_REGDATE,NOTICE_DELYN ) values('사이트 10월 24일정기정검',' 사이트 정기정검을 할 예정입니다.','2019-10-24','y');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT,NOTICE_REGDATE,NOTICE_DELYN ) values('사이트 5월 7일정기정검',' 사이트 정기정검을 할 예정입니다.','2019-05-07','y');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT,NOTICE_REGDATE,NOTICE_DELYN ) values('사이트 3월 1일정기정검',' 사이트 정기정검을 할 예정입니다.','2019-03-01','y');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT,NOTICE_REGDATE,NOTICE_DELYN ) values('사이트 1월 1일정기정검',' 사이트 정기정검을 할 예정입니다.','2019-01-01','y');

INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT,NOTICE_REGDATE,NOTICE_DELYN ) values('사이트 12월 20일정기정검',' 사이트 정기정검을 할 예정입니다.','2018-12-20','y');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT,NOTICE_REGDATE,NOTICE_DELYN ) values('사이트 11월 15일정기정검',' 사이트 정기정검을 할 예정입니다.','2018-11-15','y');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT,NOTICE_REGDATE,NOTICE_DELYN ) values('사이트 6월 5일정기정검',' 사이트 정기정검을 할 예정입니다.','2018-06-05','y');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT,NOTICE_REGDATE,NOTICE_DELYN ) values('사이트 3월 1일정기정검',' 사이트 정기정검을 할 예정입니다.','2018-03-01','y');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT,NOTICE_REGDATE,NOTICE_DELYN ) values('사이트 4월 24일정기정검',' 사이트 정기정검을 할 예정입니다.','2018-04-24','y');


/*qna*/
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT) VALUES ('test','로그인이 안된다고 떠요','로그인창에서 로그인을 눌렀는데 자꾸 튕겨요 어떻게 해야해요?');
--INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT) VALUES ('test111','신상품 언제나오나요?','신상품 언제쯤 들어오나요 이번주안에 들어오나요?');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT) VALUES ('abcd','정확한 위치를 모르겠는데','지도를 봐도 정확한 위치를 모르겠는데 따로 안내해주실수있나요?');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT ) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2020-11-13','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2020-10-1','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ,RES_YN ) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2020-09-13','y','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2020-1-13','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ,RES_YN) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2020-1-13','y','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ,RES_YN) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2020-1-13','y','y');

INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2019-3-13','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2019-4-13','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2019-5-13','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2019-7-13','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ,RES_YN) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2019-2-13','y','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ,RES_YN,QNA_SECRET) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2019-12-13','y','y','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ,RES_YN,QNA_SECRET) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2019-10-13','y','y','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ,RES_YN,QNA_SECRET) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2019-1-13','y','y','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ,RES_YN,QNA_SECRET) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2019-12-13','y','y','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ,RES_YN,QNA_SECRET) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2019-5-13','y','y','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ,RES_YN,QNA_SECRET) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2019-1-13','y','y','y');

INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN,QNA_SECRET ) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2018-1-13','y','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN,QNA_SECRET ) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2018-3-13','y','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ,QNA_SECRET) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2018-1-13','y','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN,QNA_SECRET ) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2018-5-13','y','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2018-5-13','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2018-1-13','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2018-2-13','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2018-12-13','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2018-11-13','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2018-10-13','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2018-2-13','y');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,QNA_REGDATE,DEL_YN ,RES_YN) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운여하시나요?','2018-1-13','y','y');

/*qnaNotice*/
INSERT INTO QNA (ADMIN_ID,QNA_TITLE,QNA_CONTENT, notice_yn) VALUES ('testadmin','Q&A문의판 양식','꼭 제목과 내용을 적어주시고 기다려주신다면 빠르시간내에 응답해드리겠습니다', 'y');
INSERT INTO QNA (ADMIN_ID,QNA_TITLE,QNA_CONTENT, notice_yn) VALUES ('testadmin','주의점','헤어랑사이트에서 따로 광고글이나 관련없는 글은 올리면 삭제하도록하겠습니다.', 'y');
INSERT INTO QNA (ADMIN_ID,QNA_TITLE,QNA_CONTENT, notice_yn) VALUES ('testadmin','실시간 문의사항','실시간으로 물어볼게 있으시다면 챗봇을 이용하요 문의해주시기바랍니다.', 'y');

INSERT INTO QNA (ADMIN_ID,QNA_TITLE,QNA_CONTENT, notice_yn,QNA_REGDATE ,DEL_YN ) VALUES ('testadmin','Q&A문의판 양식','꼭 제목과 내용을 적어주시고 기다려주신다면 빠르시간내에 응답해드리겠습니다', 'y','2020-08-02','y');
INSERT INTO QNA (ADMIN_ID,QNA_TITLE,QNA_CONTENT, notice_yn,QNA_REGDATE ,DEL_YN ) VALUES ('testadmin','Q&A문의판 양식','꼭 제목과 내용을 적어주시고 기다려주신다면 빠르시간내에 응답해드리겠습니다', 'y','2020-07-02','y');
INSERT INTO QNA (ADMIN_ID,QNA_TITLE,QNA_CONTENT, notice_yn,QNA_REGDATE ,DEL_YN ) VALUES ('testadmin','Q&A문의판 양식','꼭 제목과 내용을 적어주시고 기다려주신다면 빠르시간내에 응답해드리겠습니다', 'y','2020-04-02','y');
INSERT INTO QNA (ADMIN_ID,QNA_TITLE,QNA_CONTENT, notice_yn,QNA_REGDATE ,DEL_YN ) VALUES ('testadmin','Q&A문의판 양식','꼭 제목과 내용을 적어주시고 기다려주신다면 빠르시간내에 응답해드리겠습니다', 'y','2020-01-02','y');

INSERT INTO QNA (ADMIN_ID,QNA_TITLE,QNA_CONTENT, notice_yn,QNA_REGDATE ,DEL_YN ) VALUES ('testadmin','Q&A문의판 양식','꼭 제목과 내용을 적어주시고 기다려주신다면 빠르시간내에 응답해드리겠습니다', 'y','2019-08-02','y');
INSERT INTO QNA (ADMIN_ID,QNA_TITLE,QNA_CONTENT, notice_yn,QNA_REGDATE ,DEL_YN ) VALUES ('testadmin','Q&A문의판 양식','꼭 제목과 내용을 적어주시고 기다려주신다면 빠르시간내에 응답해드리겠습니다', 'y','2019-07-02','y');
INSERT INTO QNA (ADMIN_ID,QNA_TITLE,QNA_CONTENT, notice_yn,QNA_REGDATE ,DEL_YN ) VALUES ('testadmin','Q&A문의판 양식','꼭 제목과 내용을 적어주시고 기다려주신다면 빠르시간내에 응답해드리겠습니다', 'y','2019-04-02','y');
INSERT INTO QNA (ADMIN_ID,QNA_TITLE,QNA_CONTENT, notice_yn,QNA_REGDATE ,DEL_YN ) VALUES ('testadmin','Q&A문의판 양식','꼭 제목과 내용을 적어주시고 기다려주신다면 빠르시간내에 응답해드리겠습니다', 'y','2019-01-02','y');

INSERT INTO QNA (ADMIN_ID,QNA_TITLE,QNA_CONTENT, notice_yn,QNA_REGDATE ,DEL_YN ) VALUES ('testadmin','Q&A문의판 양식','꼭 제목과 내용을 적어주시고 기다려주신다면 빠르시간내에 응답해드리겠습니다', 'y','2018-08-02','y');
INSERT INTO QNA (ADMIN_ID,QNA_TITLE,QNA_CONTENT, notice_yn,QNA_REGDATE ,DEL_YN ) VALUES ('testadmin','Q&A문의판 양식','꼭 제목과 내용을 적어주시고 기다려주신다면 빠르시간내에 응답해드리겠습니다', 'y','2018-07-02','y');
INSERT INTO QNA (ADMIN_ID,QNA_TITLE,QNA_CONTENT, notice_yn,QNA_REGDATE ,DEL_YN ) VALUES ('testadmin','Q&A문의판 양식','꼭 제목과 내용을 적어주시고 기다려주신다면 빠르시간내에 응답해드리겠습니다', 'y','2018-04-02','y');
INSERT INTO QNA (ADMIN_ID,QNA_TITLE,QNA_CONTENT, notice_yn,QNA_REGDATE ,DEL_YN ) VALUES ('testadmin','Q&A문의판 양식','꼭 제목과 내용을 적어주시고 기다려주신다면 빠르시간내에 응답해드리겠습니다', 'y','2018-01-02','y');
