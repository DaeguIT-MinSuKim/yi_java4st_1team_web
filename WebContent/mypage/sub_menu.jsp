<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.main {
	margin-top:50px;
	text-align: center;
	background: #ffffff;
	border-bottom:1px solid #bbb;
}
#sub_menu ul {
}
#sub_menu ul li {
	display: inline-block;
	font-weight: 600;
	font-size:20px;
	text-align: center;
	color: #bbb;	
	
}

#sub_menu ul li a {
	padding:30px 60px;
	text-decoration:none;
	color: #bbb;	
}

/* #sub_menu ul li a:hover {
	 color: black; padding:30px 60px; border: 1px solid #ddd; border-top: 2px solid gray; border-bottom: 1px solid #ffffff;
}
 */

.info a:hover{ color: black; padding:30px 60px; border: 1px solid #ddd; border-top: 2px solid gray; border-bottom: 1px solid #ffffff;}

</style>
<div class="main">
<nav id="sub_menu">
    <ul>
	  <li class="info"><a href="guestInfo.do">회원 정보</a></li>  
	  <li class="book"><a href="guestBook.do">예약 내역</a></li>  
	  <li class="order"><a href="guestOrder.do">이용 내역</a></li> 
	  <li class="qna"><a href="guestQna.do">문의 내역</a></li> 
    </ul>
  </nav>
 </div>