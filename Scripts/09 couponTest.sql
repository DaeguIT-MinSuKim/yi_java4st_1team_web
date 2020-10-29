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
<<<<<<< HEAD
SELECT 14, 'test', event_no, event_start, event_end, 'n' FROM event WHERE event_no = 2;
=======
SELECT 14, 'test4', event_no, event_start, event_end, 'n' FROM event WHERE event_no = 1;
>>>>>>> branch 'master' of https://github.com/DaeguIT-MinSuKim/yi_java4st_1team_web.git

INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT)
VALUES ('오픈 기념 쿠폰', 0.1, to_date('2020-10-21', 'YYYY-MM-DD'), to_date('2020-11-10', 'YYYY-MM-DD'), NULL, '오픈 기념 10% 할인 행사');


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
AS
SELECT c.*, NVL(e.EVENT_NAME, '삭제된 이벤트') AS EVENT_NAME, e.EVENT_SALERATE
FROM COUPON c LEFT OUTER JOIN Event e ON (c.EVENT_NO  = e.EVENT_NO );

---
INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT, USE_YN)
VALUES ('기간지난쿠폰', 0.2, to_date('2020-09-28', 'YYYY-MM-DD'), to_date('2020-10-15', 'YYYY-MM-DD'), NULL, '오픈 기념 10% 할인 행사', 'n');

INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT, USE_YN)
VALUES ('미사용쿠폰', 0.2, to_date('2020-09-28', 'YYYY-MM-DD'), to_date('2020-10-15', 'YYYY-MM-DD'), NULL, '오픈 기념 10% 할인 행사', 'y');

INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT, USE_YN)
VALUES ('사용쿠폰', 0.2, to_date('2020-09-28', 'YYYY-MM-DD'), to_date('2020-10-30', 'YYYY-MM-DD'), NULL, '오픈 기념 10% 할인 행사', 'y');

INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT, USE_YN)
VALUES ('사용가능쿠폰', 0.2, to_date('2020-09-28', 'YYYY-MM-DD'), to_date('2020-10-30', 'YYYY-MM-DD'), NULL, '오픈 기념 10% 할인 행사', 'y');

INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT, USE_YN)
VALUES ('사용만료확인22', 0.2, to_date('2020-09-28', 'YYYY-MM-DD'), to_date('2020-10-28-18-00-00', 'YYYY-MM-DD-HH24-MI-SS'), NULL, '오픈 기념 10% 할인 행사', 'y');

UPDATE COUPON SET USED_YN = 'n';
--
--넣기
INSERT INTO coupon(COUPON_ID, guest_id, event_no, event_start, event_end, used_yn)
SELECT 18, 'test', event_no, event_start, event_end, 'n' FROM event WHERE event_no = 7;
--
SELECT * FROM COUPON;
SELECT * FROM EVENT ORDER BY EVENT_NO;

--
--사용 가능 => 기간 o 사용 x
--미사용 만료 => 기간 x 사용 x
--사용 완료 => 기간 o 사용 o

--이벤트 기간 지남 => 쿠폰 미사용 만료 : e로 설정. event_end < sysdate & coupon의 used_yn이 n인것


UPDATE COUPON SET USED_YN = 'e' WHERE EVENT_END < sysdate AND USED_YN = 'n';

SELECT c.COUPON_ID, c.GUEST_ID, c.USED_YN, e.EVENT_NO, e.EVENT_START, e.EVENT_END, e.EVENT_NAME FROM COUPON c 
LEFT OUTER JOIN EVENT e ON e.EVENT_NO = c.EVENT_NO
WHERE e.EVENT_END < SYSDATE AND c.USED_YN = 'e';

--사용완료쿠폰 조회 => 기간 o 사용 o
--사용
UPDATE coupon SET USED_YN = 'y' WHERE COUPON_ID = 17 AND GUEST_ID = 'test';
SELECT * FROM COUPON_VIEW WHERE USED_YN = 'y' AND EVENT_END >= sysdate;

--사용가능 조회 => 기간 o 사용 x
SELECT * FROM COUPON_VIEW WHERE USED_YN = 'n' AND EVENT_END >= sysdate;



--생일 : 1992-10-15 => start 20200930 / end 20201030 생일 15일전후 
SELECT 4, 'test', event_no, TO_DATE(TO_CHAR(sysdate, 'YYYY-') || TO_CHAR(guest_birthday - 15, 'MM-DD')) AS START_date,
   TO_DATE(TO_CHAR(sysdate, 'YYYY-') || TO_CHAR(guest _birthday + 15, 'MM-DD')) AS end_date FROM event, GUEST g
   WHERE event_no = 1 AND guest_id = 'test';
   

SELECT EVENT_NO,EVENT_NAME,EVENT_SALERATE,EVENT_START,EVENT_END,EVENT_PIC,EVENT_CONTENT,USE_YN FROM event;
SELECT COUPON_ID,GUEST_ID,EVENT_NO,EVENT_START,EVENT_END,USED_YN FROM coupon ORDER BY COUPON_ID;
=======
SELECT * FROM coupon_view;
SELECT * FROM ORDER_DETAIL od;


-- 개인에게 6번 이벤트 쿠폰 발행
INSERT INTO coupon(coupon_id, guest_id, event_no, event_start, event_end) 
SELECT 3, 'abcd', event_no, event_start, event_end FROM event WHERE event_no = 6;

SELECT * FROM event;
SELECT * FROM coupon;
SELECT * FROM guest;


SELECT * FROM COUPON_VIEW ;

SELECT c.*, TO_DATE(TO_CHAR(sysdate+12, 'YYYY-MM-DD'), 'YYYY-MM-DD') FROM coupon c WHERE guest_id = 'test' AND USED_YN = 'n' AND SYSDATE+11 BETWEEN EVENT_START AND EVENT_END;