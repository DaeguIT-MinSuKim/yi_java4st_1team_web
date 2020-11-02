--날짜별 문의통계
SELECT TO_CHAR(QNA_REGDATE,'yyyy-mm-dd')AS day ,COUNT(*)AS count FROM qna WHERE ADMIN_ID IS NULL GROUP BY TO_CHAR(QNA_REGDATE,'yyyy-mm-dd') ORDER BY TO_CHAR(QNA_REGDATE,'yyyy-mm-dd');


SELECT * FROM GUEST g ;

--가입날짜
SELECT TO_CHAR(GUEST_JOIN_DATE,'yyyy-mm-dd')AS day ,COUNT(*)AS count FROM  GUEST GROUP BY TO_CHAR(GUEST_JOIN_DATE,'yyyy-mm-dd') ORDER BY TO_CHAR(GUEST_JOIN_DATE,'yyyy-mm-dd');
--남자여자
SELECT GUEST_GENDER ,COUNT(*)AS count FROM  GUEST GROUP BY GUEST_GENDER ORDER BY GUEST_GENDER;

--몇시예약
SELECT TO_CHAR(book_time,'yyyy-mm-dd:HH24')AS day ,COUNT(*)AS count FROM  BOOKING GROUP BY TO_CHAR(book_time,'yyyy-mm-dd:HH24') ORDER BY TO_CHAR(book_time,'yyyy-mm-dd:HH24');
--다자이너예약
SELECT de_no ,COUNT(*)AS count FROM  BOOKING GROUP BY de_no ORDER BY de_no;
--헤어예약
SELECT hair_no ,COUNT(*)AS count FROM  BOOKING GROUP BY hair_no ORDER BY hair_no;

--디자이너주문
SELECT de_no ,COUNT(*)AS count FROM ORDERS GROUP BY de_no ORDER BY de_no;
--날짜주문
SELECT TO_CHAR(orders_date,'yyyy-mm-dd')AS day ,COUNT(*)AS count FROM ORDERS GROUP BY TO_CHAR(orders_date,'yyyy-mm-dd') ORDER BY TO_CHAR(orders_date,'yyyy-mm-dd');

--이벤트주문상세
SELECT event_no ,COUNT(*)AS count FROM ORDER_DETAIL GROUP BY event_no ORDER BY event_no;
--헤어주문상세
SELECT hair_no ,COUNT(*)AS count FROM ORDER_DETAIL GROUP BY hair_no ORDER BY hair_no;

--직위디자이너
SELECT de_level ,COUNT(*)AS count FROM DESIGNER GROUP BY de_level ORDER BY de_level;

--날짜별문의
SELECT TO_CHAR(qna_regDate,'yyyy-mm-dd')AS day ,COUNT(*)AS count FROM QNA GROUP BY TO_CHAR(qna_regDate,'yyyy-mm-dd') ORDER BY TO_CHAR(qna_regDate,'yyyy-mm-dd');







SELECT * FROM HAIR h ;

