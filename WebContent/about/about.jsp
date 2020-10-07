<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    <%@ include file="../header.jsp" %>  

<style>

p {
	margin: 0 0 20px;
	line-height: 1.5;
}

.main {
	margin-top:50px;
	text-align: center;
	background: #ffffff;
}

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
	width: 300px;
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

/*input 클릭시, label 스타일*/
input:checked+label {
	color: black;
	border: 1px solid #ddd;
	border-top: 2px solid gray;
	border-bottom: 1px solid #ffffff;
}

#tab1:checked ~ #content1, #tab2:checked ~ #content2 {
	display: block;
}

.content2-inner {
	width:800px;
	margin:0 auto;
	
	}

.content1-inner {
	width:800px;
	margin:0 auto;
	text-align:left;
	}
	
.map {width:800px; margin:0 auto; text-align:left;}


.text { width:500px; text-align:left;}

button {width:130px; height:50px; color:black; border:none; font-size:15px; font-weight:bold; float:right; margin:5px; width:200px; background: white; border:1px solid #777;}

.outer {width:800px;}
.tr {padding:50px; border-bottom:1px solid black;}
td {padding:20px; }

.about-img {margin-bottom:-6px; opacity:.20;}

</style>

</head>
<body>

<div class="main">
<div class="main-inner">
    <input id="tab1" type="radio" name="tabs"> <!--디폴트 메뉴-->
    <label for="tab1">소  개</label>

    <input id="tab2" type="radio" name="tabs" checked>
    <label for="tab2">오시는 길</label>

    <section id="content1">
        <div class="content1-inner">
        <p>소개</p>
        <p>소개</p>
        <p>소개</p>
        <p>소개</p>
        <p>소개</p>
        <p>소개</p>
      
    	</div>
    
    </section>
	
    <section id="content2">
    <div class='map'>
    	 <%@ include file="../map.jsp" %>  
    </div>
   <div class="content1-inner">
   <p></p>
   <button type="button" onclick="window.open('https://map.kakao.com/link/map/영남인재교육원,35.861304, 128.556076')">길찾기</button>
   <button type="button" onclick="window.open('https://map.kakao.com/link/to/영남인재교육원,35.861304, 128.556076')">지도에서 보기</button>
        <br><br><br><br>
      <table class="outer">
     	
      <tr class="tr">
       <td><img src="images/time.png" class="about-img">　영업시간</td> 
       <td>AM 10:00 ~ PM 8:30</td>
      </tr>
      <tr class="tr">
       <td><img src="images/map.png" class="about-img">　주소</td>
       <td> 대구광역시 서구 서대구로 7길2</td>
      </tr>
       <tr class="tr">
       <td><img src="images/phone.png" class="about-img">　전화번호</td>
       <td> 053-123-1234</td>
      </tr>
       <tr class="tr">
       <td><img src="images/warning.png" class="about-img">　이용안내</td>
       <td>예약 | 주차  | 무선 인터넷</td>
      </tr>
       <tr>
       <td><img src="images/user.png" class="about-img">　사업자 정보</td>
       <td> 
	       <table style="width:300px;">
	       <tr>
		       <td>상호명</td>
		       <td style="padding:5px;">헤어랑</td>
	       </tr>
	       <tr>
		       <td>대표자</td>
		       <td style="padding:5px;">이지수</td>
	       </tr>
	       <tr>
		       <td>사업자번호</td>
		       <td style="padding:5px;">123-12-12345</td>
	       </tr>
	       </table>
       </td>
      </tr>
        </table>
   </div>
    	
    </section>
</div>
</div>
</body>
<%@ include file="../footer.jsp" %>   