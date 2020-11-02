-- 10월 1일 ~ 10월 31일 사이의 일별 주문 건수
SELECT
	to_char(ORDERS_DATE, 'YYYY-MM-DD') AS 날짜,
	count(*) AS 주문건수
FROM orders o
WHERE ORDERS_DATE >= '2020-10-01' AND ORDERS_DATE <= '2020-10-31'
GROUP BY to_char(ORDERS_DATE, 'YYYY-MM-DD');


-- 주문건이 0인 날짜도 출력되는, 일별 주문건수 통계
SELECT TO_CHAR(b.dt, 'YYYY-MM-DD') AS ORDERS_DATE 
     , NVL(SUM(a.cnt), 0) cnt
  FROM ( SELECT TO_CHAR(ORDERS_DATE , 'YYYY-MM-DD') AS ORDERS_DATE 
              , COUNT(*) cnt
           FROM orders
          WHERE ORDERS_DATE BETWEEN TO_DATE('2020-10-01', 'YYYY-MM-DD')
                             AND TO_DATE('2020-10-31', 'YYYY-MM-DD') 
          GROUP BY ORDERS_DATE
        ) a
      , ( SELECT TO_DATE('2020-10-01','YYYY-MM-DD') + LEVEL - 1 AS dt
            FROM dual 
         CONNECT BY LEVEL <= (TO_DATE('2020-10-31','YYYY-MM-DD') 
                            - TO_DATE('2020-10-01','YYYY-MM-DD') + 1)
        ) b
  WHERE b.dt = a.ORDERS_DATE(+)
  GROUP BY b.dt
  ORDER BY b.dt 


-- 7월부터 10월 사이의 월별 주문 건수
SELECT
	to_char(ORDERS_DATE, 'YYYY-MM') AS 년월,
	count(*) AS 주문건수
FROM orders o
WHERE ORDERS_DATE >= '2020-07-01' AND ORDERS_DATE <= '2020-10-31'
GROUP BY to_char(ORDERS_DATE, 'YYYY-MM');


-- 주문건이 0인 월도 출력되는, 월별 주문건수 통계 (상반기. 7-12월)
SELECT TO_CHAR(b.dt, 'YYYY-MM') AS ORDERS_DATE 
     , NVL(SUM(a.cnt), 0) cnt
  FROM ( SELECT TO_CHAR(ORDERS_DATE , 'YYYY-MM-DD') AS ORDERS_DATE 
              , COUNT(*) cnt
           FROM ORDERS
          WHERE ORDERS_DATE BETWEEN TO_DATE('2020-07-01', 'YYYY-MM-DD')
                             AND TO_DATE('2020-12-31', 'YYYY-MM-DD') 
          GROUP BY ORDERS_DATE 
        ) a
      , ( SELECT TO_DATE('2020-07-01','YYYY-MM-DD') + LEVEL - 1 AS dt
            FROM dual 
         CONNECT BY LEVEL <= (TO_DATE('2020-12-31','YYYY-MM-DD') 
                            - TO_DATE('2020-07-01','YYYY-MM-DD') + 1)
        ) b
  WHERE b.dt = a.ORDERS_DATE(+)
  GROUP BY TO_CHAR(b.dt, 'YYYY-MM')
  ORDER BY TO_CHAR(b.dt, 'YYYY-MM')





SELECT o.*, d.DE_NAME, d.DE_NICKNAME
FROM (SELECT de_no, count(DE_NO) AS "주문건수"
FROM ORDERS o
GROUP BY DE_NO) o
	LEFT OUTER JOIN
	DESIGNER d ON (o.DE_NO = d.DE_NO );

-- 주문건이 0인 날짜도 출력되는, 일별 주문건수 통계
SELECT TO_CHAR(b.dt, 'YYYY-MM-DD') AS ORDERS_DATE 
     , NVL(SUM(a.cnt), 0) cnt
  FROM ( SELECT TO_CHAR(ORDERS_DATE , 'YYYY-MM-DD') AS ORDERS_DATE
  				
              , COUNT(*) cnt
           FROM orders
          WHERE ORDERS_DATE BETWEEN TO_DATE('2020-10-01', 'YYYY-MM-DD')
                             AND TO_DATE('2020-10-31', 'YYYY-MM-DD') 
          GROUP BY ORDERS_DATE
        ) a
      , ( SELECT TO_DATE('2020-10-01','YYYY-MM-DD') + LEVEL - 1 AS dt
            FROM dual 
         CONNECT BY LEVEL <= (TO_DATE('2020-10-31','YYYY-MM-DD') 
                            - TO_DATE('2020-10-01','YYYY-MM-DD') + 1)
        ) b
  WHERE b.dt = a.ORDERS_DATE(+)
  GROUP BY b.dt
  ORDER BY b.dt 
  
  

-- 10월의 디자이너별 요일별 매출합계
-- 쓸모가 있나? 상품별이 좋지 않을까?
SELECT a.de_nickname,
		sum(decode(a.week, '1', a.ORDERS_TOTAL_PRICE)) 일요일,
		sum(decode(a.week, '2', a.ORDERS_TOTAL_PRICE)) 월요일,
		sum(decode(a.week, '3', a.ORDERS_TOTAL_PRICE)) 화요일,
		sum(decode(a.week, '4', a.ORDERS_TOTAL_PRICE)) 수요일,
		sum(decode(a.week, '5', a.ORDERS_TOTAL_PRICE)) 목요일,
		sum(decode(a.week, '6', a.ORDERS_TOTAL_PRICE)) 금요일,
		sum(decode(a.week, '7', a.ORDERS_TOTAL_PRICE)) 토요일
FROM
	(
		SELECT 
			o.ORDERS_DATE, o.ORDERS_TOTAL_PRICE,
			TO_CHAR(o.ORDERS_DATE, 'd') week,
			d.DE_NICKNAME
		FROM ORDERS o LEFT OUTER JOIN DESIGNER d
		on (o.DE_NO = d.DE_NO)
		 WHERE ORDERS_DATE BETWEEN TO_DATE('2020-10-01', 'YYYY-MM-DD')
                             AND TO_DATE('2020-10-31', 'YYYY-MM-DD') 
	) a
GROUP BY orders_date, DE_NICKNAME 
ORDER BY ORDERS_DATE;



-- 10월의 헤어별 요일별 매출합계
SELECT a.hair_name,
		sum(decode(a.week, '1', a.ORDERS_TOTAL_PRICE)) 일요일,
		sum(decode(a.week, '2', a.ORDERS_TOTAL_PRICE)) 월요일,
		sum(decode(a.week, '3', a.ORDERS_TOTAL_PRICE)) 화요일,
		sum(decode(a.week, '4', a.ORDERS_TOTAL_PRICE)) 수요일,
		sum(decode(a.week, '5', a.ORDERS_TOTAL_PRICE)) 목요일,
		sum(decode(a.week, '6', a.ORDERS_TOTAL_PRICE)) 금요일,
		sum(decode(a.week, '7', a.ORDERS_TOTAL_PRICE)) 토요일
FROM
	(
		SELECT 
			o.ORDERS_DATE, o.ORDERS_TOTAL_PRICE,
			TO_CHAR(o.ORDERS_DATE, 'd') week,
			h.HAIR_NAME 
		FROM ORDERS o LEFT OUTER JOIN ORDER_DETAIL od on (o.ORDERS_NO = od.orders_no)
			LEFT OUTER JOIN HAIR h ON (od.HAIR_NO = h.HAIR_NO )
		 WHERE ORDERS_DATE BETWEEN TO_DATE('2020-10-01', 'YYYY-MM-DD')
                             AND TO_DATE('2020-10-31', 'YYYY-MM-DD') 
	) a
GROUP BY orders_date, HAIR_NAME 
ORDER BY ORDERS_DATE;


-- 10월의 헤어별 요일별 주문건수
SELECT a.hair_name,
		count(decode(a.week, '1', a.Od_no)) 일요일,
		count(decode(a.week, '2', a.Od_no)) 월요일,
		count(decode(a.week, '3', a.Od_no)) 화요일,
		count(decode(a.week, '4', a.Od_no)) 수요일,
		count(decode(a.week, '5', a.Od_no)) 목요일,
		count(decode(a.week, '6', a.Od_no)) 금요일,
		count(decode(a.week, '7', a.Od_no)) 토요일
FROM
	(
		SELECT 
			o.ORDERS_DATE, od.OD_NO,
			TO_CHAR(o.ORDERS_DATE, 'd') week,
			h.HAIR_NAME 
		FROM ORDERS o LEFT OUTER JOIN ORDER_DETAIL od on (o.ORDERS_NO = od.orders_no)
			LEFT OUTER JOIN HAIR h ON (od.HAIR_NO = h.HAIR_NO )
		 WHERE ORDERS_DATE BETWEEN TO_DATE('2020-10-01', 'YYYY-MM-DD')
                             AND TO_DATE('2020-10-31', 'YYYY-MM-DD') 
	) a
GROUP BY orders_date, HAIR_NAME 
ORDER BY ORDERS_DATE;

SELECT * FROM guest;
