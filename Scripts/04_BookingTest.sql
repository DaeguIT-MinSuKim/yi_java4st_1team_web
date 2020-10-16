/*예약 단계
 *1. 예약 접수
 *2. 예약 완료
 *0. 예약 취소
 *3. 방문 완료
 *-1. NOSHOW
 *
 *NOSHOW 누적시 패널티 같은 거..? 별도 관리..
 */



SELECT max(book_no) FROM booking;

SELECT * FROM BOOKING WHERE BOOK_NO = 60 AND GUEST_ID = 'test';

SELECT book_no FROM booking WHERE BOOK_REGDATE = (SELECT max(BOOK_REGDATE) FROM BOOKING);

CREATE TABLE time_table (
	BOOK_TIME CHAR(5)
);

SELECT * FROM TIME_TABLE;
/*SELECT TO_CHAR(TO_DATE('08:30', 'hh24:mi') + LEVEL/24/2, 'hh24:mi') AS times,
	case((SELECT TO_CHAR(BOOK_TIME, 'hh24:mi') AS booked_time FROM BOOKING) WHEN TIMES = BOOKED_TIME) FROM DUAL
CONNECT BY LEVEL <= 20;*/

-- 예약 가능한 시간 테이블 조회(0: 예약가능, 1: 예약됨)
SELECT times, nvl(used, 0) AS USED
FROM (SELECT TO_CHAR(TO_DATE('08:30', 'hh24:mi') + LEVEL/24/2, 'hh24:mi') AS times
	FROM DUAL CONNECT BY LEVEL <= 20) 
LEFT OUTER JOIN
	(SELECT TO_CHAR(BOOK_TIME, 'hh24:mi') AS times, 1 AS used
	FROM BOOKING WHERE TO_char(book_time, 'YYYY-MM-DD') = '2020-10-15')
USING (TIMES) ORDER BY TIMES;


SELECT times, nvl2((SELECT TO_CHAR(BOOK_TIME, 'hh24:mi') FROM BOOKING WHERE TO_char(book_time, 'YYYY-MM-DD') = '2020-10-14'), 1, 0)
FROM (SELECT TO_CHAR(TO_DATE('08:30', 'hh24:mi') + LEVEL/24/2, 'hh24:mi') AS times
	FROM DUAL CONNECT BY LEVEL <= 20);


--SELECT * FROM TIME_TABLE_VIEW WHERE AVAILABLE = 0 AND TIMES IN (SELECT TIMES FROM TIME_TABLE_VIEW WHERE AVAILABLE = 1);

-- 이미 예약된 시간
SELECT TO_CHAR(BOOK_TIME, 'hh24:mi') FROM BOOKING WHERE TO_char(BOOK_TIME, 'YYYY-MM-DD') = '2020-10-14';



INSERT INTO BOOKING(BOOK_NO, GUEST_ID, BOOK_TIME, HAIR_NO, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE)
VALUES(60, 'test', sysdate + 10 - 6/24, 9, 2, sysdate, 1, null);


INSERT INTO ORDER_DETAIL(od_no, coupon_no, hair_no, price, ORDER_NO);
