SELECT * FROM notice;

SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM notice  ORDER BY notice_no DESC) a) WHERE  rn BETWEEN 1 AND 5;

INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT) values('1번째공지','1번째공지내용');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT) values('2번째공지','2번째공지내용');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT) values('3번째공지','3번째공지내용');
INSERT INTO notice(NOTICE_TITLE,NOTICE_CONTENT) values('4번째공지','4번째공지내용');

UPDATE NOTICE SET NOTICE_DELYN ='y' WHERE NOTICE_NO =2;

DELETE FROM NOTICE WHERE NOTICE_NO >5;

--전체카운팅하는거
SELECT COUNT(*) AS COUNT FROM NOTICE;

--삭제된거 카운팅
SELECT COUNT(*) AS COUNT FROM NOTICE WHERE NOTICE_DELYN ='y';

--현재 쓰이는 페이징
SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM notice WHERE notice_delyn = 'n' ORDER BY notice_no DESC) a) WHERE rn BETWEEN 1 AND 5;

SELECT * FROM NOTICE n ;

--구현 해야되는 페이징
--삭제된 동지 페이징
SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM notice WHERE notice_delyn = 'y'  ORDER BY notice_no DESC) a) WHERE rn BETWEEN 1 AND 5;

--삭제 안된 공지 제목으로 찾기
SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM notice WHERE notice_delyn = 'n' AND  NOTICE_TITLE LIKE '%공지%' ORDER BY notice_no DESC) a) WHERE rn BETWEEN 1 AND 5;

SELECT COUNT(*) AS COUNT FROM NOTICE where NOTICE_DELYN ='n' and notice_title like '%대훈%';


SELECT TABLE_NAME, NUM_ROWS, CHAIN_CNT, BLOCKS, EMPTY_BLOCKS, AVG_SPACE, AVG_ROW_LEN FROM DBA_TABLES WHERE OWNER = 'HAIRRANG_WEB';


SELECT * FROM QNA WHERE DEL_YN ='y';
