-- SELECT
SELECT * FROM orders;
SELECT * FROM ORDER_DETAIL od ORDER BY ORDERS_NO, COUPON_ID, OD_NO;
SELECT * FROM event;
SELECT * FROM booking;
UPDATE booking SET book_status = 1 WHERE book_status = 2;

-- delete
DELETE FROM ORDER_DETAIL od ;
DELETE FROM ORDERS o ;

-- 테이블 컬럼 및 제약조건 변경
ALTER TABLE order_detail ADD od_price NUMBER(6);
ALTER TABLE order_detail ADD od_quantity number(2);
ALTER TABLE order_detail ADD od_discount number(6);
ALTER TABLE coupon MODIFY coupon_id NUMBER;

ALTER TABLE orders ADD orders_total_price NUMBER(7);

ALTER TABLE ORDER_DETAIL 
DROP CONSTRAINT FK_ORDER_TO_ORDER_DETAIL;


-- 가짜 조인 이용해서 INSERT
INSERT INTO ORDER_DETAIL( HAIR_NO, OD_PRICE, OD_QUANTITY, COUPON_ID, OD_DISCOUNT);
SELECT HAIR_NO, hair_price, 1, coupon_id, hair_price*event_salerate
FROM (SELECT HAIR_NO, hair_price, 0 AS fake FROM hair WHERE hair_no = 6)
LEFT OUTER JOIN (SELECT coupon_id, event_salerate, 0 AS fake FROM coupon_view WHERE coupon_id = 2 AND GUEST_ID = 'abcd') USING(fake);

/*
INSERT INTO ORDER_DETAIL(ORDERS_NO, HAIR_NO, OD_PRICE, OD_QUANTITY, COUPON_ID, OD_DISCOUNT)
SELECT ?, HAIR_NO, hair_price, ?, coupon_id, hair_price*event_salerate
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
