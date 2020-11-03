SELECT * FROM qna;

--날짜별 문의통계
SELECT TO_CHAR(QNA_REGDATE,'yyyy-mm')AS day ,COUNT(*)AS count FROM qna WHERE ADMIN_ID IS NULL GROUP BY TO_CHAR(QNA_REGDATE,'yyyy-mm') ORDER BY TO_CHAR(QNA_REGDATE,'yyyy-mm');
--답변별 문의통계
SELECT RES_YN ,COUNT(*)AS count FROM qna GROUP BY RES_YN ORDER BY RES_YN;
--비밀별 문의통계
SELECT QNA_SECRET ,COUNT(*)AS count FROM qna GROUP BY QNA_SECRET ORDER BY QNA_SECRET;


SELECT * FROM GUEST ;
--가입날짜
SELECT TO_CHAR(GUEST_JOIN_DATE,'yyyy-mm')AS day ,COUNT(*)AS count FROM  GUEST GROUP BY TO_CHAR(GUEST_JOIN_DATE,'yyyy-mm') ORDER BY TO_CHAR(GUEST_JOIN_DATE,'yyyy-mm');
--남자여자
SELECT GUEST_GENDER ,COUNT(*)AS count FROM  GUEST GROUP BY GUEST_GENDER ORDER BY GUEST_GENDER;
--탈퇴한 회원비율
SELECT DEL_YN ,COUNT(*)AS count FROM  GUEST GROUP BY DEL_YN ORDER BY DEL_YN;


SELECT * FROM BOOKING ;
--시간대별예약
SELECT TO_CHAR(book_time,'HH24')AS day ,COUNT(*)AS count FROM  BOOKING GROUP BY TO_CHAR(book_time,'HH24') ORDER BY TO_CHAR(book_time,'HH24');
--날짜별예약
SELECT TO_CHAR(book_time,'yyyy-mm')AS day ,COUNT(*)AS count FROM  BOOKING GROUP BY TO_CHAR(book_time,'yyyy-mm') ORDER BY TO_CHAR(book_time,'yyyy-mm');
--다자이너예약
SELECT de_no ,COUNT(*)AS count FROM  BOOKING GROUP BY de_no ORDER BY de_no;
--헤어예약
SELECT hair_no ,COUNT(*)AS count FROM  BOOKING GROUP BY hair_no ORDER BY hair_no;


--디자이너주문
SELECT de_no ,COUNT(*)AS count FROM ORDERS GROUP BY de_no ORDER BY de_no;
--날짜주문
SELECT TO_CHAR(orders_date,'yyyy-mm')AS day ,COUNT(*)AS count FROM ORDERS GROUP BY TO_CHAR(orders_date,'yyyy-mm') ORDER BY TO_CHAR(orders_date,'yyyy-mm');
--주문금액
SELECT TO_CHAR(orders_date,'yyyy-mm')AS day ,(SELECT OD_PRICE FROM ORDER_DETAIL)AS price FROM ORDERS GROUP BY TO_CHAR(orders_date,'yyyy-mm') ORDER BY TO_CHAR(orders_date,'yyyy-mm');

--이벤트주문상세
SELECT event_no ,COUNT(*)AS count FROM ORDER_DETAIL GROUP BY event_no ORDER BY event_no;
--헤어주문상세
SELECT hair_no ,COUNT(*)AS count FROM ORDER_DETAIL GROUP BY hair_no ORDER BY hair_no;

SELECT * FROM DESIGNER d2 ;
--직위디자이너
SELECT de_level ,COUNT(*)AS count FROM DESIGNER GROUP BY de_level ORDER BY de_level;


SELECT OD_PRICE FROM ORDER_DETAIL ;
