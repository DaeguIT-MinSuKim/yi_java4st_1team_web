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
			
--전체카운트
SELECT COUNT(*) FROM BOOKING WHERE GUEST_ID = 'chini91';

SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM booking WHERE GUEST_ID = 'chini91' ORDER BY book_no) a) WHERE rn BETWEEN 6 AND 10 ORDER BY rn;
SELECT * FROM qna;
