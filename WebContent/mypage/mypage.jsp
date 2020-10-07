<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ include file="../header.jsp" %>  
    <%@ include file="sub_menu.jsp" %>  
<!-- 회원정보 예약내역 이용내역 문의내역 -->

<style>

.main {
	margin-top:50px;
	text-align: center;
	background: #ffffff;
}

/*버튼 별 컨텐트 보이기*/
section {
	display: none;
	padding: 20px 0 0;
	border-top: 1px solid #ddd;
}


/*라디오버튼 숨김*/
input {
	display: none;
}

label {
	width: 200px;
	display: inline-block;
	margin: 0;
	padding: 20px;
	font-weight: 600;
	font-size:20px;
	text-align: center;
	color: #bbb;
	border: 1px solid transparent;
}

label:hover {
	color: black;
	cursor: pointer;
}

input:checked+label {
	color: black;
	border: 1px solid #ddd;
	border-top: 2px solid gray;
	border-bottom: 1px solid #ffffff;
}

/*뉼렀을때*/
#tab1:checked ~ #user_info, 
#tab2:checked ~ #user_book,
#tab3:checked ~ #user_order,
#tab4:checked ~ #user_qna
 {
	display: block;
}


</style>
 <body>
 <div class="main">

    <input id="tab1" type="radio" name="tabs" checked>
    <label for="tab1">회원 정보</label>

    <input id="tab2" type="radio" name="tabs">
    <label for="tab2">예약 내역</label>
    
    <input id="tab3" type="radio" name="tabs"> 
    <label for="tab3">이용 내역</label>
    
    <input id="tab4" type="radio" name="tabs">
    <label for="tab4">문의 내역</label>

	<!-- 각 탭 content -->
    <section id="user_info">
        <div class="">
      	<p>회원정보</p>
    	</div>
    
    </section>
	
    <section id="user_book">
    	<div class="">
      	<p>예약내역</p>
    	</div>
	</section>
	
    <section id="user_order">
    	<div class="">
      	<p>이용내역</p>
    	</div>
	</section>
	
    <section id="user_qna">
	    <div class="">
	      	<p>문의내역</p>
	    </div>
	</section>

</div>

</body>
<%@ include file="../footer.jsp" %> 