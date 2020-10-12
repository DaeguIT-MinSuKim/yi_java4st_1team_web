SELECT * FROM EVENT;
DELETE FROM EVENT e ;
SELECT * FROM GUEST g2 ;
--이벤트test정보 insert
INSERT INTO EVENT(EVENT_NAME,EVENT_START,EVENT_END,EVENT_PIC,EVENT_CONTENT) VALUES ('CGV',sysdate,sysdate,'event/images/movieCoupon.jpg','헤어랑샵과 cgv의 콜라보'); 
INSERT INTO EVENT(EVENT_NAME,EVENT_START,EVENT_END,EVENT_PIC,EVENT_CONTENT) VALUES ('SummerEvent',sysdate,sysdate,'event/images/summer.jpg','여름한정 이벤트 대축제~'); 