SELECT * FROM notice;

SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM notice  ORDER BY notice_no DESC) a) WHERE  rn BETWEEN 1 AND 5;

INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT) values('1번째공지','1번째공지내용');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT) values('2번째공지','2번째공지내용');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT) values('3번째공지','3번째공지내용');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT) values('4번째공지','4번째공지내용');

UPDATE NOTICE SET NOTICE_DELYN ='n';




