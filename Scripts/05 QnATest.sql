SELECT QNA_NO,GUEST_ID,QNA_TITLE,QNA_REGDATE,RES_YN FROM QNA_VIEW;

SELECT * FROM GUEST;

INSERT INTO GUEST (GUEST_ID,GUEST_PWD,GUEST_NAME, GUEST_BIRTHDAY,GUEST_PHONE) VALUES ('test','1234','testName','1999-12-12','010-1111-111');
DELETE FROM GUEST;

INSERT INTO GUEST (GUEST_ID,GUEST_PWD,GUEST_NAME,GUEST_PHONE) VALUES ('test2','1234','test2Name','010-2222-2222');

SELECT * FROM QNA;

INSERT INTO QNA (GUEST_ID,QNA_TITLE,RES_YN,notice_yn) VALUES ('test','testTitle115','n',0);
INSERT INTO QNA (GUEST_ID,QNA_TITLE,RES_YN,notice_yn) VALUES ('test','testTitl2123123','n',0);
INSERT INTO QNA (GUEST_ID,QNA_TITLE,RES_YN,notice_yn) VALUES ('test2','testTitl4','n',0);


DELETE qna;
SELECT * FROM QNA_VIEW ;

SELECT * FROM ADMIN ;

SELECT QNA_NO,ADMIN_ID,QNA_TITLE,QNA_CONTENT,QNA_FILE,QNA_REGDATE,DEL_YN FROM QNA WHERE GUEST_ID IS NULL;

INSERT INTO ADMIN VALUES ('testadmin','1234','testadmin');

INSERT INTO QNA (ADMIN_ID,QNA_TITLE,DEL_YN, notice_yn) VALUES ('testadmin','admintestolenfoej','n', 1); 

SELECT QNA_NO,ADMIN_ID,QNA_TITLE,QNA_CONTENT,QNA_FILE,QNA_REGDATE,DEL_YN FROM QNA_VIEW WHERE GUEST_ID = 'test' ORDER BY QNA_NO DESC;

SELECT QNA_NO,QNA_TITLE,QNA_FILE,QNA_REGDATE,RES_YN FROM QNA_VIEW WHERE GUEST_ID = 'test' ORDER BY QNA_NO DESC;

SELECT QNA_NO_SEQ.CURRVAL+1 AS count FROM DUAL;

SELECT QNA_NO_SEQ.nextval FROM DUAL;

INSERT INTO QNA (GUEST_ID,QNA_TITLE,QNA_CONTENT,RES_YN,) VALUES ('test2','what','what?','n');

SELECT * FROM QNA;

DELETE FROM QNA ;

UPDATE QNA 
	SET QNA_CONTENT = '이거 수정되는거맞나',
		QNA_REGDATE = SYSDATE 
	WHERE QNA_NO =1;

SELECT GUEST_ID ,GUEST_NAME FROM GUEST WHERE GUEST_ID ='test';

SELECT QNA_NO,QNA_TITLE,QNA_REGDATE,RES_YN FROM QNA_VIEW ORDER BY QNA_NO DESC ;

--총 공지사항 갯수
SELECT COUNT(*) AS count FROM QNA;

--페이징 처리 후 게시글 조회
SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM QNA WHERE GUEST_ID IS NOT NULL ORDER BY QNA_NO DESC ) a) WHERE rn BETWEEN 1 AND 10;


SELECT * FROM qna WHERE ADMIN_ID IS NOT NULL AND DEL_YN ='n'ORDER BY QNA_NO DESC;


SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM QNA  ORDER BY notice_yn asc,QNA_NO ) a) WHERE rn BETWEEN 10 AND 20;

--SELECT QNA_NO,GUEST_ID,ADMIN_ID,QNA_TITLE,QNA_CONTENT,QNA_FILE,QNA_REGDATE,RES_YN,QNA_REFNO,DEL_YN FROM QNA GROUP BY ADMIN_ID;

SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM QNA WHERE GUEST_ID IS NOT NULL ORDER BY QNA_NO DESC ) a) WHERE rn BETWEEN 1 AND 10;

SELECT * FROM QNA WHERE ADMIN_ID CASE WHEN 


SELECT * FROM (SELECT * FROM qna ORDER BY notice_yn, qna_no) WHERE rownum BETWEEN 1 AND 5;

SELECT * FROM (SELECT * FROM qna ORDER BY notice_yn, qna_no) WHERE rownum BETWEEN 1 AND 10;

SELECT * FROM qna;
ALTER TABLE qna MODIFY notice_yn varchar2(1);

UPDATE qna SET notice_yn = 'y' WHERE admin_id IS NOT null; 

UPDATE qna SET notice_yn = 1 WHERE qna_no = 4;
SELECT rownum, a.* FROM (SELECT * FROM qna ORDER BY notice_yn desc, qna_no desc) a WHERE rownum BETWEEN 1 AND 10;


SELECT * FROM (SELECT * FROM qna WHERE del_yn = 'n' ORDER BY notice_yn, qna_no) WHERE rownum BETWEEN  AND 10;

SELECT * FROM qna;
SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY notice_yn DESC, qna_no) no , q.* FROM qna q ORDER BY notice_yn desc, qna_no desc) WHERE NO BETWEEN 1 AND 5;

--지수가 만들어준코드
SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM QNA  ORDER BY notice_yn DESC ,QNA_NO ) a) WHERE rn BETWEEN 1 AND 10;

