-- view
-- 목록 뽑을 때 속도 저하 때문에 view 만듦
CREATE OR REPLACE VIEW orders_guest_view
as
SELECT o.*, g.GUEST_NAME, g.GUEST_PHONE 
FROM orders o LEFT OUTER JOIN GUEST g ON (o.GUEST_ID = g.GUEST_ID ) ;

CREATE OR REPLACE VIEW OD_guest_HAIR_COUPON_view
AS
SELECT od.*, h.HAIR_NAME, c.EVENT_NAME FROM ORDER_DETAIL od
LEFT OUTER JOIN HAIR h ON (od.HAIR_NO = h.HAIR_NO )
LEFT OUTER JOIN COUPON_VIEW c ON(od.COUPON_ID  = c.COUPON_ID );


-- SELECT
SELECT * FROM orders;
SELECT * FROM ORDER_DETAIL od ;


-- delete
DELETE FROM ORDER_DETAIL od ;
DELETE FROM ORDERS o ;

-- 테이블 컬럼 및 제약조건 변경
ALTER TABLE order_detail ADD od_price NUMBER(6);
ALTER TABLE order_detail ADD od_quantity number(2);
ALTER TABLE order_detail ADD od_discount number(6);
ALTER TABLE coupon MODIFY coupon_id NUMBER;

ALTER TABLE ORDER_DETAIL RENAME COLUMN order_no TO orders_no;
ALTER TABLE ORDER_DETAIL RENAME COLUMN event_no TO coupon_id;
ALTER TABLE orders ADD orders_total_price NUMBER(7);
ALTER TABLE ORDER_DETAIL 
DROP CONSTRAINT FK_ORDER_TO_ORDER_DETAIL;


-- 가짜 조인 이용해서 INSERT
INSERT INTO ORDER_DETAIL(HAIR_NO, OD_PRICE, OD_QUANTITY, COUPON_ID, OD_DISCOUNT);
SELECT HAIR_NO, hair_price, 1, coupon_id, hair_price*event_salerate
FROM (SELECT HAIR_NO, hair_price, 0 AS fake FROM hair WHERE hair_no = 6)
LEFT OUTER JOIN (SELECT coupon_id, event_salerate, 0 AS fake FROM coupon_view WHERE coupon_id = null AND GUEST_ID = 'abcd') USING(fake);


INSERT INTO ORDER_DETAIL(ORDERS_NO, HAIR_NO, OD_PRICE, OD_QUANTITY, COUPON_ID, OD_DISCOUNT)
/*SELECT ?, HAIR_NO, hair_price, ?, coupon_id, hair_price*event_salerate
FROM (SELECT HAIR_NO, hair_price, 0 AS fake FROM hair WHERE hair_no = ?)
LEFT OUTER JOIN (SELECT coupon_id, event_salerate, 0 AS fake FROM coupon_view WHERE event_no = ? AND GUEST_ID = ?) USING(fake);
*/

-- insert 하고 orders_total_price 수정하는 UPDATE
UPDATE ORDERS SET orders_total_price = 40000 WHERE ORDERS_NO = 1;


-- nextVal 돌리기
ALTER SEQUENCE ORDERS_NO_SEQ INCREMENT BY -1;
SELECT ORDERS_NO_SEQ.NEXTVAL FROM DUAL;
ALTER SEQUENCE ORDERS_NO_SEQ INCREMENT BY 1;

SELECT LAST_NUMBER FROM USER_SEQUENCES WHERE SEQUENCE_name = 'ORDERS_NO_SEQ';
w

CREATE OR REPLACE VIEW orders_guest_view
as
SELECT o.*, g.GUEST_NAME, g.GUEST_PHONE 
FROM orders o LEFT OUTER JOIN GUEST g ON (o.GUEST_ID = g.GUEST_ID );

SELECT * FROM designer;


SELECT * FROM coupon WHERE guest_id = 'test' AND USED_YN = 'n' AND SYSDATE BETWEEN EVENT_START AND EVENT_END;