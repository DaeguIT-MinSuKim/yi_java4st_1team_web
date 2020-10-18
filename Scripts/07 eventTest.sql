SELECT * FROM EVENT ORDER BY EVENT_NO asc;
DELETE FROM EVENT;
SELECT * FROM GUEST g2 ;


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

/*
INSERT INTO coupon(coupon_id, guest_id, event_no, event_start, event_end, use_yn) 
SELECT 1, guest_id, event_no, event_start, event_end, 'n' FROM event*/


