-- DDL에 잘못 추가 했었음 지워주세요.
DROP TABLE SALES_DETAIL CASCADE CONSTRAINTS;

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

/* 보유쿠폰 */
DROP TABLE COUPON CASCADE CONSTRAINTS;
/* 헤어게시판 */
DROP TABLE HAIR_BOARD CASCADE CONSTRAINTS;
/* 헤어게시판 카테고리 */
DROP TABLE HB_CATEGORY CASCADE CONSTRAINTS;
/* 예약헤어정보 */
DROP TABLE BOOKING_HAIRS  CASCADE CONSTRAINTS;

/* 고객 */
CREATE TABLE GUEST (
	guest_id VARCHAR2(20) NOT NULL, /* 고객아이디 */
	guest_pwd VARCHAR2(50) NOT NULL, /* 비밀번호 */
	guest_name VARCHAR2(20) NOT NULL, /* 고객명 */
	guest_birthday DATE, /* 생년월일 */
	guest_phone VARCHAR2(13) NOT NULL, /* 전화번호 */
	guest_email VARCHAR2(40), /* 이메일 */
	guest_gender NUMBER(1) DEFAULT 1, /* 성별 */
	guest_join_date DATE DEFAULT SYSDATE, /* 가입일자 */
	guest_note VARCHAR2(1000), /* 고객비고 */
	del_yn CHAR(1) DEFAULT 'n', /* 탈퇴여부 */ -- n: 사용가능한 상태, y: 탈퇴
	info_yn char(1) DEFAULT 'n' /*마케팅수신동의 y, n*/
);

ALTER TABLE GUEST
ADD	CONSTRAINT PK_GUEST	PRIMARY KEY (guest_id);


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
ADD CONSTRAINT PK_EVENT PRIMARY KEY (event_no);


/* 헤어분류 */
CREATE TABLE HAIR_KIND (
	kind_no NUMBER(10) NOT NULL, /* 분류번호 */
	kind_name VARCHAR2(20), /* 분류이름 */
	use_Yn CHAR(1) DEFAULT 'y' /* 사용 여부 */
);

ALTER TABLE HAIR_KIND
ADD CONSTRAINT PK_HAIR_KIND PRIMARY KEY (kind_no);
	

/* 헤어 */
CREATE TABLE HAIR (
	hair_no NUMBER(10) NOT NULL, /* 헤어번호 */
	hair_name VARCHAR2(40) NOT NULL, /* 헤어명 */
	hair_price NUMBER NOT NULL, /* 단가 */
	hair_pic varchar2(200), /* 사진 */
	hair_content VARCHAR2(1000), /* 내용 */
	kind_no NUMBER(10), /* 분류번호 */
	use_yn CHAR(1) DEFAULT 'y' /* 사용여부 */
);


ALTER TABLE HAIR
ADD CONSTRAINT PK_HAIR PRIMARY KEY (hair_no);



	
/* 예약 */
/*
 *1. 예약 접수
 *2. 예약 완료
 *0. 예약 취소
 *3. 방문 완료
 *-1. NOSHOW
 *
 *NOSHOW 누적시 패널티 같은 거..? 별도 관리..
 */

CREATE TABLE BOOKING (
	book_no NUMBER(10) NOT NULL, /* 예약번호 */
	guest_id VARCHAR2(20) NOT NULL, /* 고객아이디 */
	book_time DATE NOT NULL, /* 예약시간 */
	hair_no NUMBER(10), /* 헤어번호 */
	de_no NUMBER(10), /* 디자이너 */
	book_regDate DATE DEFAULT SYSDATE,
	book_status NUMBER(1) DEFAULT 1, /* 예약 */
	book_note VARCHAR2(400) /* 예약비고 */
);

ALTER TABLE BOOKING
ADD CONSTRAINT PK_BOOKING PRIMARY KEY (book_no);



/* 주문 */
CREATE TABLE ORDERS (
	orders_no NUMBER(10) NOT NULL, /* 주문번호 */
	orders_date DATE DEFAULT SYSDATE, /* 주문일자 */
	de_no NUMBER(10), /* 디자이너번호 */
	guest_id VARCHAR2(20) /* 고객아이디 */
);

ALTER TABLE ORDERS
ADD CONSTRAINT PK_ORDERS PRIMARY KEY (orders_no);
	
	

/* 주문상세 */
CREATE TABLE ORDER_DETAIL (
	od_no NUMBER(10) NOT NULL, /* 주문상세번호 */
	event_no NUMBER(10), /* 이벤트번호 */
	hair_no NUMBER(10), /* 헤어번호 */
	order_no NUMBER(10) /* 주문번호 */
);

ALTER TABLE ORDER_DETAIL
ADD CONSTRAINT PK_ORDER_DETAIL PRIMARY KEY (od_no);



/* 관리자 */
CREATE TABLE ADMIN (
	admin_id VARCHAR2(20) NOT NULL, /* 관리자아이디 */
	admin_pwd VARCHAR2(30), /* 관리자비번 */
	admin_name VARCHAR2(20) /* 관리자이름 */
);

ALTER TABLE ADMIN
ADD CONSTRAINT PK_ADMIN PRIMARY KEY (admin_id);


/* 디자이너 */
CREATE TABLE DESIGNER (
	de_no NUMBER(10) NOT NULL, /* 번호 */
	de_name VARCHAR2(20), /* 이름 */
	de_nickname VARCHAR2(20), /* 닉네임 */
	de_level VARCHAR2(20), /* 직위 */
	de_pic varchar2(200), /* 사진 */
	de_content VARCHAR2(1000), /* 글 */
	use_yn CHAR(1) DEFAULT 'y'/* 가능여부 */
);

ALTER TABLE DESIGNER
ADD CONSTRAINT PK_DESIGNER PRIMARY KEY (de_no);


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
	res_Yn CHAR(1) DEFAULT 'n', /* 처리완료여부 */
	qna_refNo NUMBER(10), /* 고객문의번호 */
	notice_yn CHAR(1) DEFAULT 'n', /* 공지사항여부 */
	del_yn CHAR(1) DEFAULT 'n' ,/* 삭제여부 */
	qna_secret char(1) DEFAULT 'n',
	qna_password varchar2(100)
);


/*비밀글 여부*/
/*ALTER TABLE QNA ADD qna_secret char(1) DEFAULT 'n';*/
/*비밀 번호(비회원일때만)*/
/*ALTER TABLE QNA ADD qna_password varchar2(100);*/


--공지사항확인 추가
/*alter table qna add notice_yn char(1) default 'n';*/

ALTER TABLE QNA
ADD CONSTRAINT PK_QNA PRIMARY KEY (qna_no);


/* 보유쿠폰 */
CREATE TABLE COUPON (
	coupon_id VARCHAR2(2) NOT NULL, /* 쿠폰 아이디 */
	guest_id VARCHAR2(20) NOT NULL, /* 고객아이디 */
	event_no NUMBER(10) NOT NULL, /* 이벤트번호 */
	event_start DATE, /* 시작일 */
	event_end DATE, /* 종료일 */
	use_Yn CHAR(1) DEFAULT 'n'/* 사용여부 */
);

ALTER TABLE COUPON
ADD CONSTRAINT PK_COUPON PRIMARY KEY (coupon_id);

-- coupon에 이미지 경로 넣기


/* 헤어게시판 */
CREATE TABLE HAIR_BOARD (
	hboard_no NUMBER(10) NOT NULL, /* 글번호 */
	hboard_cateno NUMBER(10), /* 카테고리 코드 */
	hboard_title VARCHAR2(100), /* 제목 */
	hair_no NUMBER(10), /* 헤어번호 */
	hboard_content VARCHAR2(1000), /* 내용 */
	hboard_pic varchar2(200), /* 사진 */
	hboard_regDate DATE DEFAULT SYSDATE/* 작성일 */
);

ALTER TABLE HAIR_BOARD
ADD CONSTRAINT PK_HAIR_BOARD PRIMARY KEY (hboard_no);


/* 헤어게시판 카테고리 */
CREATE TABLE HB_CATEGORY (
	hb_cateno NUMBER(10) NOT NULL, /* 카테고리 코드 */
	HB_cateName VARCHAR2(20) /* 카테고리 이름 */
);

ALTER TABLE HB_CATEGORY
ADD CONSTRAINT PK_HB_CATEGORY PRIMARY KEY (hb_cateno);


/* 예약헤어정보 */
CREATE TABLE BOOKING_HAIRS (
	hair_no NUMBER(10) NOT NULL, /* 헤어번호 */
	book_no NUMBER(10) NOT NULL /* 예약번호 */
);

ALTER TABLE BOOKING_HAIRS ADD CONSTRAINT PK_BOOKING_HAIRS
		PRIMARY KEY (
			hair_no,
			book_no
		);



/* 제약 조건 */
ALTER TABLE HAIR
ADD CONSTRAINT FK_HAIR_KIND_TO_HAIR FOREIGN KEY (kind_no)
		REFERENCES HAIR_KIND (kind_no);

ALTER TABLE BOOKING
ADD	CONSTRAINT FK_HAIR_TO_BOOKING FOREIGN KEY (hair_no)
		REFERENCES HAIR (hair_no);

ALTER TABLE BOOKING
ADD CONSTRAINT FK_GUEST_TO_BOOKING FOREIGN KEY (guest_id)
		REFERENCES GUEST (guest_id);

ALTER TABLE BOOKING
ADD CONSTRAINT FK_DESIGNER_TO_BOOKING FOREIGN KEY (de_no)
		REFERENCES DESIGNER (de_no);
	
ALTER TABLE ORDER_DETAIL
ADD CONSTRAINT FK_EVENT_TO_ORDER_DETAIL FOREIGN KEY (event_no)
		REFERENCES EVENT (event_no);

ALTER TABLE ORDER_DETAIL
ADD CONSTRAINT FK_HAIR_TO_ORDER_DETAIL FOREIGN KEY (hair_no)
		REFERENCES HAIR (hair_no);

ALTER TABLE ORDER_DETAIL
ADD CONSTRAINT FK_ORDER_TO_ORDER_DETAIL FOREIGN KEY (order_no)
		REFERENCES ORDERS (orders_no);

ALTER TABLE QNA
ADD CONSTRAINT FK_QNA_TO_QNA FOREIGN KEY (qna_refNo)
		REFERENCES QNA (qna_no);

ALTER TABLE QNA
ADD CONSTRAINT FK_GUEST_TO_QNA FOREIGN KEY (guest_id)
		REFERENCES GUEST (guest_id);

ALTER TABLE QNA
ADD CONSTRAINT FK_ADMIN_TO_QNA FOREIGN KEY (admin_id)
		REFERENCES ADMIN (admin_id);

ALTER TABLE ORDERS
ADD CONSTRAINT FK_DESIGNER_TO_ORDERS FOREIGN KEY (de_no)
		REFERENCES DESIGNER (de_no);

ALTER TABLE ORDERS
ADD	CONSTRAINT FK_GUEST_TO_ORDERS FOREIGN KEY (guest_id)
		REFERENCES GUEST (guest_id);
		
ALTER TABLE COUPON
ADD CONSTRAINT FK_GUEST_TO_COUPON FOREIGN KEY (guest_id)
		REFERENCES GUEST (guest_id);

ALTER TABLE COUPON
ADD CONSTRAINT FK_EVENT_TO_COUPON FOREIGN KEY (event_no)
		REFERENCES EVENT (event_no);

ALTER TABLE HAIR_BOARD
ADD CONSTRAINT FK_HAIR_TO_HAIR_BOARD FOREIGN KEY (hair_no)
		REFERENCES HAIR (hair_no);

ALTER TABLE HAIR_BOARD
ADD CONSTRAINT FK_HB_CATEGORY_TO_HAIR_BOARD FOREIGN KEY (hboard_cateno)
		REFERENCES HB_CATEGORY (hb_cateno);
		

ALTER TABLE BOOKING_HAIRS
ADD CONSTRAINT FK_HAIR_TO_BOOKING_HAIRS
	FOREIGN KEY (
		hair_no
	)
	REFERENCES HAIR (
		hair_no
	);

-- transaction 삽입 때문에 막음.
/*
ALTER TABLE BOOKING_HAIRS
ADD CONSTRAINT FK_BOOKING_TO_BOOKING_HAIRS
	FOREIGN KEY (
		book_no
	)
	REFERENCES BOOKING (
		book_no
	);
*/

ALTER TABLE BOOKING_HAIRS
DROP CONSTRAINT fk_booking_to_booking_hairs;