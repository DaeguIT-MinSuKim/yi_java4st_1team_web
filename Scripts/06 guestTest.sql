SELECT * FROM guest;
SELECT * FROM GUEST_VIEW;
SELECT GUEST_ID,GUEST_NAME,GUEST_BIRTHDAY,GUEST_PHONE,GUEST_EMAIL,GUEST_GENDER,GUEST_JOIN_DATE,GUEST_NOTE,DEL_YN,INFO_YNFROM GUEST_VIEW;

--INSERT INTO(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE,  GUEST_GENDER, GUEST_NOTE, INFO_YN ) 
INSERT INTO guest(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_EMAIL, GUEST_GENDER, GUEST_NOTE, INFO_YN) VALUES ('chini91', '1234', '김혜진', TO_date('1991-12-19','yyyy--MM-dd'), '010-5656-5656', 'text2@tes2t.com', 1, '메모', 'y');
DELETE guest WHERE GUEST_ID = 'chini91';
UPDATE GUEST SET GUEST_NAME = ?, GUEST_BIRTHDAY = ?, GUEST_PHONE =?, GUEST_NOTE = ?, info_yn WHERE GUEST_ID = 'test2';

SELECT GUEST_ID FROM guest WHERE GUEST_NAME = '김혜진' AND GUEST_EMAIL='hoon@test.co.kr';

SELECT * FROM guest WHERE GUEST_ID = 'test2' AND GUEST_NAME = '김혜진' AND GUEST_EMAIL='hoon@test.co.kr';

UPDATE guest SET guest_pwd = '4321' WHERE guest_id = 'test';

select * from guest_view where guest_id = 'test2', guest_name = ?, guest_email

UPDATE guest SET guest_pwd = '1234' WHERE GUEST_id = 'chini91';

UPDATE guest SET INFO_YN = 'n' WHERE GUEST_ID = 'chini91';


UPDATE guest SET del_yn = 'n' WHERE GUEST_ID = 'chini91';

SELECT * FROM booking;

SELECT rownum, BOOK_NO,GUEST_ID,BOOK_TIME,HAIR_NO,DE_NO,BOOK_REGDATE,BOOK_STATUS,BOOK_NOTE 
FROM booking WHERE GUEST_ID = 'chini91' ORDER BY rownum DESC;

SELECT rownum AS rnum, book_no FROM booking WHERE GUEST_ID = 'chini91' ORDER BY rnum DESC;

--예약내역 rownum
SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM booking WHERE GUEST_ID = 'chini91' ORDER BY book_no desc) a) 
			WHERE rn BETWEEN 1 AND 5 ORDER BY rn;		
--예약 내역 전체카운트
SELECT COUNT(*) FROM BOOKING WHERE GUEST_ID = 'chini91';


--문의내역
SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM qna WHERE GUEST_ID = 'chini91' ORDER BY qna_no desc) a) 
			WHERE rn BETWEEN 11 AND 20 ORDER BY rn;
--문의내역 카운트 
SELECT COUNT(*) FROM qna WHERE GUEST_ID = 'chini91';	

SELECT * FROM qna;

--문의테스트
INSERT INTO QNA(GUEST_ID, QNA_TITLE, QNA_CONTENT, QNA_REGDATE, RES_YN, NOTICE_YN, DEL_YN, QNA_SECRET) VALUES ('chini91','제목','내용',sysdate, 'n', 'n', 'n', 'n');


--쿠폰내역 rownum
SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM coupon WHERE GUEST_ID = 'chini91' ORDER BY COUPON_ID desc) a) 
			WHERE rn BETWEEN 1 AND 5 ORDER BY rn;		
--쿠폰 전체카운트
SELECT COUNT(*) FROM COUPON WHERE GUEST_ID = 'chini91';
select * FROM guest;
--new 예약

SELECT * FROM hair;
SELECT * FROM booking;
select * FROM booking_view;
SELECT * FROM booking_hairs;
SELECT BOOK_NO,GUEST_ID,BOOK_TIME,HAIR_NO,DE_NO,BOOK_REGDATE,BOOK_STATUS,BOOK_NOTE FROM booking;
SELECT HAIR_NO,BOOK_NO,HAIR_QUANTITY FROM BOOKING_HAIRS;

--booking, booking_hairs, hair join
SELECT b.guest_id, bh.hair_no, h.hair_name, b.book_no, bh.hair_quantity, b.book_time, b.de_no, b.book_regdate, b.book_status, b.book_note
FROM BOOKING_HAIRS bh 
LEFT OUTER JOIN booking b ON b.book_no = bh.book_no 
LEFT JOIN hair h ON bh.hair_no = h.hair_no 
WHERE b.guest_id = 'test';

--예약내역 rownum
SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM booking_view WHERE GUEST_ID = 'test' AND BOOK_STATUS = 1 ORDER BY book_no desc) a) 
			WHERE rn BETWEEN 1 AND 10 ORDER BY rn ;		
--예약 내역 전체카운트
SELECT COUNT(*) FROM (SELECT DISTINCT book_no FROM booking_view WHERE guest_id = 'test');

--중복제외 book_no
SELECT DISTINCT book_no FROM booking_view WHERE guest_id = 'test' ORDER BY book_no desc;


SELECT BOOK_NO,GUEST_ID,BOOK_TIME,HAIR_NO,HAIR_QUANTITY,DE_NO,BOOK_REGDATE,BOOK_STATUS,BOOK_NOTE FROM booking_view ORDER BY book_no desc;
SELECT DISTINCT book_no FROM booking_view WHERE guest_id = 'test';
SELECT * FROM booking;
SELECT * FROM booking_hairs ORDER BY book_no;
SELECT * FROM hair;
-- 60번 헤어14*2=20, 16*1=8 => 28만원 / 62번 12*2=8, 10*1=3 =>11만원

--예약상태 예약완료
SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT distinct(book_no) FROM booking_view WHERE GUEST_ID = 'test' AND book_status = '1'  AND book_no = 2 ORDER BY book_no desc) a) WHERE rn BETWEEN 1 AND 10 ORDER BY rn;
SELECT DISTINCT book_no FROM booking_view WHERE guest_id = 'test' AND BOOK_STATUS = '1' ORDER BY book_no desc;
SELECT COUNT(*) FROM (SELECT DISTINCT book_no FROM booking_view WHERE guest_id = 'test' AND BOOK_STATUS = '1');

--예약상태 예약취소
SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT distinct(book_no) FROM booking_view WHERE GUEST_ID = 'test' AND book_status = '0' ORDER BY book_no desc) a) WHERE rn BETWEEN 1 AND 10 ORDER BY rn;
SELECT DISTINCT book_no FROM booking_view WHERE guest_id = 'test' AND BOOK_STATUS = '0' ORDER BY book_no desc;
SELECT COUNT(*) FROM (SELECT DISTINCT book_no FROM booking_view WHERE guest_id = 'test' AND BOOK_STATUS = '0');

SELECT * FROM BOOKING_HAIRS WHERE BOOK_NO = 60 ORDER BY BOOK_NO, HAIR_NO;


SELECT * FROM (SELECT rownum RN, a.* FROM
(SELECT distinct(book_no) FROM booking_view WHERE GUEST_ID = 'test' AND book_status = '0' AND book_no = '5' ORDER BY book_no desc) a)
WHERE rn BETWEEN 1 AND 10 ORDER BY rn;

SELECT * FROM GUEST;

SELECT * FROM booking_view;