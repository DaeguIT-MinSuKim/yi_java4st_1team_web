<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
<style>

.main {
	background: #ffffff;
	font-size:15px;
}

section {
	display: none;
	padding: 15px 0 0;
	border-top: 1px solid #ddd;
}

/*라디오버튼 숨김*/
.tap {
	display: none;
}

label {
	width: 100px;
	display: inline-block;
	padding: 20px;
	/* font-weight: 600; */
	font-size:15px;
	text-align: center;
	color: #bbb;
	border: 1px solid transparent;
}

label:hover {
	color: black;
	cursor: pointer;
}

/*input 클릭시, label 스타일*/
.tap:checked+label {
	color: black;
	border: 1px solid #ddd;
	border-bottom: 1px solid #ffffff;
}

#tab1:checked ~ #content1, #tab2:checked ~ #content2 {
	display: block;
}

.content2-inner {
	width:450px;
	margin:0 auto;
	
	}

.content1-inner {
	width:450px;
	margin:0 auto;
	text-align:center;
}

input {}


</style>
</head>
<body>
<div class="main">
<div class="main-inner">
<form method=post name=formm style="margin-right:0" action="idpwSearch.do" >
    <input id="tab1" type="radio" name="tabs"checked class="tap"> <!--디폴트 메뉴-->
    <label for="tab1">아이디 찾기</label>

    <input id="tab2" type="radio" name="tabs"  class="tap">
    <label for="tab2">비밀번호 찾기</label>

    <section id="content1">
        <div class="content1-inner">
        <h3>아이디 찾기</h3>
        <p style="size:10px">아이디는 가입 시 입력하신 <br>이름, 이메일을 통해 찾을 수 있습니다.</p><br>
       	<input type="text" name="name" placeholder="이름" style="width:430px; height:30px;">
       	<div class="clear" style="padding:5px;"></div>
       	<input type="text" name="email"  placeholder="이메일" style="width:430px; height:30px;">
       	<br><br>
       	<input type="submit" value="찾기" style="width:420px; border:1px solid black; background:#fff; height:40px;">
       	
    	</div>
    
    </section>
	
    <section id="content2">
    	<div class="content2-inner">
       	비밀번호찾기
    	</div>
    </section>
</form>
</div>
</div>
</body>
</html>