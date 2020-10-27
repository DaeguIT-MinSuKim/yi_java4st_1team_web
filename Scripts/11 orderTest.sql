SELECT * FROM orders;
SELECT * FROM ORDER_DETAIL od ;

ALTER TABLE order_detail ADD od_price NUMBER(6);
ALTER TABLE order_detail ADD od_quantity number(2);
ALTER TABLE order_detail ADD od_discount number(6);

ALTER TABLE orders ADD orders_total_price NUMBER(7);

SELECT * FROM booking;
SELECT * FROM BOOKING_HAIRS bh ;

INSERT INTO orders(orders_no, guest_id, de_no, orders_total_price, ORDERS_DATE)
VALUES(1, 'test', 1, NULL, sysdate);

INSERT INTO ORDER_DETAIL(OD_NO, ORDER_NO, HAIR_NO, OD_PRICE, OD_QUANTITY, EVENT_NO, OD_DISCOUNT)
values(1, 1, 12, ?, 1, 2, ?);


-- 쿠폰 적용 안 했을 때
INSERT INTO ORDER_DETAIL(OD_NO, ORDER_NO, HAIR_NO, OD_PRICE, OD_QUANTITY)
SELECT 2, 1, HAIR_NO, hair_price, 1
FROM (SELECT HAIR_NO, hair_price FROM hair WHERE hair_no = 12);

-- 쿠폰 적용 했을 때
INSERT INTO ORDER_DETAIL(OD_NO, ORDER_NO, HAIR_NO, OD_PRICE, OD_QUANTITY, EVENT_NO, OD_DISCOUNT)
SELECT 1, 1, HAIR_NO, hair_price, 1, event_no, hair_price*event_salerate
FROM (SELECT HAIR_NO, hair_price FROM hair WHERE hair_no = 12), (SELECT event_no, event_salerate FROM event WHERE event_no = 2);


SELECT * FROM order_detail;
