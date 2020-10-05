/* 그냥 select문 */
SELECT * FROM GUEST ORDER BY GUEST_JOIN_DATE;
SELECT * FROM HAIR_KIND ORDER BY KIND_NO;
SELECT * FROM HAIR ORDER BY HAIR_NO;
SELECT * FROM DESIGNER ORDER BY DE_NO;
SELECT * FROM EVENT ORDER BY EVENT_NO;
SELECT * FROM BOOKING ORDER BY BOOK_NO;
SELECT * FROM ORDERS ORDER BY ORDERS_NO;
SELECT * FROM ORDER_DETAIL ORDER BY OD_NO;
SELECT * FROM ADMIN ORDER BY ADMIN_ID;


/* GUEST_VIEW */
-- 회원 전체 목록 뽑기
-- 보안을 위해 비밀번호는 들고 오지 않았는데 뭐가 좋은지는 잘 모르겠음.
CREATE OR REPLACE VIEW GUEST_VIEW
AS
SELECT 
	GUEST_ID, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_GENDER, GUEST_JOIN_DATE, GUEST_NOTE, DEL_YN
	FROM GUEST;
	
SELECT * FROM guest_view;

/* ADMIN_VIEW */
CREATE OR REPLACE VIEW ADMIN_VIEW
AS
SELECT
	ADMIN_ID, ADMIN_PWD, ADMIN_NAME 
	FROM ADMIN;

/*QnA_VIEW*/
CREATE OR REPLACE VIEW QNA_VIEW
AS
SELECT
	q.QNA_NO, q.GUEST_ID, q.QNA_TITLE, q.QNA_FILE, q.QNA_REGDATE, q.RES_YN
	FROM QNA q JOIN GUEST g ON(g.GUEST_ID = q.GUEST_ID );

SELECT * FROM qna_view;


/* EVENT_MIN_VIEW */
-- 예약/주문시 콤보박스로 불러오기 위해 간략하게 조회
CREATE OR REPLACE VIEW EVENT_MIN_VIEW
AS
SELECT EVENT_NO, EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END FROM EVENT;


/* HAIR_VIEW */
SELECT * FROM HAIR_VIEW;
CREATE OR REPLACE VIEW HAIR_VIEW
AS
SELECT KIND_NO, KIND_NAME, HAIR_NO, HAIR_NAME, HAIR_PRICE, HAIR_PIC, HAIR_CONTENT FROM HAIR LEFT OUTER JOIN HAIR_KIND hk USING(KIND_NO);