SELECT * FROM orders;
SELECT * FROM ORDER_DETAIL od ;

ALTER TABLE order_detail ADD od_price NUMBER(6);
ALTER TABLE order_detail ADD od_quantity number(2);
ALTER TABLE order_detail ADD od_discount number(6);
ALTER TABLE coupon MODIFY coupon_id NUMBER;

ALTER TABLE orders ADD orders_total_price NUMBER(7);

SELECT * FROM booking;
SELECT * FROM BOOKING_HAIRS bh ;

INSERT INTO orders(orders_no, guest_id, de_no, orders_total_price, ORDERS_DATE)
VALUES(1, 'test', 1, NULL, sysdate);

INSERT INTO ORDER_DETAIL(OD_NO, ORDERS_NO, HAIR_NO, OD_PRICE, OD_QUANTITY, COUPON_ID, OD_DISCOUNT)
values(1, 1, 12, ?, 1, 2, ?);


-- 쿠폰 적용 안 했을 때
INSERT INTO ORDER_DETAIL(OD_NO, ORDERS_NO, HAIR_NO, OD_PRICE, OD_QUANTITY)
SELECT 1, 1, HAIR_NO, hair_price, 1
FROM (SELECT HAIR_NO, hair_price FROM hair WHERE hair_no = 12);

-- 쿠폰 적용 했을 때
INSERT INTO ORDER_DETAIL(OD_NO, ORDERS_NO, HAIR_NO, OD_PRICE, OD_QUANTITY, EVENT_NO, OD_DISCOUNT)
SELECT 1, 1, HAIR_NO, hair_price, 1, event_no, hair_price*event_salerate
FROM (SELECT HAIR_NO, hair_price FROM hair WHERE hair_no = 12), (SELECT coupon_id, event_salerate FROM coupon_view WHERE event_no = 2);

UPDATE ORDERS SET orders_total_price = 40000 WHERE ORDERS_NO = 1;


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


ALTER TABLE ORDER_DETAIL 
DROP CONSTRAINT FK_ORDER_TO_ORDER_DETAIL;

