/*예약 단계
 *0. 예약 취소
 *1. 예약 완료
 *2. 방문 완료
 *-1. 미방문
 *
 *NOSHOW 누적시 패널티 같은 거..? 별도 관리..
 */

/* 페이징용 booking */
CREATE OR REPLACE VIEW booking_guest_view AS
SELECT b.*, DE_NICKNAME, DE_NAME, DE_LEVEL, guest_name, guest_phone
FROM booking b
	LEFT OUTER JOIN designer d ON(b.DE_NO = d.DE_NO)
	LEFT OUTER JOIN guest g ON(b.GUEST_ID = g.GUEST_ID);




-- 예약 가능한 시간 테이블 조회(0: 예약가능, 1: 예약됨)
SELECT times, nvl(used, 0) AS USED
FROM (SELECT TO_CHAR(TO_DATE('08:30', 'hh24:mi') + LEVEL/24/2, 'hh24:mi') AS times
	FROM DUAL CONNECT BY LEVEL <= 20) 
LEFT OUTER JOIN
	(SELECT TO_CHAR(BOOK_TIME, 'hh24:mi') AS times, 1 AS used
	FROM BOOKING WHERE TO_char(book_time, 'YYYY-MM-DD') = '2020-10-31' AND DE_NO = 5)
USING (TIMES) ORDER BY TIMES;

SELECT times, nvl(used, 0) AS USED
				FROM (SELECT TO_CHAR(TO_DATE('08:30', 'hh24:mi') + LEVEL/24/2, 'hh24:mi') AS times
				FROM DUAL CONNECT BY LEVEL <= 20)
				LEFT OUTER JOIN
					(SELECT TO_CHAR(BOOK_TIME, 'hh24:mi') AS times, 1 AS used
					FROM BOOKING WHERE TO_char(book_time, 'YYYY-MM-DD') = '?' AND DE_NO = ?)
				USING (TIMES) ORDER BY TIMES

	
SELECT times, nvl2((SELECT TO_CHAR(BOOK_TIME, 'hh24:mi') FROM BOOKING WHERE TO_char(book_time, 'YYYY-MM-DD') = '2020-10-14'), 1, 0) AS used
FROM (SELECT TO_CHAR(TO_DATE('08:30', 'hh24:mi') + LEVEL/24/2, 'hh24:mi') AS times
	FROM DUAL CONNECT BY LEVEL <= 20);


-- 이미 예약된 시간
SELECT 1 AS used FROM BOOKING WHERE TO_char(BOOK_TIME, 'YYYY-MM-DD hh24:mi') = '2020-10-14 16:00';

-- 시간별
-- 디자이너별
-- 예약상태별

-- 고객이름
-- 고객아이디
-- 연락처

-- 뭔차이
SELECT * FROM guest WHERE guest_id != 'nonmember';
SELECT g.* FROM guest g
LEFT OUTER JOIN (SELECT guest_Id FROM guest WHERE guest_id = 'nonmember') g2
ON (g.guest_id = g2.guest_Id)
WHERE g2.guest_id IS NULL;

SELECT * FROM BOOKING_HAIRS_VIEW bhv ;
SELECT * FROM guest;
UPDATE guest SET GUEST_EMAIL = 'earthdo.x@gmail.com' WHERE guest_id = 'test';