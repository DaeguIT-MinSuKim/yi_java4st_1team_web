--INSERT INTO GUEST(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_EMAIL, GUEST_GENDER, GUEST_NOTE)
--VALUES();

/* TEST용 회원 */
SELECT * FROM GUEST;
INSERT INTO GUEST(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_EMAIL, GUEST_GENDER, GUEST_JOIN_DATE, GUEST_NOTE, DEL_YN, INFO_YN)
VALUES('test', 'tt123', '테스트유저', to_date('19921015', 'YYYYMMDD'), '010-1234-5678', 'test@test.co.kr', 2, sysdate, '머리카락이 약하심', 'n', 'y');
INSERT INTO GUEST(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_EMAIL, GUEST_GENDER, GUEST_JOIN_DATE, GUEST_NOTE, DEL_YN, INFO_YN)
VALUES('abcd', 'efghijk', '에이비', to_date('19960115', 'YYYYMMDD'), '010-1234-5678', 'abcd@test.co.kr', 2, sysdate, null, 'n', 'n');
INSERT INTO GUEST(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_EMAIL, GUEST_GENDER, GUEST_JOIN_DATE, GUEST_NOTE, DEL_YN, INFO_YN)
VALUES('test4321', '43211234', '사삼이', to_date('20001021', 'YYYYMMDD'), '010-1234-5678', 'test4321@test.co.kr', 1, sysdate, '탈모끼 있음', 'n', 'y');



/* hair_kind */
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

/* event */
INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT)
VALUES ('생일', 0.2, NULL, NULL, NULL, '생일로부터 15일 전후 동안만 사용할 수 있습니다.');
INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT)
VALUES ('오픈 기념 쿠폰', 0.1, to_date('2020-09-28', 'YYYY-MM-DD'), to_date('2020-10-15', 'YYYY-MM-DD'), NULL, '오픈 기념 10% 할인 행사');


/* designer */
SELECT * FROM DESIGNER;
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES('박원장', '원', '원장', NULL, '20년 경력을 자랑하는 헤어랑의 원장');
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES('배주현', '아이린', '디자이너', NULL, '펌의 신');
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES('강슬기', '슬기', '디자이너', NULL, '5년차');
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES('김미정', '노넴', '스탭', NULL, '2년차');
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES('이스탭', '수태', '스탭', NULL, '펌 전문가');


/* coupon */
SELECT * FROM event;
SELECT * FROM coupon;

-- 모든 회원에게 오픈 기념 쿠폰 발행
INSERT INTO coupon(coupon_id, guest_id, event_no, event_start, event_end, use_yn) 
SELECT 1, 'test', event_no, event_start, event_end, 'n' FROM event WHERE event_no = 2;
INSERT INTO coupon(coupon_id, guest_id, event_no, event_start, event_end, use_yn) 
SELECT 2, 'abcd', event_no, event_start, event_end, 'n' FROM event WHERE event_no = 2;
INSERT INTO coupon(coupon_id, guest_id, event_no, event_start, event_end, use_yn) 
SELECT 3, 'test4321', event_no, event_start, event_end, 'n' FROM event WHERE event_no = 2;



/* booking & booking_hairs */
-- test용으로 시퀀스 사용하지 않고 60번부터 시작하는 데이터 삽입
SELECT * FROM booking;
INSERT INTO BOOKING(BOOK_NO, GUEST_ID, BOOK_TIME, HAIR_NO, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE)
VALUES(60, 'test', sysdate + 10 - 6/24, 2, sysdate, 1, null);
INSERT INTO BOOKING(BOOK_NO, GUEST_ID, BOOK_TIME, HAIR_NO, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE)
VALUES(61, 'test4321', sysdate + 12 - 2/24, 2, sysdate, 1, null);

INSERT INTO booking_hairs(book_no, hair_no) VALUES(60, 16);
INSERT INTO booking_hairs(book_no, hair_no) VALUES(60, 14);
INSERT INTO booking_hairs(book_no, hair_no) VALUES(61, 11);

