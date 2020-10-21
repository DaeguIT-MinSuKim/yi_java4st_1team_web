SELECT * FROM DESIGNER;
DELETE FROM DESIGNER WHERE de_no = 10;
UPDATE DESIGNER SET DE_PIC = 'designer/images/wd.jpg' WHERE de_no = 1; 
UPDATE DESIGNER SET DE_PIC = 'designer/images/irene.jpg' WHERE de_no = 2; 
UPDATE DESIGNER SET DE_PIC = 'designer/images/sk.jpg' WHERE de_no = 3; 
UPDATE DESIGNER SET DE_PIC = 'designer/images/yr.jpg' WHERE de_no = 4; 
UPDATE DESIGNER SET DE_PIC = 'designer/images/joy.jpg' WHERE de_no = 5; 

--원장-디자이너-스탭순 정렬
SELECT * FROM designer WHERE use_yn = 'y'
ORDER BY decode(de_level, '원장', 1, '디자이너', 2,'스탭', 3, 4);

--
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES('박원장', '원', '디자이너', 'designer/images/yr.jpg', '20년 경력을 자랑하는 헤어랑의 원장');
UPDATE DESIGNER SET de_name = '김예림' WHERE de_no = 4;

INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES ('손승완', '웬디', '원장', 'designer/images/wd.jpg','#찰떡스타일링 #정형화되지않은스타일 #얼굴형보완 #내츄럴웨이브 #연예인머리 #컨셉세팅펌');
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES ('배주현', '아이린', '디자이너', 'designer/images/irene.jpg','#내추럴컷 #레이어드컷 #스타일링커트 #루즈컷 #유럽피안컷 #팜므파탈 #손질없이커트만으로멋나는 #얼굴보완컷 #퍼스널컬러디렉팅');
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES ('강슬기', '슬기', '디자이너', 'designer/images/sk.jpg','#클래식 #고급스러움 #단발머리 #단발컷 #풍성한웨이브 #로맨틱웨이브 #드라마틱볼륨 #글램웨이브 #러블리헤어');
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES ('김예림', '예리', '디자이너', 'designer/images/yr.jpg','#단발컷 #태슬컷 #내츄럴웨이브펌 #볼륨레이어컷 #볼륨펌');
INSERT INTO DESIGNER(DE_NAME, DE_NICKNAME, DE_LEVEL, DE_PIC, DE_CONTENT) VALUES ('박수영', '조이', '스탭', 'designer/images/joy.jpg','#레이어드컷 #단발레이어드컷 #풍성한볼륨 #볼륨매직 #글램웨이브 #긴머리웨이브 #러블리헤어 ');