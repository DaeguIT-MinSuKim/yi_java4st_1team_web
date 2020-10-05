<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script src="../package/swiper-bundle.min.js"></script>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<style>

.swiper-container {
	    width: 100%;
	    height: 100%;
	} 
	
.swiper-slide {
      text-align: center;
      font-size: 18px;
      background: #fff;

      /* Center slide text vertically */
      display: -webkit-box;
      display: -ms-flexbox;
      display: -webkit-flex;
      display: flex;
      -webkit-box-pack: center;
      -ms-flex-pack: center;
      -webkit-justify-content: center;
      justify-content: center;
      -webkit-box-align: center;
      -ms-flex-align: center;
      -webkit-align-items: center;
      align-items: center;
    }

.swiper-button-next {color:gray;}
.swiper-button-prev {color:gray;}

.swiper-pagination-bullet {
    width: 18px;
    height: 18px;
    display: inline-block;
    border-radius: 100%;
    background: gray;
    opacity: 0.2;
}



.swiper-pagination-fraction,
.swiper-pagination-custom,
.swiper-container-horizontal > .swiper-pagination-bullets {
    bottom: 10px;
    left: 0;
    width: 100%;
}
/* Bullets */
.swiper-pagination-bullets-dynamic {
    overflow: hidden;
    font-size: 0;
}
.swiper-pagination-bullets-dynamic .swiper-pagination-bullet {
    transform: scale(0.33);
    position: relative;
}
.swiper-pagination-bullets-dynamic .swiper-pagination-bullet-active {
    transform: scale(1);
}
.swiper-pagination-bullets-dynamic .swiper-pagination-bullet-active-main {
    transform: scale(1);
}
.swiper-pagination-bullets-dynamic .swiper-pagination-bullet-active-prev {
    transform: scale(0.66);
}
.swiper-pagination-bullets-dynamic .swiper-pagination-bullet-active-prev-prev {
    transform: scale(0.33);
}
.swiper-pagination-bullets-dynamic .swiper-pagination-bullet-active-next {
    transform: scale(0.66);
}
.swiper-pagination-bullets-dynamic .swiper-pagination-bullet-active-next-next {
    transform: scale(0.33);
}
.swiper-pagination-bullet {
    width: 18px;
    height: 18px;
    display: inline-block;
   	border-radius: 100%;
    background: #ccc;
    opacity: 0.2;
}
button.swiper-pagination-bullet {
    border: none;
    margin: 0;
    padding: 0;
    -webkit-box-shadow: none;
    box-shadow: none;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
}
.swiper-pagination-clickable .swiper-pagination-bullet {
    cursor: pointer;
}
.swiper-pagination-bullet-active {
    opacity: 1;
    background: gray;
}
.swiper-container-horizontal > .swiper-pagination-bullets .swiper-pagination-bullet {
    margin: 0 4px;
}

</style>

<script>
$(function(){
	var swiper = new Swiper('.swiper-container', {
		  autoplay:{ 
	            delay:2000
	        },
	      loop:true, // 자동 슬라이드 무한 루프
	      autoplayDisableOnInteraction:false, // 마우스로 autoplay 정지 막음
 
		navigation: {
	       nextEl: '.swiper-button-next',
	       prevEl: '.swiper-button-prev',
	     },
	     pagination: {
	         el: '.swiper-pagination'
	       },
	       keyboard: true,
	       
	});
});
</script>
<div class="main">
<section class="slider">
<div class="swiper-container">
<div class="swiper-wrapper">
     <div class="swiper-slide"><img src="http://placehold.it/1900x900?text=1" alt=""></div>
     <div class="swiper-slide"><img src="http://placehold.it/1900x900?text=2" alt=""></div>
     <div class="swiper-slide"><img src="http://placehold.it/1900x900?text=3" alt=""></div>
     <div class="swiper-slide"><img src="http://placehold.it/1900x900?text=4" alt=""></div>
    
    
   </div>
   <!-- Add Arrows -->
   <div class="swiper-button-next"></div>
   <div class="swiper-button-prev"></div>
   
   <!-- Add Pagination -->
    <div class="swiper-pagination"></div>


</div>

</section>
</div>
