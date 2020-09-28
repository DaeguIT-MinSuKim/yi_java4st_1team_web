<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script
	src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script> 
$(document).ready(function(){
    $('.slider').bxSlider({
    	auto: true,
    	autoHover:true, 
    	autoControls:false,
    	speed:100,
    	pager:true,
    	moveSlides:1,
    	touchEnabled : (navigator.maxTouchPoints > 0) /*링크*/
    });
	});

</script>
<style>
	.sliderWrap {width:98%; margin:0 auto;}
	.slider{
	 	text-align:center;
	}
	.bx-wrapper {position:relative; text-align:center;}
	.bx-controls-direction {font-size:100px;} 
	.bx-controls-direction a {position:absolute; text-decoration:none; top:50%; overflow:hidden; display:block; width:40px; height:100px; font-size:40px; font-weight:normal; color:gray;}
	.bx-controls-direction .bx-prev {left:0;}
	.bx-controls-direction .bx-next {right:0;}
	.bx-controls-direction .bx-prev:before {content:"\e93d"; font-family:'xeicon'; }
	.bx-controls-direction .bx-next:before {content:"\e940"; font-family:'xeicon'}
	
	/*네모*/
	.bx-pager {position:absolute; left:0; bottom:-30px; width:100%; text-align:center; margin:5px;}
	.bx-pager div {background-color:white;display:inline-block; font-size:0; color:transparent; width:30px; height:3px; padding:5px;}
	.bx-pager div a {display:block; font-size:0; color:transparent; width:24px; height:3px; background:gray; }
	.bx-pager div a.active {background:#000;}
</style>
</head>
<body>
<div class="sliderWrap">
<div class="slider">
    <div><a href="about.jsp"><img src="http://placehold.it/1500x900?text=1"></a></div>
    <div><img src="http://placehold.it/1500x900?text=2" alt=""></div>
    <div><img src="http://placehold.it/1500x900?text=3" alt=""></div>
    <div><img src="http://placehold.it/1500x900?text=4" alt=""></div>
    <!-- <i class="xi-angle-left-thin"></i>
    <i class="xi-angle-right-thin"></i> 아이콘 - 콘솔에서 content이름 확인-->
   
  </div>
  </div>
</body>
</html>