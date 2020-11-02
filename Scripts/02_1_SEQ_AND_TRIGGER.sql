-- 트리거 이름 수정했습니다(시퀀스랑 이름 겹치게 잘못 만들었음. 구분 용이하게 변경)
ALTER TRIGGER hair_kind_no_seq RENAME TO HAIR_KIND_NO_TRI;
ALTER TRIGGER HAIR_NO_SEQ RENAME TO HAIR_NO_TRI;
ALTER TRIGGER DESGINER_NO_SEQ RENAME TO DESIGNER_NO_TRI;
ALTER TRIGGER EVENT_NO_SEQ RENAME TO EVENT_NO_TRI;
ALTER TRIGGER BOOK_NO_SEQ RENAME TO BOOK_NO_TRI;
ALTER TRIGGER QNA_NO_SEQ RENAME TO QNA_NO_TRI;

DROP SEQUENCE hair_kind_no_TRI;
DROP SEQUENCE HAIR_NO_TRI;
DROP SEQUENCE DESGINER_NO_TRI;
DROP SEQUENCE EVENT_NO_TRI;
DROP SEQUENCE BOOK_NO_TRI;
DROP SEQUENCE QNA_NO_TRI;
DROP SEQUENCE hboard_no_seq;

DROP SEQUENCE hair_kind_no_SEQ;
DROP SEQUENCE HAIR_NO_SEQ;
DROP SEQUENCE DESGINER_NO_SEQ;
DROP SEQUENCE BOOK_NO_SEQ;
DROP SEQUENCE QNA_NO_SEQ;

DROP SEQUENCE COUPON_ID_SEQ;
DROP SEQUENCE EVENT_NO_SEQ;

DROP SEQUENCE HB_CATENO_SEQ;
DROP SEQUENCE HBOARD_NO_SEQ;


/* 헤어 분류 번호 */
CREATE SEQUENCE HAIR_KIND_NO_SEQ
	START WITH 1
	INCREMENT BY 1
	NOCACHE;

CREATE OR REPLACE TRIGGER HAIR_KIND_NO_TRI
BEFORE INSERT ON HAIR_KIND
FOR EACH ROW 
BEGIN 
	IF Inserting AND :NEW.KIND_NO IS NULL THEN 
		SELECT HAIR_KIND_NO_SEQ.NEXTVAL INTO :NEW.KIND_NO FROM DUAL;
	END IF;
END; 


/* 헤어 번호 */
CREATE SEQUENCE HAIR_NO_SEQ
	START WITH 1
	INCREMENT BY 1
	NOCACHE;

CREATE OR REPLACE TRIGGER HAIR_NO_TRI
BEFORE INSERT ON HAIR
FOR EACH ROW 
BEGIN 
	IF Inserting AND :NEW.HAIR_NO IS NULL THEN 
		SELECT HAIR_NO_SEQ.NEXTVAL INTO :NEW.HAIR_NO FROM DUAL;
	END IF;
END; 


/* 디자이너 번호 */
CREATE SEQUENCE DESGINER_NO_SEQ
	START WITH 1
	INCREMENT BY 1
	NOCACHE;

CREATE OR REPLACE TRIGGER DESGINER_NO_TRI
BEFORE INSERT ON DESIGNER
FOR EACH ROW 
BEGIN 
	IF Inserting AND :NEW.DE_NO IS NULL THEN 
		SELECT DESGINER_NO_SEQ.NEXTVAL INTO :NEW.DE_NO FROM DUAL;
	END IF;
END; 



/* 이벤트 번호 */
CREATE SEQUENCE EVENT_NO_SEQ
	START WITH 1
	INCREMENT BY 1
	NOCACHE;

CREATE OR REPLACE TRIGGER EVENT_NO_TRI
BEFORE INSERT ON EVENT
FOR EACH ROW 
BEGIN 
	IF Inserting AND :NEW.EVENT_NO IS NULL THEN 
		SELECT EVENT_NO_SEQ.NEXTVAL INTO :NEW.EVENT_NO FROM DUAL;
	END IF;
END; 



/* 예약 번호 */
CREATE SEQUENCE BOOK_NO_SEQ
	START WITH 1
	INCREMENT BY 1
	NOCACHE;


CREATE OR REPLACE TRIGGER BOOK_NO_TRI
BEFORE INSERT ON BOOKING
FOR EACH ROW 
BEGIN 
	IF Inserting AND :NEW.BOOK_NO IS NULL THEN 
		SELECT BOOK_NO_SEQ.NEXTVAL INTO :NEW.BOOK_NO FROM DUAL;
	END IF;
END; 


/* 문의 번호 */
CREATE SEQUENCE QNA_NO_SEQ
	START WITH 1
	INCREMENT BY 1
	NOCACHE;

CREATE OR REPLACE TRIGGER QNA_NO_TRI
BEFORE INSERT ON QNA
FOR EACH ROW 
BEGIN 
	IF Inserting AND :NEW.qna_no IS NULL THEN 
		SELECT QNA_NO_SEQ.NEXTVAL INTO :NEW.qna_no FROM DUAL;
	END IF;
END; 


/* 헤어게시판 카테고리 번호 시퀀스 */
CREATE SEQUENCE HB_CATENO_SEQ
	START WITH 1
	INCREMENT BY 1
	NOCACHE;


CREATE OR REPLACE TRIGGER HB_CATENO_TRI
BEFORE INSERT ON HB_CATEGORY
FOR EACH ROW 
BEGIN 
	IF Inserting AND :NEW.HB_CATENO IS NULL THEN 
		SELECT HB_CATENO_SEQ.NEXTVAL INTO :NEW.HB_CATENO FROM DUAL;
	END IF;
END;


SELECT * FROM HAIR_BOARD;
/* 헤어 게시판 */
CREATE SEQUENCE HBOARD_NO_SEQ
	START WITH 1
	INCREMENT BY 1
	NOCACHE;


CREATE OR REPLACE TRIGGER HBOARD_NO_SEQ_TRI
BEFORE INSERT ON HAIR_BOARD
FOR EACH ROW 
BEGIN 
	IF Inserting AND :NEW.HBOARD_NO IS NULL THEN 
		SELECT HBOARD_NO_SEQ.NEXTVAL INTO :NEW.HBOARD_NO FROM DUAL;
	END IF;
END;


/* 쿠폰 트리거 */
CREATE SEQUENCE COUPON_ID_SEQ
	START WITH 1
	INCREMENT BY 1
	NOCACHE;


CREATE OR REPLACE TRIGGER COUPON_ID_TRI
BEFORE INSERT ON COUPON
FOR EACH ROW 
BEGIN 
	IF Inserting AND :NEW.COUPON_ID IS NULL THEN 
		SELECT COUPON_ID_SEQ.NEXTVAL INTO :NEW.COUPON_ID FROM DUAL;
	END IF;
END;

/* 공지 트리거 */
CREATE SEQUENCE NOTICE_ID_SEQ
	START WITH 1
	INCREMENT BY 1
	NOCACHE;

CREATE OR REPLACE TRIGGER NOTICE_ID_SEQ
BEFORE INSERT ON NOTICE
FOR EACH ROW 
BEGIN 
	IF Inserting AND :NEW.NOTICE_NO IS NULL THEN 
		SELECT NOTICE_ID_SEQ.NEXTVAL INTO :NEW.NOTICE_NO FROM DUAL;
	END IF;
END;


/* 주문 시퀀스 트리거 */
DROP SEQUENCE orders_no_seq;
DROP SEQUENCE od_no_seq;
DROP TRIGGER orders_no_tri;

CREATE SEQUENCE ORDERS_NO_SEQ
	START WITH 1
	INCREMENT BY 1
	NOCACHE;

SELECT * FROM USER_TRIGGERS;

/*
CREATE OR REPLACE TRIGGER ORDERS_NO_TRI
BEFORE INSERT ON ORDERS
FOR EACH ROW 
BEGIN 
	IF Inserting AND :NEW.ORDERS_NO IS NULL THEN 
		SELECT ORDERS_NO_SEQ.NEXTVAL INTO :NEW.ORDERS_NO FROM DUAL;
	END IF;
END;
*/


/* 상세 주문 시퀀스 트리거 */
CREATE SEQUENCE OD_NO_SEQ
	START WITH 1
	INCREMENT BY 1
	NOCACHE;

CREATE OR REPLACE TRIGGER OD_NO_SEQ
BEFORE INSERT ON ORDER_DETAIL
FOR EACH ROW 
BEGIN 
	IF Inserting AND :NEW.OD_NO IS NULL THEN 
		SELECT OD_NO_SEQ.NEXTVAL INTO :NEW.OD_NO FROM DUAL;
	END IF;
END;


CREATE OR REPLACE TRIGGER OD_ORDERS_NO_TRI
BEFORE INSERT ON ORDER_DETAIL
FOR EACH ROW
BEGIN 
	IF Inserting AND :NEW.ORDERS_NO IS NULL THEN 
		SELECT LAST_NUMBER-1 INTO :NEW.ORDERS_NO FROM USER_SEQUENCES WHERE SEQUENCE_NAME = 'ORDERS_NO_SEQ';
	END IF;
END;


/* 트리거 테스트 */
/*
CREATE OR REPLACE TRIGGER BOOKING_HAIR_HAIRNO_TRI
BEFORE INSERT ON BOOKING_HAIRS
FOR EACH ROW
BEGIN 
	IF Inserting AND :NEW.BOOK_NO IS NULL THEN 
		SELECT MAX(BOOK_NO) INTO :NEW.BOOK_NO FROM BOOKING;
	END IF;
END;

SELECT * FROM booking;
SELECT * FROM BOOKING_hairs ORDER BY book_no;
*/