/* 그냥 select문 */
SELECT * FROM GUEST ORDER BY GUEST_JOIN_DATE;
SELECT * FROM HAIR_KIND ORDER BY KIND_NO;
SELECT * FROM HAIR ORDER BY HAIR_NO;
SELECT * FROM DESIGNER ORDER BY DE_NO;
SELECT * FROM EVENT ORDER BY EVENT_NO;
SELECT * FROM BOOKING ORDER BY BOOK_NO;
SELECT * FROM BOOKING_HAIRS ORDER BY BOOK_NO, HAIR_NO;
SELECT * FROM ORDERS ORDER BY ORDERS_NO;
SELECT * FROM ORDER_DETAIL ORDER BY OD_NO;
SELECT * FROM ADMIN ORDER BY ADMIN_ID;
SELECT * FROM HAIR_BOARD ORDER BY HBOARD_NO;
SELECT * FROM HB_CATEGORY ORDER BY HB_CATENO;
SELECT * FROM COUPON ORDER BY COUPON_ID;

SELECT * FROM guest_view;
/* GUEST_VIEW */
-- 회원 전체 목록 뽑기
-- 보안을 위해 비밀번호는 들고 오지 않았는데 뭐가 좋은지는 잘 모르겠음.
CREATE OR REPLACE VIEW GUEST_VIEW
AS
SELECT 
	GUEST_ID, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_EMAIL, GUEST_GENDER, GUEST_JOIN_DATE, GUEST_NOTE, DEL_YN, info_yn
	FROM GUEST;
	
SELECT * FROM guest_view;
SELECT DISTINCT book_no FROM booking_view WHERE guest_id = 'test' AND book_status = '0' ORDER BY book_no DESC;

/* ADMIN_VIEW */
CREATE OR REPLACE VIEW ADMIN_VIEW
AS
SELECT
	ADMIN_ID, ADMIN_NAME 
	FROM ADMIN;

/*QnA_VIEW*/
CREATE OR REPLACE VIEW QNA_VIEW
AS
SELECT
	q.QNA_NO, q.GUEST_ID, q.QNA_TITLE, q.QNA_FILE, q.QNA_REGDATE, q.RES_YN, q.QNA_REFNO 
	FROM QNA q LEFT OUTER JOIN GUEST g ON(g.GUEST_ID = q.GUEST_ID AND g.GUEST_NAME = q.GUEST_NAME);

SELECT * FROM qna_view;


/* EVENT_MIN_VIEW */
-- 예약/주문시 콤보박스로 불러오기 위해 간략하게 조회
-- 쿠폰 테이블 생겨서 수정해야함
CREATE OR REPLACE VIEW EVENT_MIN_VIEW
AS
SELECT EVENT_NO, EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END FROM EVENT;


/* HAIR_VIEW */
SELECT * FROM HAIR_VIEW;
CREATE OR REPLACE VIEW HAIR_VIEW
AS
SELECT KIND_NO, KIND_NAME, HAIR_NO, HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT FROM HAIR LEFT OUTER JOIN HAIR_KIND hk USING(KIND_NO);


/* BOOKING VIEW */
CREATE OR REPLACE VIEW booking_view
AS
SELECT BOOK_NO, GUEST_ID, BOOK_TIME, h.HAIR_NO, h.hair_quantity, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE
FROM booking b LEFT OUTER JOIN booking_hairs h USING(book_no)
ORDER BY book_no, hair_no;

SELECT * FROM booking_view;


/* 생성은 했지만 VIEW 안 쓰고 BOOKING, BOOKING_HAIRS로부터 따로 조회하는 게 좋음 */
CREATE OR REPLACE VIEW booking_hairs_view
AS
SELECT BOOK_NO, h.hair_no, h.hair_name, h.hair_price, h.kind_no, hair_quantity
FROM booking_hairs bh LEFT OUTER JOIN hair h ON bh.hair_no = h.hair_no;

SELECT * FROM BOOKING_HAIRS_view;


/* HB_VIEW (헤어스타일 게시판) */
CREATE OR REPLACE VIEW hb_view
AS
SELECT b.HBOARD_NO, b.HBOARD_CATENO, c.HB_CATENAME, b.HBOARD_TITLE, b.HBOARD_CONTENT, b.HBOARD_PIC, b.HBOARD_REGDATE 
FROM HAIR_BOARD b LEFT OUTER JOIN HB_CATEGORY c ON b.HBOARD_CATENO = c.HB_CATENO ORDER BY b.HBOARD_NO;


/* COUPON_VIEW */
CREATE OR REPLACE VIEW coupon_view
AS
SELECT c.*, NVL(e.EVENT_NAME, '삭제된 이벤트') AS EVENT_NAME, e.EVENT_SALERATE, e.EVENT_STATUS
FROM COUPON c LEFT OUTER JOIN Event e ON (c.EVENT_NO  = e.EVENT_NO );


/* 페이징용 booking */
CREATE OR REPLACE VIEW booking_guest_view AS
SELECT b.*, DE_NICKNAME, DE_NAME, DE_LEVEL, guest_name, guest_phone
FROM booking b
	LEFT OUTER JOIN designer d ON(b.DE_NO = d.DE_NO)
	LEFT OUTER JOIN guest g ON(b.GUEST_ID = g.GUEST_ID);


/* 페이징용 orders */
CREATE OR REPLACE VIEW orders_guest_view
as
SELECT o.*, g.GUEST_NAME, g.GUEST_PHONE 
FROM orders o LEFT OUTER JOIN GUEST g ON (o.GUEST_ID = g.GUEST_ID ) ;

CREATE OR REPLACE VIEW OD_guest_HAIR_COUPON_view
AS
SELECT od.*, h.HAIR_NAME, c.EVENT_NAME FROM ORDER_DETAIL od
LEFT OUTER JOIN HAIR h ON (od.HAIR_NO = h.HAIR_NO )
LEFT OUTER JOIN COUPON_VIEW c ON(od.COUPON_ID  = c.COUPON_ID );

SELECT * FROM od_guest_hair_coupon_view;