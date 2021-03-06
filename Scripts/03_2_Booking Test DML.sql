SELECT * FROM BOOKING_HAIRS;

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
SELECT * FROM hair;
SELECT * FROM booking;
SELECT * FROM booking_hairs;

/*booking data*/
SELECT * FROM BOOKING;
SELECT * FROM BOOKING_HAIRS;
INSERT INTO BOOKING(GUEST_ID, BOOK_TIME, HAIR_NO, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE)
VALUES('test', sysdate + 10 - 6/24, 9, 2, sysdate, 1, null);
INSERT INTO BOOKING(GUEST_ID, BOOK_TIME, HAIR_NO, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE)
VALUES('test', sysdate + 12 - 2/24, 14, 2, sysdate, 1, null);
INSERT INTO BOOKING(GUEST_ID, BOOK_TIME, HAIR_NO, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE)
VALUES('test', sysdate + 10 - 6/24, 9, 2, sysdate, 1, null);

INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(1, 16, 1);
INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(2, 14, 2);
INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(2, 11, 1);
INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(3, 10, 1);
INSERT INTO booking_hairs(book_no, hair_no, hair_quantity) VALUES(3, 12, 2);


/*주문*/
SELECT * FROM orders;
SELECT * FROM ORDER_DETAIL;

/*테스트 admin*/
INSERT INTO ADMIN VALUES ('testadmin','1234','testadmin');


/*notice*/
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT) values('사이트 운영공지','사이트운영방침에 따라 이번년도는 1명의 운영자로 운영할 예정');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT) values('사기 조심','헤어랑을 빙자해서 선예약금 지불 사례발생 조심해주세요.');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT) values('일부 상품 가격 조정','이번년도 물가가 올라서 일부 상품들의 가격이 올라갑니다.');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT) values('사이트 정기정검','11월 10일날 사이트 정기정검을 할 예정입니다.');


/*qna*/
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT) VALUES ('test','로그인이 안된다고 떠요','로그인창에서 로그인을 눌렀는데 자꾸 튕겨요 어떻게 해야해요?');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT) VALUES ('test111','신상품 언제나오나요?','신상품 언제쯤 들어오나요 이번주안에 들어오나요?');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT) VALUES ('abcd','정확한 위치를 모르겠는데','지도를 봐도 정확한 위치를 모르겠는데 따로 안내해주실수있나요?');
INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT) VALUES ('test4321','밤에도 해요?','제가 퇴근시간이 9시인데 밤늦게 까지도 운영하시나요?');

/*qnaNotice*/
INSERT INTO QNA (ADMIN_ID,QNA_TITLE,QNA_CONTENT, notice_yn) VALUES ('testadmin','Q&A문의판 양식','꼭 제목과 내용을 적어주시고 기다려주신다면 빠르시간내에 응답해드리겠습니다', 'y');
INSERT INTO QNA (ADMIN_ID,QNA_TITLE,QNA_CONTENT, notice_yn) VALUES ('testadmin','주의점','헤어랑사이트에서 따로 광고글이나 관련없는 글은 올리면 삭제하도록하겠습니다.', 'y');
INSERT INTO QNA (ADMIN_ID,QNA_TITLE,QNA_CONTENT, notice_yn) VALUES ('testadmin','실시간 문의사항','실시간으로 물어볼게 있으시다면 챗봇을 이용하요 문의해주시기바랍니다.', 'y');

