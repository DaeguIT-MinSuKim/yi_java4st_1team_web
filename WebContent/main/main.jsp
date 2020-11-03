<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/header.jsp" %>  

<script>
   /*전체적용 할 페이지에 이거 쓰면됨~~~~~*/
   $(function(){
	   if ($(".main").length > 0 ){
	      $("#wrapper").css({width:'100%'});
	      $("#wrapper").css({margin:'96px auto'});    
	   }
   })
   
  
</script>
<script src="../package/swiper-bundle.min.js"></script>
<style>
	img {margin-bottom:-6px;}
	.main {text-align:center; margin:0 auto;}
	.more {margin:0 auto; border:2px solid gray; width: 90px;}
	.more a { text-align:center;text-decoration:none; color:gray; font-size:20px; font-weight:bold;}

/* /* Banner */

	#banner {
		padding: 22em 0 10em 0;
		background-image: url('images/main3.jpg');
		background-size: 100%;
		background-position: top;
		background-attachment: fixed;
		background-repeat: no-repeat;
		text-align: center;
		border-top: 0.5em solid #5385c1;
		
	}

	#banner h1 {
			font-size: 2em;
			font-weight: 100;
			color: #fff;
			line-height: 1em;
			margin: 0 0 0.5em 0;
			padding: 0;
		}

	#banner p {
			font-size: 1em;
			color: rgba(255, 255, 255, 0.55);
			margin-bottom: 1.75em;
		}
	
	@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) and (orientation: landscape) {

		#banner {
				background-attachment: scroll;
			}

		}

		@media screen and (max-width: 1280px) {

			#banner {
				padding: 8em 2em 8em 2em;
			}

		}

		@media screen and (max-width: 980px) {

			#banner {
				background-attachment: scroll;
			}

		}

		@media screen and (max-width: 736px) {

			#banner {
				padding: 8em 1.5em 6em 1.5em;
			}

				#banner h1 {
					font-size: 2.5em;
				}

				#banner p {
					font-size: .9em;
				}

		}

		@media screen and (max-width: 480px) {

			#banner {
				padding: 3em 1.5em 4em 1.5em;
			}

		}

</style>

<div class="main">

<section class="slider">
<%-- <%@ include file="/slider.jsp" %>   --%>
<%-- <%@ include file="/slider2.jsp" %> --%>
<!-- <img src="images/main.jpg" width="100%"> -->
</section>

<section id="banner">
		<h1>Find your self,</h1>
		<p>with Rang hair designers group.</p>
		<div style="border:3px solid white; width:150px; padding:10px; margin:0 auto; border-radius:10px; color:white; font-weight:bold;cursor:pointer" onclick="location.href='booking.do'" ">
			RESERVATION
		</div>
</section>
<br>
<br>

<!-- 
<a href="qnaList.do">QnaTest</a> -->
<br>
공지넣기??
<div id="insta">
<p style="font-size:30px; font-weight:600">#INSTAGRAM</p><br>
<img src="images/insta_mini.png"><span style="clear:both;font-size:15px; font-weight:600;"> hairrang_official</span><br><br>
<%@ include file="/insta.jsp" %>


<br><br>
<div class="more"><a href="http://instagram.com/hairrang_official"  target="_blank">MORE</a></div>
<br><br><br><br><br>

</div>
</div>
<%@ include file="/footer.jsp" %>   