SELECT * FROM EVENT ORDER BY EVENT_NO asc;
DELETE FROM EVENT;
SELECT * FROM GUEST g2 ;
ALTER TABLE EVENT
RENAME COLUMN use_yn TO event_status;

--이벤트test정보 insert
INSERT INTO EVENT(EVENT_NAME,EVENT_START,EVENT_END,EVENT_PIC,EVENT_CONTENT) VALUES ('CGV',sysdate,sysdate,'event/images/movieCoupon.jpg','헤어랑샵과 cgv의 콜라보'); 
INSERT INTO EVENT(EVENT_NAME,EVENT_START,EVENT_END,EVENT_PIC,EVENT_CONTENT) VALUES ('SummerEvent',sysdate,sysdate,'event/images/summer.jpg','여름한정 이벤트 대축제~'); 
INSERT INTO EVENT(EVENT_NAME,EVENT_START,EVENT_END,EVENT_PIC,EVENT_CONTENT) VALUES ('good',sysdate,sysdate,'event/images/summer.jpg','사계절 이벤트 대축제~'); 

--eventDetail 이전글 다음글 불러오는곳
SELECT * FROM (SELECT * FROM EVENT WHERE EVENT_NO <1 ORDER BY EVENT_NO DESC ) WHERE rownum = 1;
SELECT * FROM (SELECT * FROM EVENT WHERE EVENT_NO >3 ) WHERE rownum = 1;

SELECT * FROM event;
SELECT * FROM COUPON c ;
SELECT * FROM ORDER_DETAIL od ;

INSERT INTO coupon(guest_id, event_no, event_start, event_end)
SELECT guest_id, event_no, event_start, event_end FROM guest, event WHERE event_no = 3;




SELECT * FROM coupon;
INSERT INTO coupon(COUPON_ID, guest_id, event_no, event_start, event_end) 
SELECT '10', 'test', event_no, TO_DATE(TO_CHAR(sysdate, 'YYYY-') || TO_CHAR(guest_birthday - 15, 'MM-DD')) AS START_date,
	TO_DATE(TO_CHAR(sysdate, 'YYYY-') || TO_CHAR(guest_birthday + 15, 'MM-DD')) AS end_date FROM event, GUEST g
	WHERE event_no = 1 AND guest_id = 'test';

-- 1. 발급 대상인지 확인
--SELECT * FROM guest;
SELECT event_no, guest_id, TO_DATE(TO_CHAR(sysdate - 365, 'YYYY-') ||TO_CHAR(guest_birthday, 'MM-DD')) - 15 AS START_date,
		TO_DATE(TO_CHAR(sysdate - 365, 'YYYY-') || TO_CHAR(guest_birthday, 'MM-DD')) + 15 AS end_date,
		CASE
			WHEN TO_DATE('2019-10-20', 'YYYY-MM-DD')
				BETWEEN TO_DATE(TO_CHAR(sysdate - 365, 'YYYY-') || TO_CHAR(guest_birthday, 'MM-DD'))  - 15
				AND TO_DATE(TO_CHAR(sysdate - 365, 'YYYY-') || TO_CHAR(guest_birthday, 'MM-DD')) + 15 THEN '발급 대상'
			ELSE '기간에 포함 X'
		END AS "2019-10-20기준 해당함?"
FROM event, GUEST g
WHERE event_no = 1;

SELECT * FROM coupon;

--2. 발급 받았는지 검사(별루네.. 더 생각..)
SELECT * FROM coupon c, guest g
WHERE event_no = 2
AND g.guest_id = 'test'
AND event_start = TO_DATE(TO_CHAR(sysdate - 365, 'YYYY-') ||TO_CHAR(guest_birthday, 'MM-DD')) - 15
AND event_end = TO_DATE(TO_CHAR(sysdate - 365, 'YYYY-') || TO_CHAR(guest_birthday, 'MM-DD')) + 15;

--3. 안 받았으면 쏜다
-- insert문 아까꺼



-- 게스트 아이디, 발급대상인지만 확인
SELECT guest_id,
		CASE
			WHEN TO_DATE('2019-10-20', 'YYYY-MM-DD') BETWEEN TO_DATE(TO_CHAR(sysdate - 365, 'YYYY-') ||TO_CHAR(guest_birthday, 'MM-DD')) - 15 AND TO_DATE(TO_CHAR(sysdate - 365, 'YYYY-') || TO_CHAR(guest_birthday, 'MM-DD')) + 15 THEN '발급 대상'
			ELSE '기간에 포함 X'
		END AS "2019-10-20기준 해당함?"
FROM event, GUEST g
WHERE event_no = 1;