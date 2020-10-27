SELECT COUPON_ID,GUEST_ID,EVENT_NO,EVENT_START,EVENT_END,USED_YN FROM coupon WHERE GUEST_ID = 'chini91';
SELECT * FROM event;

SELECT * FROM COUPON ORDER BY COUPON_ID desc;

SELECT * FROM coupon_view
--쿠폰확인
SELECT c.COUPON_ID, c.GUEST_ID, e.EVENT_NO, e.EVENT_NAME, e.EVENT_START, e.EVENT_END, e.USE_YN AS event_useYn, c.USED_YN 
FROM COUPON c 
LEFT JOIN event e ON c.event_no = e.event_no WHERE c.GUEST_ID = 'chini91';


--쿠폰 넣기
INSERT INTO coupon(coupon_id, guest_id, event_no, event_start, event_end, used_yn) 
SELECT 14, 'test4', event_no, event_start, event_end, 'n' FROM event WHERE event_no = 2;

INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT)
VALUES ('오픈 기념 쿠폰', 0.1, to_date('2020-09-28', 'YYYY-MM-DD'), to_date('2020-10-15', 'YYYY-MM-DD'), NULL, '오픈 기념 10% 할인 행사');

UPDATE event SET USE_YN = 'n' WHERE EVENT_NO = 5;

--생일쿠폰 -> start: 생일로부터 15일전 end: 생일로부터 15일 후 

SELECT * FROM COUPON WHERE GUEST_ID = 'chini91';

SELECT guest_birthday -15, guest_birthday + 15  FROM GUEST WHERE GUEST_ID = 'chini91';

SELECT guest_birthday, substr(GUEST_BIRTHDAY,4),   FROM GUEST WHERE GUEST_ID = 'chini91';

SELECT to_char(sysdate,'yyyy-') || to_char(guest_birthday ,'MM-dd') AS today,
to_date(to_char(sysdate,'yyyy-') || to_char(guest_birthday - 15 ,'MM-dd')) AS START_date,
to_date(to_char(sysdate,'yyyy-') || to_char(guest_birthday + 15 ,'MM-dd')) AS END_date
FROM guest WHERE GUEST_ID = 'chini91';

SELECT to_char(sysdate,'yyyy-') || to_char(guest_birthday ,'MM-dd') AS today+15 FROM dual, guest WHERE GUEST_ID = 'chini91';


--지수
INSERT INTO coupon(COUPON_ID, guest_id, event_no, event_start, event_end) 
SELECT 4, 'test', event_no, TO_DATE(TO_CHAR(sysdate, 'YYYY-') || TO_CHAR(guest_birthday - 15, 'MM-DD')) AS START_date,
   TO_DATE(TO_CHAR(sysdate, 'YYYY-') || TO_CHAR(guest_birthday + 15, 'MM-DD')) AS end_date FROM event, GUEST g
   WHERE event_no = 1 AND guest_id = 'test';
--------

SELECT * FROM coupon;
SELECT * FROM EVENT;

SELECT * FROM coupon
WHERE guest_id = 'test'
AND USED_YN = 'n'
AND SYSDATE BETWEEN EVENT_START AND event_end;

SELECT * FROM EVENT;

CREATE OR REPLACE VIEW coupon_view
as
SELECT c.*, e.EVENT_NAME, e.EVENT_SALERATE
FROM COUPON c LEFT OUTER JOIN Event e ON (c.EVENT_NO  = e.EVENT_NO );

SELECT * FROM coupon_view;
SELECT * FROM ORDER_DETAIL od;