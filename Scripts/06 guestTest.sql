SELECT * FROM guest;
SELECT * FROM GUEST_VIEW;
SELECT GUEST_ID,GUEST_NAME,GUEST_BIRTHDAY,GUEST_PHONE,GUEST_EMAIL,GUEST_GENDER,GUEST_JOIN_DATE,GUEST_NOTE,DEL_YN,INFO_YNFROM GUEST_VIEW;

--INSERT INTO(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE,  GUEST_GENDER, GUEST_NOTE, INFO_YN ) 
INSERT INTO guest(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_EMAIL, GUEST_GENDER, GUEST_NOTE, INFO_YN) VALUES ('test2', '1234', '김혜진2', TO_date('1991-12-19','yyyy--MM-dd'), '010-5656-5656', 'text2@tes2t.com', 1, '메모', 'y');

<<<<<<< HEAD
UPDATE GUEST SET GUEST_NAME = ?, GUEST_BIRTHDAY = ?, GUEST_PHONE =?, GUEST_NOTE = ?, info_yn WHERE GUEST_ID = 'test2';
=======
UPDATE GUEST SET GUEST_NAME = ?, GUEST_BIRTHDAY = ?, GUEST_PHONE =?, GUEST_NOTE = ?, info_yn WHERE GUEST_ID = 'test2';

>>>>>>> branch 'master' of https://github.com/DaeguIT-MinSuKim/yi_java4st_1team_web.git