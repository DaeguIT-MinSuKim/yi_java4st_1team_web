SELECT COUPON_ID,GUEST_ID,EVENT_NO,EVENT_START,EVENT_END,USED_YN FROM coupon WHERE GUEST_ID = 'chini91';
SELECT * FROM event;

SELECT * FROM COUPON ORDER BY COUPON_ID desc;

SELECT * FROM coupon_view
--쿠폰확인
SELECT c.COUPON_ID, c.GUEST_ID, e.EVENT_NO, e.EVENT_NAME, e.EVENT_START, e.EVENT_END, e.USE_YN AS event_useYn, c.USED_YN 
FROM COUPON c 
LEFT JOIN event e ON c.event_no = e.event_no WHERE c.GUEST_ID = 'chini91';

--쿠폰 넣기
INSERT INTO coupon(guest_id, event_no, event_start, event_end, used_yn) 
SELECT 'test4321', event_no, event_start, event_end, 'n' FROM event WHERE event_no = 2;

SELECT 14, 'test4', event_no, event_start, event_end, 'n' FROM event WHERE event_no = 1;


INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT)
VALUES ('오픈 기념 쿠폰', 0.1, to_date('2020-11-01', 'YYYY-MM-DD'), to_date('2020-11-30', 'YYYY-MM-DD'), NULL, '오픈 기념 20% 할인 행사');

UPDATE event SET USE_YN = 'n' WHERE EVENT_NO = 5;

--생일쿠폰 -> start: 생일로부터 10일전 end: 생일로부터 10일 후 

SELECT * FROM COUPON WHERE GUEST_ID = 'chini91';


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


INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT, USE_YN)
VALUES ('기간지난쿠폰', 0.2, to_date('2020-09-28', 'YYYY-MM-DD'), to_date('2020-10-15', 'YYYY-MM-DD'), NULL, '오픈 기념 10% 할인 행사', 'n');

UPDATE COUPON SET USED_YN = 'n';
--
--넣기
INSERT INTO coupon(COUPON_ID, guest_id, event_no, event_start, event_end, used_yn)
SELECT 20, 'test', event_no, event_start, event_end, 'n' FROM event WHERE event_no = 1;
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
   TO_DATE(TO_CHAR(sysdate, 'YYYY-') || TO_CHAR(guest_birthday + 15, 'MM-DD')) AS end_date FROM event, GUEST g
   WHERE event_no = 1 AND guest_id = 'test';
   

SELECT EVENT_NO,EVENT_NAME,EVENT_SALERATE,EVENT_START,EVENT_END,EVENT_PIC,EVENT_CONTENT,USE_YN FROM event;
SELECT COUPON_ID,GUEST_ID,EVENT_NO,EVENT_START,EVENT_END,USED_YN FROM coupon ORDER BY COUPON_ID;


-- 개인에게 6번 이벤트 쿠폰 발행
INSERT INTO coupon(guest_id, event_no, event_start, event_end) 
SELECT 'abcd', event_no, event_start, event_end FROM event WHERE event_no = 2;


----------------------------------------
SELECT * FROM event ORDER BY EVENT_NO DESC;
SELECT * FROM coupon_view;

UPDATE event SET event_status = 'w';
DELETE FROM COUPON;
DELETE FROM event;

SELECT event_end - 1 / (24*60*60) + 1 AS event_end FROM event;

----------------------------------------------------------------------------------------------------------
--
SELECT COUNT(*) FROM event;
SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM event ORDER BY event_no desc) a) 
WHERE rn BETWEEN s AND 10 ORDER BY rn;
--
/* event_status
 * 대기: w / 진행: s / 종료: e
 * 1. 대기: event_start > sysdate
 * 2. 진행 : event_start >= sysdate &  
 * 			event_end - 1/(24*60*60) -> end날짜의 전날 23:59:59 인것.
 * 3. 종료 : event_end < sysdate 
 * */
/* coupon : used_yn
 * 1. 기간 o, 사용 o : y 사용가능
 * 2. 기간o, 사용 x : n 사용완료
 * 3. 기간 x, 사용 x : e 미사용만료
 * */

--사용 가능 => 기간 o 사용 x
--미사용 만료 => 기간 x 사용 x
--사용 완료 => 기간 o 사용 o

/* 조회 */
--대기
SELECT * FROM event WHERE event_start > sysdate;
--진행
SELECT * FROM event WHERE event_start <= sysdate AND event_end >= sysdate;
--SELECT * FROM event WHERE event_start <= sysdate AND event_end - 1/(24*60*60) >= sysdate;
--종료 
SELECT * FROM event WHERE EVENT_END < sysdate;

/* job */
-- 진행중 -> 대기
UPDATE event SET event_status = 'w' WHERE event_start > sysdate;
-- 대기 -> 진행중으로 변경 
UPDATE event SET event_status = 's' WHERE event_start <= sysdate AND event_end >= sysdate;
--UPDATE event SET event_status = 's' WHERE event_start <= sysdate AND event_end - 1/(24*60*60) >= sysdate;
-- 이벤트 종료로 변경
UPDATE event SET event_status = 'e' WHERE event_end < sysdate;
-- 고객 쿠폰 기간만료로 변경
UPDATE coupon SET USED_YN = 'e' WHERE EVENT_END < sysdate;


/* insert할때
 * end 2020-10-30이면 실제로 2020-10-29 23:59:59 까지인데 
 * 인서트 자체를 20-10-30 23:59:59로 처리할것인가 다음날로 처리할것인가
 * */
--insert할때 현재날짜 + 23:59:59 추가하기 => 이렇게하면 배치랑 조회가 좀 더쉬움,,
SELECT event_end - 1 / (24*60*60) + 1 AS event_end FROM event;

SELECT * FROM HAIR_BOARD;
--테스트 
SELECT * FROM event ORDER BY EVENT_NO DESC;
SELECT * FROM coupon;
UPDATE event SET event_status = 'w';

INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT)
VALUES ('대기중', 0.2, to_date('2020-11-15', 'YYYY-MM-DD'), to_date('2020-11-20', 'YYYY-MM-DD') + - 1 / (24*60*60) + 1, NULL, '테스트');

INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT)
VALUES ('진행중', 0.2, to_date('2020-10-29', 'YYYY-MM-DD'), to_date('2020-11-20', 'YYYY-MM-DD') + - 1 / (24*60*60) + 1, NULL, '테스트');

INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT)
VALUES ('종료', 0.2, to_date('2020-10-20', 'YYYY-MM-DD'), to_date('2020-10-28', 'YYYY-MM-DD') + - 1 / (24*60*60) + 1, NULL, '테스트');

INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT)
VALUES ('생일', 0.2, NULL, NULL, NULL, '생일로부터 10일 전후 동안만 사용할 수 있습니다.');

INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT)
VALUES ('오픈 기념 쿠폰', 0.2, to_date('2020-10-29', 'YYYY-MM-DD'), to_date('9999-12-19', 'YYYY-MM-DD') + - 1 / (24*60*60) + 1 , NULL, '오픈 기념 20% 할인 행사');

SELECT c.*, TO_DATE(TO_CHAR(sysdate+12, 'YYYY-MM-DD'), 'YYYY-MM-DD') FROM coupon c WHERE guest_id = 'test' AND USED_YN = 'n' AND SYSDATE+11 BETWEEN EVENT_START AND EVENT_END;

------------------------
/* 쿠폰 */
/* 가입할때 진행중인 이벤트의 쿠폰을 갖고있지 않으면 넣기 
 * 
 */
SELECT * FROM GUEST g LEFT OUTER JOIN COUPON c ON g.GUEST_ID = c.GUEST_ID WHERE NOT c.EVENT_NO = 4;

SELECT * FROM COUPON;
SELECT * FROM guest;
SELECT * FROM event ORDER BY EVENT_no desc;
SELECT * FROM COUPON_VIEW;
SELECT count(*) FROM COUPON_VIEW;
DELETE coupon;
DELETE event;
SELECT * FROM guest WHERE GUEST_ID = 'test4321';

SELECT max(EVENT_NO) FROM EVENT;

--전체 쿠폰 삽입
INSERT INTO COUPON(guest_id, EVENT_NO, EVENT_START, EVENT_END)
SELECT guest_id, EVENT_NO, EVENT_START, EVENT_END
FROM
(SELECT g.*, 1 AS fake FROM guest g WHERE del_yn = 'n' ) g 
LEFT OUTER JOIN 
(SELECT e.*, 1 AS fake FROM EVENT e WHERE event_no = 5) USING (FAKE);


INSERT INTO COUPON(guest_id, EVENT_NO, EVENT_START, EVENT_END)
SELECT guest_id, EVENT_NO, EVENT_START, EVENT_END
FROM
(SELECT g.*, 1 AS fake FROM guest g) g JOIN (SELECT e.*, 1 AS fake FROM EVENT e WHERE event_no = 5) USING (FAKE);

--생일쿠폰 10일전 삽입
/*
 * INSERT INTO COUPON(guest_id, EVENT_NO, EVENT_START, EVENT_END)
SELECT guest_id, "thisyear_bd" - 10 AS event_start, "thisyear_bd" + 10 - 1 / (24*60*60) + 1 AS event_end
FROM (
SELECT guest_id, guest_birthday, TO_DATE(TO_CHAR(sysdate, 'YYYY-') || TO_CHAR(GUEST_BIRTHDAY, 'MM-DD')) AS "thisyear_bd", 1 AS fake FROM guest g
) gb
WHERE sysdate BETWEEN "thisyear_bd" - 10 AND "thisyear_bd" + 10 - 1 / (24*60*60) + 1;
*
**/

--생일쿠폰 삽입
INSERT INTO COUPON(guest_id, EVENT_NO, EVENT_START, EVENT_END)
SELECT guest_id, 4/*쿠폰번호*/, "thisyear_bd" - 10 AS event_start, "thisyear_bd" + 10 - 1 / (24*60*60) + 1 AS event_end
FROM (SELECT guest_id, guest_birthday, TO_DATE(TO_CHAR(sysdate, 'YYYY-') || TO_CHAR(GUEST_BIRTHDAY, 'MM-DD')) AS "thisyear_bd", 1 AS fake FROM guest g) gb
WHERE sysdate BETWEEN "thisyear_bd" - 10 AND "thisyear_bd" + 10 - 1 / (24*60*60) + 1;


--
INSERT INTO coupon(COUPON_ID, guest_id, event_no, event_start, event_end, used_yn)
SELECT 18, 'test', event_no, event_start, event_end, 'n' FROM event WHERE event_no = 7;
--


------------------------------------------------------------------------------------------------------------------

-- 찐!! 가짜 조인을 이용해 쿠폰 삽입
INSERT INTO COUPON(guest_id, EVENT_NO, EVENT_START, EVENT_END)
SELECT guest_id, EVENT_NO, EVENT_START, EVENT_END
FROM
(SELECT g.*, 1 AS fake FROM guest g) g JOIN (SELECT e.*, 1 AS fake FROM EVENT e WHERE event_no = 5) USING (FAKE);

INSERT INTO COUPON(guest_id, EVENT_NO, EVENT_START, EVENT_END, USED_YN);
SELECT guest_id, EVENT_NO, EVENT_START, EVENT_END
FROM
(SELECT g.*, TO_CHAR(guest_birthday) AS guest_bd, 1 AS fake FROM guest g WHERE TO_CHAR(sysdate, 'YYYY-MM-DD') BETWEEN GUEST_BIRTHDAY - 10 AND GUEST_BIRTHDAY + 10) LEFT OUTER JOIN (SELECT e.*, 1 AS fake FROM EVENT e WHERE event_no = 1) USING (FAKE);

-- 찐!! 가짜조인을 이용한 생일 쿠폰 삽입!!!
INSERT INTO COUPON(guest_id, EVENT_NO, EVENT_START, EVENT_END)
SELECT guest_id, 7, "thisyear_bd" - 10 AS event_start, "thisyear_bd" + 10 - 1 / (24*60*60) + 1 AS event_end
FROM (
SELECT guest_id, guest_birthday, TO_DATE(TO_CHAR(sysdate, 'YYYY-') || TO_CHAR(GUEST_BIRTHDAY, 'MM-DD')) AS "thisyear_bd", 1 AS fake FROM guest g
) gb
WHERE sysdate BETWEEN "thisyear_bd" - 10 AND "thisyear_bd" + 10 - 1 / (24*60*60) + 1;

--가입쿠폰
INSERT INTO coupon(guest_id, event_no, event_start, event_end) 
SELECT 'test111', event_no ,sysdate, to_date(to_char(sysdate, 'yyyy-MM-dd')) + 30 - 1 / (24*60*60) + 1 FROM event WHERE event_no = 2;



/*
생일 쿠폰 삽입 결과 확인용(조건 만족하는 사람 구하기)

SELECT gb.*, "thisyear_bd" - 10 AS event_start, "thisyear_bd" + 10 - 1 / (24*60*60) + 1 AS event_end
FROM (
SELECT guest_id, guest_birthday, TO_DATE(TO_CHAR(sysdate, 'YYYY-') || TO_CHAR(GUEST_BIRTHDAY, 'MM-DD')) AS "thisyear_bd", 1 AS fake FROM guest g
) gb
WHERE sysdate BETWEEN "thisyear_bd" - 10 AND "thisyear_bd" + 10 - 1 / (24*60*60) + 1;
 */
SELECT * FROM COUPON;
SELECT * FROM COUPON_view ORDER BY COUPON_ID desc;
--쿠폰 페이징
SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM coupon_view ORDER BY COUPON_ID desc) a) WHERE rn BETWEEN 1 AND 10 ORDER BY rn;
SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM coupon_view WHERE EVENT_NO = 23 ORDER BY COUPON_ID desc) a) WHERE rn BETWEEN 1 AND 10 ORDER BY rn;
SELECT count(*) FROM COUPON;
---


INSERT INTO COUPON(guest_id, EVENT_NO, EVENT_START, EVENT_END)
SELECT guest_id, 23, "thisyear_bd" - 10 AS event_start, "thisyear_bd" + 10 - 1 / (24*60*60) + 1 AS event_end
FROM (
SELECT guest_id, guest_birthday, TO_DATE(TO_CHAR(sysdate, 'YYYY-') || TO_CHAR(GUEST_BIRTHDAY, 'MM-DD')) AS "thisyear_bd", 1 AS fake FROM guest g
) gb
WHERE sysdate BETWEEN "thisyear_bd" - 10 AND "thisyear_bd" + 10 - 1 / (24*60*60) + 1;



UPDATE event SET event_status = 's' WHERE event_no = 's';

--쿠폰view의 생일쿠폰만 보기
SELECT * FROM (SELECT a.* FROM (SELECT * FROM COUPON_VIEW ORDER BY COUPON_ID desc) a) WHERE event_no = 1;

------
SELECT * FROM COUPON ORDER BY COUPON_ID desc;
SELECT * FROM guest;
SELECT * FROM COUPON_view WHERE event_no = 32 ORDER BY COUPON_ID desc;
SELECT * FROM event;
UPDATE COUPON SET EVENT_START = EVENT_START, EVENT_END = EVENT_END WHERE EVENT_NO = 32;

INSERT INTO coupon(guest_id, event_no, event_start, event_end) 
SELECT 'test', event_no, event_start, event_end FROM event WHERE event_no = 2;

UPDATE COUPON SET EVENT_START = EVENT_START, EVENT_END = EVENT_END WHERE EVENT_NO = 23;

SELECT COUNT(*) FROM coupon where event_no = 20;
DELETE coupon WHERE COUPON_id = 10;



SELECT * FROM EVENT ORDER BY EVENT_NO DESC;

SELECT * FROM COUPON_VIEW ORDER BY COUPON_ID desc;

UPDATE COUPON SET USED_YN = 'y' WHERE GUEST_ID = 'testtt' AND COUPON_ID = 39;
UPDATE EVENT SET EVENT_CONTENT = '가입시 증정' WHERE EVENT_NO = 2;

SELECT * FROM event;

SELECT * FROM DESIGNER;

 SELECT COUNT(*) FROM coupon_view;
 
SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM coupon_view WHERE GUEST_ID = 'test' and not event_status = 'w' AND NOT used_yn = 'e'
ORDER BY COUPON_ID desc) a) WHERE rn BETWEEN 1 AND 10 ORDER BY rn;

UPDATE EVENT SET EVENT_START = TO_date('2020-11-01', 'yyyy-MM-dd') , EVENT_END = TO_date('2020-11-03', 'yyyy-MM-dd');