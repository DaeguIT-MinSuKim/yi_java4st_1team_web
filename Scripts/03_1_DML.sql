--INSERT INTO GUEST(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_EMAIL, GUEST_GENDER, GUEST_NOTE)
--VALUES();
SELECT * FROM BOOKING_HAIRS;

/* TEST용 회원 */
SELECT * FROM GUEST;
INSERT INTO GUEST(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_EMAIL, GUEST_GENDER, GUEST_JOIN_DATE, GUEST_NOTE, DEL_YN, INFO_YN)
VALUES('test', 'tt123', '테스트유저', to_date('19921015', 'YYYYMMDD'), '010-1234-5678', 'test@test.co.kr', 0, sysdate, '머리카락이 약하심', 'n', 'y');
INSERT INTO GUEST(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_EMAIL, GUEST_GENDER, GUEST_JOIN_DATE, GUEST_NOTE, DEL_YN, INFO_YN)
VALUES('abcd', 'efghijk', '에이비', to_date('19960115', 'YYYYMMDD'), '010-1234-5678', 'abcd@test.co.kr', 1, sysdate, null, 'n', 'n');
INSERT INTO GUEST(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_EMAIL, GUEST_GENDER, GUEST_JOIN_DATE, GUEST_NOTE, DEL_YN, INFO_YN)
VALUES('test4321', '43211234', '사삼이', to_date('20001021', 'YYYYMMDD'), '010-1234-5678', 'test4321@test.co.kr', 1, sysdate, '탈모끼 있음', 'n', 'y');

UPDATE guest SET DEL_YN = 'n' WHERE GUEST_ID = 'test';

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
VALUES ('생일', 0.2, NULL, NULL, NULL, '생일로부터 15일 전후 동안만 사용할 수 있습니다.');
INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT)
VALUES ('오픈 기념 쿠폰', 0.1, to_date('2020-09-28', 'YYYY-MM-DD'), to_date('2020-10-15', 'YYYY-MM-DD'), NULL, '오픈 기념 10% 할인 행사');


/* designer */

SELECT * FROM DESIGNER;
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES ('손승완', '웬디', '원장', 'designer/images/wd.jpg','#찰떡스타일링 #정형화되지않은스타일 #얼굴형보완 #내츄럴웨이브 #연예인머리 #컨셉세팅펌');
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES ('배주현', '아이린', '디자이너', 'designer/images/irene.jpg','#내추럴컷 #레이어드컷 #스타일링커트 #루즈컷 #유럽피안컷 #팜므파탈 #손질없이커트만으로멋나는 #얼굴보완컷 #퍼스널컬러디렉팅');
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES ('강슬기', '슬기', '디자이너', 'designer/images/sk.jpg','#클래식 #고급스러움 #단발머리 #단발컷 #풍성한웨이브 #로맨틱웨이브 #드라마틱볼륨 #글램웨이브 #러블리헤어');
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES ('김예림', '예리', '디자이너', 'designer/images/yr.jpg','#단발컷 #태슬컷 #내츄럴웨이브펌 #볼륨레이어컷 #볼륨펌');
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES ('박수영', '조이', '스탭', 'designer/images/joy.jpg','#레이어드컷 #단발레이어드컷 #풍성한볼륨 #볼륨매직 #글램웨이브 #긴머리웨이브 #러블리헤어 ');


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

-- 모든 회원에게 오픈 기념 쿠폰 발행
INSERT INTO coupon(coupon_id, guest_id, event_no, event_start, event_end, used_yn) 
SELECT 1, 'test', event_no, event_start, event_end, 'n' FROM event WHERE event_no = 2;
INSERT INTO coupon(coupon_id, guest_id, event_no, event_start, event_end, used_yn) 
SELECT 2, 'abcd', event_no, event_start, event_end, 'n' FROM event WHERE event_no = 2;
INSERT INTO coupon(coupon_id, guest_id, event_no, event_start, event_end, used_yn) 
SELECT 3, 'test4321', event_no, event_start, event_end, 'n' FROM event WHERE event_no = 2;



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


/*테스트 admin*/
INSERT INTO ADMIN VALUES ('testadmin','1234','testadmin');