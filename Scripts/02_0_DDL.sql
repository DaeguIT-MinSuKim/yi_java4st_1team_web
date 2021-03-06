-- DDL에 잘못 추가 했었음 지워주세요.
DROP TABLE SALES_DETAIL CASCADE CONSTRAINTS;

SELECT * FROM user_tables;

/* 고객 */
DROP TABLE GUEST CASCADE CONSTRAINTS;
/* 디자이너 */
DROP TABLE DESIGNER CASCADE CONSTRAINTS;
/* 헤어분류 */
DROP TABLE HAIR_KIND CASCADE CONSTRAINTS;
/* 헤어 */
DROP TABLE HAIR CASCADE CONSTRAINTS;
/* 예약 */
DROP TABLE BOOKING CASCADE CONSTRAINTS;
/* 이벤트 */
DROP TABLE EVENT CASCADE CONSTRAINTS;
/* 주문 */
DROP TABLE ORDERS CASCADE CONSTRAINTS;
/* 주문상세 */
DROP TABLE ORDER_DETAIL CASCADE CONSTRAINTS;
/* 관리자 */
DROP TABLE ADMIN CASCADE CONSTRAINTS;
/* Q&A */
DROP TABLE QNA CASCADE CONSTRAINTS;

DROP TABLE COUPON CASCADE CONSTRAINTS;
DROP TABLE HB_CATEGORY CASCADE CONSTRAINTS;
DROP TABLE BOOKING_HAIRS CASCADE CONSTRAINTS;
DROP TABLE HAIR_BOARD CASCADE CONSTRAINTS;



/* 고객 */
CREATE TABLE GUEST (
	guest_id VARCHAR2(20) NOT NULL, /* 고객아이디 */
	guest_pwd VARCHAR2(50) NOT NULL,
	guest_name VARCHAR2(20) NOT NULL, /* 고객명 */
	guest_birthday DATE, /* 생년월일 */
	guest_phone VARCHAR2(13) NOT NULL, /* 전화번호 */
	guest_email VARCHAR2(40), /* 이메일 */
	guest_gender NUMBER(1), /* 성별 */
	guest_join_date DATE DEFAULT SYSDATE, /* 가입일자 */
	guest_note VARCHAR2(1000), /* 고객비고 */
	del_yn CHAR(1) DEFAULT 'n', /* 탈퇴여부 */ -- n: 사용가능한 상태, y: 사용가능한 상태
	info_yn char(1) /*마케팅수신동의 y, n*/
);


--ALTER TABLE guest ADD info_yn char(1);
--ALTER TABLE guest RENAME COLUMN guest_join_day TO guest_join_date;

ALTER TABLE GUEST
	ADD
		CONSTRAINT PK_GUEST
		PRIMARY KEY (
			guest_id
		);

/* 이벤트 */
CREATE TABLE EVENT (
	event_no NUMBER(10) NOT NULL, /* 이벤트번호 */
	event_name VARCHAR2(20), /* 이벤트명 */
	event_salerate NUMBER(3, 2), /* 할인율 */
	event_start DATE, /* 시작일 */
	event_end DATE, /* 종료일 */
	event_pic varchar2(200), /* 사진 */
	event_content VARCHAR2(1000) /* 내용 */
);

ALTER TABLE EVENT
	ADD
		CONSTRAINT PK_EVENT
		PRIMARY KEY (
			event_no
		);

/* 헤어 */
CREATE TABLE HAIR (
	hair_no NUMBER(10) NOT NULL, /* 헤어번호 */
	hair_name VARCHAR2(40) NOT NULL, /* 헤어명 */
	hair_price NUMBER NOT NULL, /* 단가 */
	hair_pic varchar2(200), /* 사진 */
	hair_content VARCHAR2(1000), /* 내용 */
	kind_no NUMBER(10) /* 분류번호 */
);

ALTER TABLE HAIR MODIFY HAIR_NAME VARCHAR2(40);

ALTER TABLE HAIR
	ADD
		CONSTRAINT PK_HAIR
		PRIMARY KEY (
			hair_no
		);

	
/* 주문 */
CREATE TABLE ORDERS (
	orders_no NUMBER(10) NOT NULL, /* 주문번호 */
	orders_date DATE DEFAULT SYSDATE, /* 주문일자 */
	de_no NUMBER(10), /* 디자이너번호 */
	guest_id VARCHAR2(20) /* 고객아이디 */
);

ALTER TABLE ORDERS
	ADD
		CONSTRAINT PK_ORDERS
		PRIMARY KEY (
			orders_no
		);
	

	
/* 주문상세 */
CREATE TABLE ORDER_DETAIL (
	od_no NUMBER(10) NOT NULL, /* 주문상세번호 */
	event_no NUMBER(10), /* 이벤트번호 */
	hair_no NUMBER(10), /* 헤어번호 */
	order_no NUMBER(10) /* 주문번호 */
);

ALTER TABLE ORDER_DETAIL
	ADD
		CONSTRAINT PK_ORDER_DETAIL
		PRIMARY KEY (
			od_no
		);

	
/* 예약 */
CREATE TABLE BOOKING (
	book_no NUMBER(10) NOT NULL, /* 예약번호 */
	guest_id VARCHAR2(20), /* 고객아이디 */
	book_time DATE, /* 예약시간 */
	hair_no NUMBER(10), /* 헤어번호 */
	de_no NUMBER(10), /* 디자이너 */
	book_regDate DATE DEFAULT SYSDATE,
	book_status NUMBER(1) DEFAULT 1, /* 예약 */
	book_note VARCHAR2(400) /* 예약비고 */
);

/*예약 단계
 *1. 예약 접수
 *2. 예약 완료
 *0. 예약 취소
 *3. 방문 완료
 *-1. NOSHOW
 *
 *NOSHOW 누적시 패널티 같은 거..? 별도 관리..
 */

ALTER TABLE BOOKING
	ADD
		CONSTRAINT PK_BOOKING
		PRIMARY KEY (
			book_no
		);


/* 관리자 */
CREATE TABLE ADMIN (
	admin_id VARCHAR2(20) NOT NULL, /* 관리자아이디 */
	admin_pwd VARCHAR2(30), /* 관리자비번 */
	admin_name VARCHAR2(20) /* 관리자이름 */
);

ALTER TABLE ADMIN
	ADD
		CONSTRAINT PK_ADMIN
		PRIMARY KEY (
			admin_id
		);

/* 디자이너 */
CREATE TABLE DESIGNER (
	de_no NUMBER(10) NOT NULL, /* 번호 */
	de_name VARCHAR2(20), /* 이름 */
	de_nickname VARCHAR2(20), /* 닉네임 */
	de_level VARCHAR2(20), /* 직위 */
	de_pic varchar2(200), /* 사진 */
	de_content VARCHAR2(1000) /* 글 */
);

ALTER TABLE DESIGNER
	ADD
		CONSTRAINT PK_DESIGNER
		PRIMARY KEY (
			de_no
		);

/* Q&A */
CREATE TABLE QNA (
	qna_no NUMBER(10) NOT NULL, /* 글번호 */
	guest_id VARCHAR2(20), /* 고객아이디 */
	guest_name VARCHAR2(20),/* 고객이름 */
	admin_id VARCHAR2(20), /* 관리자아이디 */
	qna_title VARCHAR2(100), /* 제목 */
	qna_content VARCHAR2(1000), /* 내용 */
	qna_file varchar2(200), /* 첨부파일 */
	qna_regDate DATE DEFAULT SYSDATE, /* 작성일 */
	res_Yn CHAR(1), /* 처리완료여부 */
	qna_refNo NUMBER(10), /* 고객문의번호 */
	del_yn CHAR(1) /* 삭제여부 */
);

ALTER TABLE qna ADD notice_yn number(1);

ALTER TABLE qna MODIFY del_yn DEFAULT 'n';
ALTER TABLE qna MODIFY notice_yn DEFAULT 'n';

ALTER TABLE QNA
	ADD
		CONSTRAINT PK_QNA
		PRIMARY KEY (
			qna_no
		);

/* 헤어분류 */
CREATE TABLE HAIR_KIND (
	kind_no NUMBER(10) NOT NULL, /* 분류번호 */
	kind_name VARCHAR2(20) /* 분류이름 */
	use_Yn CHAR(1) /* 사용 여부 */
);

ALTER TABLE HAIR_KIND
	ADD
		CONSTRAINT PK_HAIR_KIND
		PRIMARY KEY (
			kind_no
		);



ALTER TABLE HAIR
	ADD
		CONSTRAINT FK_HAIR_KIND_TO_HAIR
		FOREIGN KEY (
			kind_no
		)
		REFERENCES HAIR_KIND (
			kind_no
		);

ALTER TABLE ORDER_DETAIL
	ADD
		CONSTRAINT FK_EVENT_TO_ORDER_DETAIL
		FOREIGN KEY (
			event_no
		)
		REFERENCES EVENT (
			event_no
		);

ALTER TABLE BOOKING
	ADD
		CONSTRAINT FK_HAIR_TO_BOOKING
		FOREIGN KEY (
			hair_no
		)
		REFERENCES HAIR (
			hair_no
		);

ALTER TABLE BOOKING
	ADD
		CONSTRAINT FK_GUEST_TO_BOOKING
		FOREIGN KEY (
			guest_id
		)
		REFERENCES GUEST (
			guest_id
		);

	
ALTER TABLE BOOKING
	ADD
		CONSTRAINT FK_DESIGNER_TO_BOOKING
		FOREIGN KEY (
			de_no
		)
		REFERENCES DESIGNER (
			de_no
		);


ALTER TABLE QNA
	ADD
		CONSTRAINT FK_QNA_TO_QNA
		FOREIGN KEY (
			qna_refNo
		)
		REFERENCES QNA (
			qna_no
		);

ALTER TABLE QNA
	ADD
		CONSTRAINT FK_GUEST_TO_QNA
		FOREIGN KEY (
			guest_id
		)
		REFERENCES GUEST (
			guest_id
		);

ALTER TABLE QNA
	ADD
		CONSTRAINT FK_ADMIN_TO_QNA
		FOREIGN KEY (
			admin_id
		)
		REFERENCES ADMIN (
			admin_id
		);

ALTER TABLE ORDERS
	ADD
		CONSTRAINT FK_DESIGNER_TO_ORDERS
		FOREIGN KEY (
			de_no
		)
		REFERENCES DESIGNER (
			de_no
		);

ALTER TABLE ORDERS
	ADD
		CONSTRAINT FK_GUEST_TO_ORDERS
		FOREIGN KEY (
			guest_id
		)
		REFERENCES GUEST (
			guest_id
		);

	ALTER TABLE ORDER_DETAIL
	ADD
		CONSTRAINT FK_HAIR_TO_ORDER_DETAIL
		FOREIGN KEY (
			hair_no
		)
		REFERENCES HAIR (
			hair_no
		);

ALTER TABLE ORDER_DETAIL
	ADD
		CONSTRAINT FK_ORDER_TO_ORDER_DETAIL
		FOREIGN KEY (
			order_no
		)
		REFERENCES ORDERS (
			orders_no
		);