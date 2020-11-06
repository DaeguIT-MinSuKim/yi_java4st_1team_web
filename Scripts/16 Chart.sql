SELECT * FROM qna;

--날짜별 문의통계
SELECT TO_CHAR(QNA_REGDATE,'yyyy') AS day ,COUNT(*)AS count FROM qna WHERE ADMIN_ID IS NULL  GROUP BY TO_CHAR(QNA_REGDATE,'yyyy') ORDER BY TO_CHAR(QNA_REGDATE,'yyyy');
--답변별 문의통계
SELECT RES_YN ,COUNT(*)AS count FROM qna GROUP BY RES_YN ORDER BY RES_YN;
--비밀별 문의통계
SELECT QNA_SECRET ,COUNT(*)AS count FROM qna GROUP BY QNA_SECRET ORDER BY QNA_SECRET;




--남자여자(이전)
SELECT GUEST_GENDER ,COUNT(*)AS count FROM  GUEST TO_CHAR(SYSDATE ,'yyyy') = 2019 GROUP BY GUEST_GENDER ORDER BY GUEST_GENDER;
--탈퇴한 회원비율
SELECT DEL_YN ,COUNT(*)AS count FROM GUEST WHERE TO_CHAR(SYSDATE ,'yyyy') = 2020 GROUP BY DEL_YN ORDER BY DEL_YN;

--현재 인원 남녀비율()
SELECT GUEST_GENDER ,COUNT(*)AS count FROM (SELECT * FROM GUEST WHERE TO_CHAR(GUEST_JOIN_DATE,'yyyy') = 2020 AND DEL_YN = 'n') GROUP BY GUEST_GENDER ORDER BY GUEST_GENDER;
--탈퇴한 회원비율()
SELECT DEL_YN ,COUNT(*)AS count FROM (SELECT * FROM GUEST WHERE TO_CHAR(GUEST_JOIN_DATE,'yyyy') = 2020  AND DEL_YN ='y') GROUP BY DEL_YN ORDER BY DEL_YN;





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



--------------------------------------------------------------------




--남자여자(x)
SELECT TO_CHAR(b.dt, 'YYYY-MM-DD') AS GUEST_JOIN_DATE 
     , NVL(SUM(a.mail), 0) MAIL ,NVL(SUM(a.femail), 0) FEMAIL 
  FROM ( SELECT TO_CHAR('2020-11-01', 'YYYY-MM-DD') AS GUEST_JOIN_DATE
              , (SELECT COUNT(*) FROM GUEST WHERE GUEST_GENDER =1)AS mail
              , (SELECT COUNT(*) FROM GUEST WHERE GUEST_GENDER =0)AS femail
           FROM GUEST
          WHERE DEL_YN ='n' AND GUEST_JOIN_DATE <= TO_DATE('2020-11-01', 'YYYY-MM-DD')
        ) a
      , ( SELECT TO_DATE('2020-11-01','YYYY-MM-DD') + LEVEL - 1 AS dt
            FROM dual 
         CONNECT BY LEVEL <= (TO_DATE('2020-11-01','YYYY-MM-DD') 
                            - TO_DATE('2020-11-01','YYYY-MM-DD') + 1)
        ) b
  WHERE b.dt = a.GUEST_JOIN_DATE(+)
  GROUP BY b.dt
  ORDER BY b.dt;

SELECT COUNT(a.*)AS aa, count(b.*)AS bb FROM (SELECT * FROM GUEST WHERE GUEST_GENDER =0 AND DEL_YN = 'n')AS a,(SELECT * FROM GUEST WHERE GUEST_GENDER =0 AND DEL_YN = 'y')AS b, dual;  
 
 SELECT COUNT(*)AS mail FROM GUEST WHERE GUEST_GENDER =0 AND DEL_YN = 'n';
 SELECT COUNT(*)AS mail FROM GUEST WHERE GUEST_GENDER =0 AND DEL_YN = 'y';

SELECT COUNT(a.*)AS mail, count(b.*)AS femail FROM (SELECT * FROM GUEST WHERE GUEST_GENDER =0 AND DEL_YN = 'n')AS a,
	(SELECT * FROM GUEST WHERE GUEST_GENDER =0 AND DEL_YN = 'n')AS b;

SELECT TO_CHAR(TO_DATE(SYSDATE ,'yyyy-MM-dd') ,'YYYY-MM-dd'), NVL(cnt(abc.mail), 0) MAIL,NVL(cnt(abc.femail), 0) femail
FROM ( (SELECT COUNT(*) FROM GUEST WHERE GUEST_GENDER =1)AS mail
              , (SELECT COUNT(*) FROM GUEST WHERE GUEST_GENDER =0)AS femail)AS abc;


--회원 일별남녀증가율 차트(o)
SELECT TO_CHAR(TO_DATE(SYSDATE ,'yyyy-MM') , 'YYYY-MM') AS GUEST_JOIN_DATE 
     , NVL(SUM(a.mail), 0) MAIL ,NVL(SUM(a.femail), 0) FEMAIL 
  FROM ( SELECT TO_CHAR(GUEST_JOIN_DATE, 'YYYY-MM-DD') AS GUEST_JOIN_DATE
              , (SELECT COUNT(*) FROM GUEST WHERE GUEST_GENDER =1)AS mail
              , (SELECT COUNT(*) FROM GUEST WHERE GUEST_GENDER =0)AS femail
           FROM GUEST
          WHERE DEL_YN ='n' AND GUEST_JOIN_DATE BETWEEN TO_DATE('2020-11-01', 'YYYY-MM-DD')
                             AND TO_DATE('2020-11-05' , 'YYYY-MM-DD') 
          GROUP BY GUEST_JOIN_DATE 
        ) a
      , ( SELECT TO_DATE('2020-11-01','YYYY-MM-DD') + LEVEL - 1 AS dt
            FROM dual 
         CONNECT BY LEVEL <= (TO_DATE('2020-11-05','YYYY-MM-DD') 
                            - TO_DATE('2020-11-01','YYYY-MM-DD') + 1)
        ) b
  WHERE b.dt = a.GUEST_JOIN_DATE(+)
  GROUP BY b.dt
  ORDER BY b.dt;
 
--회원 월별증가율 차트(o)
SELECT TO_CHAR(b.dt, 'YYYY-MM') AS GUEST_JOIN_DATE 
     , NVL(SUM(a.cnt), 0)AS CNT 
  FROM ( SELECT TO_CHAR(GUEST_JOIN_DATE, 'YYYY-MM-DD') AS GUEST_JOIN_DATE
              , COUNT(*)AS cnt 
           FROM GUEST
          WHERE DEL_YN ='n' AND GUEST_JOIN_DATE BETWEEN TO_DATE('2020-01-01', 'YYYY-MM-DD')
                             AND TO_DATE('2020-12-05' , 'YYYY-MM-DD') 
          GROUP BY GUEST_JOIN_DATE 
        ) a
      , ( SELECT TO_DATE('2020-01-01','YYYY-MM-DD') + LEVEL - 1 AS dt
            FROM dual 
         CONNECT BY LEVEL <= (TO_DATE('2020-12-05','YYYY-MM-DD') 
                            - TO_DATE('2020-01-01','YYYY-MM-DD') + 1)
        ) b
  WHERE b.dt = a.GUEST_JOIN_DATE(+)
  GROUP BY TO_CHAR(b.dt, 'YYYY-MM')
  ORDER BY TO_CHAR(b.dt, 'YYYY-MM');
 
--회원 일별증가율 차트(o)
SELECT TO_CHAR(b.dt, 'YYYY-MM-dd') AS GUEST_JOIN_DATE 
     , NVL(SUM(a.cnt), 0)AS CNT 
  FROM ( SELECT TO_CHAR(GUEST_JOIN_DATE, 'YYYY-MM-DD') AS GUEST_JOIN_DATE
              , COUNT(*)AS cnt 
           FROM GUEST
          WHERE DEL_YN ='n' AND GUEST_JOIN_DATE BETWEEN TO_DATE('2020-11-01', 'YYYY-MM-DD')
                             AND TO_DATE('2020-11-05' , 'YYYY-MM-DD') 
          GROUP BY GUEST_JOIN_DATE 
        ) a
      , ( SELECT TO_DATE('2020-11-01','YYYY-MM-DD') + LEVEL - 1 AS dt
            FROM dual 
         CONNECT BY LEVEL <= (TO_DATE('2020-11-05','YYYY-MM-DD') 
                            - TO_DATE('2020-11-01','YYYY-MM-DD') + 1)
        ) b
  WHERE b.dt = a.GUEST_JOIN_DATE(+)
  GROUP BY TO_CHAR(b.dt, 'YYYY-MM-dd')
  ORDER BY TO_CHAR(b.dt, 'YYYY-MM-dd');

 
 
 
 
 
  SELECT TO_CHAR(b.dt, 'YYYY-MM-dd') AS GUEST_JOIN_DATE 
     , NVL(SUM(a.cnt), 0)AS CNT 
  FROM ( SELECT TO_CHAR(GUEST_JOIN_DATE, 'YYYY-MM-DD') AS GUEST_JOIN_DATE
              , COUNT(*)AS cnt 
           FROM GUEST
          WHERE DEL_YN ='n' AND GUEST_JOIN_DATE BETWEEN TO_DATE('2020-02-01', 'YYYY-MM-DD')
                             AND TO_DATE('2020-02-28' , 'YYYY-MM-DD') 
          GROUP BY GUEST_JOIN_DATE 
        ) a
      , ( SELECT TO_DATE('2020-02-01','YYYY-MM-DD') + LEVEL - 1 AS dt
            FROM dual 
         CONNECT BY LEVEL <= (TO_DATE('2020-02-28','YYYY-MM-DD') 
                            - TO_DATE('2020-02-01','YYYY-MM-DD') + 1)
        ) b
  WHERE b.dt = a.GUEST_JOIN_DATE(+)
  GROUP BY TO_CHAR(b.dt, 'YYYY-MM-dd')
  ORDER BY TO_CHAR(b.dt, 'YYYY-MM-dd');

-----------------------------------------------------------------------------


--날짜별 문의통계
SELECT TO_CHAR(QNA_REGDATE,'yyyy-MM') AS day ,COUNT(*)AS count FROM qna WHERE ADMIN_ID IS NULL  GROUP BY TO_CHAR(QNA_REGDATE,'yyyy-MM') ORDER BY TO_CHAR(QNA_REGDATE,'yyyy-MM');
--답변별 문의통계
SELECT RES_YN ,COUNT(*)AS count FROM qna GROUP BY RES_YN ORDER BY RES_YN;
--비밀별 문의통계
SELECT QNA_SECRET ,COUNT(*)AS count FROM qna GROUP BY QNA_SECRET ORDER BY QNA_SECRET;



--일별 문의통계(o)
SELECT TO_CHAR(QNA_REGDATE,'yyyy-MM-dd') AS day ,COUNT(*)AS count FROM qna WHERE ADMIN_ID IS NULL  GROUP BY TO_CHAR(QNA_REGDATE,'yyyy-MM-dd') ORDER BY TO_CHAR(QNA_REGDATE,'yyyy-MM-dd');

SELECT TO_CHAR(b.dt, 'DD') AS QNA_REGDATE
     , NVL(SUM(a.cnt), 0) cnt
  FROM ( SELECT TO_CHAR(QNA_REGDATE, 'YYYY-MM-DD') AS QNA_REGDATE
              , COUNT(*) cnt
           FROM qna
          WHERE QNA_REGDATE BETWEEN TO_DATE('2020-11-01', 'YYYY-MM-DD')
                             AND TO_DATE('2020-11-04' , 'YYYY-MM-DD') 
          GROUP BY QNA_REGDATE
        ) a
      , ( SELECT TO_DATE('2020-11-01','YYYY-MM-DD') + LEVEL - 1 AS dt
            FROM dual 
         CONNECT BY LEVEL <= (TO_DATE('2020-11-04','YYYY-MM-DD') 
                            - TO_DATE('2020-11-01','YYYY-MM-DD') + 1)
        ) b
  WHERE b.dt = a.QNA_REGDATE(+)
  GROUP BY TO_CHAR(b.dt, 'DD')
  ORDER BY TO_CHAR(b.dt, 'DD');
 
 --월별 문의통계
 SELECT TO_CHAR(b.dt, 'YYYY-MM') AS QNA_REGDATE
     , NVL(SUM(a.cnt), 0) cnt
  FROM ( SELECT TO_CHAR(QNA_REGDATE, 'YYYY-MM-DD') AS QNA_REGDATE
              , COUNT(*) cnt
           FROM qna
          WHERE QNA_REGDATE BETWEEN TO_DATE('2020-1-01', 'YYYY-MM-DD')
                             AND TO_DATE('2020-12-04' , 'YYYY-MM-DD') 
          GROUP BY QNA_REGDATE
        ) a
      , ( SELECT TO_DATE('2020-1-01','YYYY-MM-DD') + LEVEL - 1 AS dt
            FROM dual 
         CONNECT BY LEVEL <= (TO_DATE('2020-12-04','YYYY-MM-DD') 
                            - TO_DATE('2020-1-01','YYYY-MM-DD') + 1)
        ) b
  WHERE b.dt = a.QNA_REGDATE(+)
  GROUP BY TO_CHAR(b.dt, 'YYYY-MM')
  ORDER BY TO_CHAR(b.dt, 'YYYY-MM');

 
 
 
 
 

 
-----------------------------------------------------------------------------------------------
 
 --예약 월별 카운팅(o)
SELECT TO_CHAR(BOOK_REGDATE,'yyyy-MM') AS day ,COUNT(*)AS count FROM qna WHERE ADMIN_ID IS NULL  GROUP BY TO_CHAR(QNA_REGDATE,'yyyy-MM') ORDER BY TO_CHAR(QNA_REGDATE,'yyyy-MM');

SELECT TO_CHAR(b.dt, 'yyyy-MM') AS BOOK_REGDATE
     , NVL(SUM(a.cnt), 0) cnt
  FROM ( SELECT TO_CHAR(BOOK_REGDATE , 'yyyy-MM') AS BOOK_REGDATE
              , COUNT(*) cnt
           FROM BOOKING 
          WHERE BOOK_REGDATE BETWEEN TO_DATE('2020-11', 'yyyy-MM')
                             AND TO_DATE('2020-11' , 'yyyy-MM') 
          GROUP BY BOOK_REGDATE
        ) a
      , ( SELECT TO_DATE('2020-11','yyyy-MM') + LEVEL - 1 AS dt
            FROM dual 
         CONNECT BY LEVEL <= (TO_DATE('2020-11','yyyy-MM') 
                            - TO_DATE('2020-11','yyyy-MM') + 1)
        ) b
  WHERE b.dt = a.BOOK_REGDATE(+)
  GROUP BY b.dt
  ORDER BY b.dt;

--시간대별 카운팅(x)
SELECT TO_CHAR(b.dt, 'yyyy-MM-dd HH') AS BOOK_REGDATE
     , NVL(SUM(a.cnt), 0) cnt
  FROM ( SELECT TO_CHAR(BOOK_REGDATE , 'yyyy-MM-dd HH') AS BOOK_REGDATE
              , COUNT(*) cnt
           FROM BOOKING 
          WHERE BOOK_REGDATE BETWEEN TO_DATE('2020-11-01', 'yyyy-MM-dd HH')
                             AND TO_DATE('2020-11-05' , 'yyyy-MM-dd HH') 
          GROUP BY BOOK_REGDATE
        ) a
      , ( SELECT TO_DATE('2020-11-01 :00','yyyy-MM-dd HH') + LEVEL - 1 AS dt
            FROM dual 
         CONNECT BY LEVEL <= (TO_DATE('2020-11-05 :23','yyyy-MM-dd HH') 
                            - TO_DATE('2020-11-01 :00','yyyy-MM-dd HH') + 1)
        ) b
  WHERE b.dt = a.BOOK_REGDATE(+)
  GROUP BY b.dt
  ORDER BY b.dt;

 ---------------------------------------------------------
 SELECT * FROM ORDER_DETAIL od ;
SELECT * FROM ORDERS o ;
 
SELECT * FROM ORDERS WHERE ORDERS_DATE BETWEEN '2020-11-01' AND '2020-11-05';

SELECT * FROM ORDER_DETAIL od ;

--월별 주문카운팅(o)
SELECT TO_CHAR(b.dt, 'yyyy-MM ') AS ORDERS_DATE
    , NVL(SUM(a.cnt), 0) cnt
  FROM ( SELECT TO_CHAR(ORDERS_DATE , 'yyyy-MM-dd ') AS ORDERS_DATE
              , COUNT(*) cnt
           FROM ORDERS
          WHERE ORDERS_DATE BETWEEN TO_DATE('2020-11-01', 'yyyy-MM-dd ')
                             AND TO_DATE('2020-12-05' , 'yyyy-MM-dd ') 
          GROUP BY ORDERS_DATE
        ) a
      , ( SELECT TO_DATE('2020-1-01 ','yyyy-MM-dd ') + LEVEL - 1 AS dt
            FROM dual 
         CONNECT BY LEVEL <= (TO_DATE('2020-12-05 ','yyyy-MM-dd ') 
                            - TO_DATE('2020-1-01 ','yyyy-MM-dd ') + 1)
        ) b
  WHERE b.dt = a.ORDERS_DATE(+)
  GROUP BY TO_CHAR(b.dt, 'yyyy-MM ')
  ORDER BY TO_CHAR(b.dt, 'yyyy-MM ');
 
--일별 주문카운팅(o)
SELECT TO_CHAR(b.dt, 'dd ') AS ORDERS_DATE
    , NVL(SUM(a.cnt), 0) cnt
  FROM ( SELECT TO_CHAR(ORDERS_DATE , 'yyyy-MM-dd ') AS ORDERS_DATE
              , COUNT(*) cnt
           FROM ORDERS
          WHERE ORDERS_DATE BETWEEN TO_DATE('2020-11-01', 'yyyy-MM-dd ')
                             AND TO_DATE('2020-11-05' , 'yyyy-MM-dd ') 
          GROUP BY ORDERS_DATE
        ) a
      , ( SELECT TO_DATE('2020-11-01 ','yyyy-MM-dd ') + LEVEL - 1 AS dt
            FROM dual 
         CONNECT BY LEVEL <= (TO_DATE('2020-11-05 ','yyyy-MM-dd ') 
                            - TO_DATE('2020-11-01 ','yyyy-MM-dd ') + 1)
        ) b
  WHERE b.dt = a.ORDERS_DATE(+)
  GROUP BY TO_CHAR(b.dt, 'dd ') 
  ORDER BY TO_CHAR(b.dt, 'dd ');
 
/*--월별 주문카운팅(x)
SELECT TO_CHAR(b.dt, 'yyyy-MM ') AS ORDERS_DATE
    , NVL(SUM(a.cnt), 0) cnt
  FROM ( SELECT TO_CHAR(ORDERS_DATE , 'yyyy-MM ') AS ORDERS_DATE
              , COUNT(*) cnt
           FROM ORDERS
          WHERE ORDERS_DATE BETWEEN TO_DATE('2020-12', 'yyyy-MM ')
                             AND TO_DATE('2020-11' , 'yyyy-MM ') 
          GROUP BY ORDERS_DATE
        ) a
      , ( SELECT TO_DATE('2020-11 ','yyyy-MM') + LEVEL - 1 AS dt
            FROM dual 
         CONNECT BY LEVEL <= (TO_DATE('2020-12 ','yyyy-MM ') 
                            - TO_DATE('2020-11 ','yyyy-MM ') + 1)
        ) b
  WHERE b.dt = a.ORDERS_DATE(+)
  GROUP BY b.dt
  ORDER BY b.dt;*/
 
 
--일별 주문금액(o)
SELECT TO_CHAR(b.dt, 'yyyy-MM-dd ') AS ORDERS_DATE
    , NVL(SUM(a.total), 0) total
  FROM ( SELECT TO_CHAR(ORDERS_DATE , 'yyyy-MM-dd ') AS ORDERS_DATE
              , TO_CHAR(SUM(ORDERS_TOTAL_PRICE),'999,999,999,999,999')  total
           FROM ORDERS
          WHERE ORDERS_DATE BETWEEN TO_DATE('2020-11-01', 'yyyy-MM-dd ')
                             AND TO_DATE('2020-11-05' , 'yyyy-MM-dd ') 
          GROUP BY ORDERS_DATE
        ) a
      , ( SELECT TO_DATE('2020-11-01 ','yyyy-MM-dd ') + LEVEL - 1 AS dt
            FROM dual 
         CONNECT BY LEVEL <= (TO_DATE('2020-11-05 ','yyyy-MM-dd ') 
                            - TO_DATE('2020-11-01 ','yyyy-MM-dd ') + 1)
        ) b
  WHERE b.dt = a.ORDERS_DATE(+)
  GROUP BY b.dt
  ORDER BY b.dt;

 
 -- 월별 주문금액(x)
SELECT TO_CHAR(b.dt, 'yyyy-MM ') AS ORDERS_DATE
    , NVL(SUM(a.total), 0) total
  FROM ( SELECT TO_CHAR(ORDERS_DATE , 'yyyy-MM-dd ') AS ORDERS_DATE
              , TO_CHAR(SUM(ORDERS_TOTAL_PRICE),'999,999,999,999,999')  total
           FROM ORDERS
          WHERE ORDERS_DATE BETWEEN TO_DATE('2020-10', 'yyyy-MM-dd ')
                             AND TO_DATE('2020-11' , 'yyyy-MM-dd ') 
          GROUP BY ORDERS_DATE
        ) a
      , ( SELECT TO_DATE('2020-10 ','yyyy-MM-dd ') + LEVEL - 1 AS dt
            FROM dual 
         CONNECT BY LEVEL <= (TO_DATE('2020-11 ','yyyy-MM-dd ') 
                            - TO_DATE('2020-10 ','yyyy-MM-dd ') + 1)
        ) b
  WHERE b.dt = a.ORDERS_DATE(+)
  GROUP BY b.dt
  ORDER BY b.dt;
