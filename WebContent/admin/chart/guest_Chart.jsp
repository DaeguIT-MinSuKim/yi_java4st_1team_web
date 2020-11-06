<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<style>
input {
	margin-right: 20px;
	float: right;
}

select {
	margin-right: 20px;
	float: right;
}

body {
	margin: 0 auto;
}

div.gallery {
	margin-top: 100px;
}
/* div.gallery:hover {border: 1px solid #777;} */
div.gallery img {
	width: 100%;
	height: auto;
}

div.content {
	
}

/*box-sizing: border-box; 지정안하면 padding, border값의 영향을 받아 box 길이값이 틀어지기 때문에 꼭 추가필요.*/
* {
	box-sizing: border-box;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box
}

.responsive {
	display: inline-block;
	width: 30%; /*기본값 3개=30%*/
	vertical-align: top;
	margin: 0 auto;
	text-align: left;
	padding: 20px;
}

/* 사용자 해상도가 700px 이하 일때는 2개씩 나열하기*/
@media only screen and (max-width: 1000px) {
	.responsive {
		width: 40%;
		margin: 6px 0;
	}
}
/*사용자 해상도가 500px 이하 일때는 1개씩 나열*/
@media only screen and (max-width: 600px) {
	.responsive {
		width: 100%;
	}
}

.clearfix:after {
	content: "";
	display: table;
	clear: both;
}

.de_wrapper {
	width: 1200px;
	margin: 0 auto;
}

.de_sub_wrapper {
	width: 1200px;
	margin: 0 auto;
}
</style>
<script src="chart/chart.js"></script>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
$(function(){
	var nowDate = new Date();
	var year = nowDate.getFullYear();
	
	document.getElementById('one').innerHTML = year+'년';
	document.getElementById('one').value = year;
	document.getElementById('two').innerHTML = (year-1)+'년';
	document.getElementById('two').value = year-1;
	document.getElementById('three').innerHTML = (year-2)+'년';
	document.getElementById('three').value = year-2;
	document.getElementById('four').innerHTML = (year-3)+'년';
	document.getElementById('four').value = year-3;
	document.getElementById('five').innerHTML = (year-4)+'년';
	document.getElementById('five').value = year-4;
	 
});



$(function(){
	google.charts.load('current', {
		'packages' : [ 'bar' ]
	});

	google.charts.setOnLoadCallback(drawChart);
	
	function drawChart(){
		
		/* var options2 = {
				title : 'Guest Gender',
				height : '300',
				width : '100%',
				pieHole: 0.4,
				backgroundColor: "transparent"
		}; */
		
		var options3 = {
				title : 'Guest Increase',
				height : '400',
				width : '100%',
				backgroundColor: "transparent"
			};
		
		/* var resTable = google.visualization.arrayToDataTable(${gender});
		
		var objDiv = document.getElementById('myChart2');
		var chart = new google.charts.Bar(objDiv);
		chart.draw(resTable, google.charts.Bar.convertOptions(options2)); */
		
		var seTable = google.visualization.arrayToDataTable(${out})
		
		var objDiv = document.getElementById('myChart3');
		var chart = new google.charts.Bar(objDiv);
		chart.draw(seTable, google.charts.Bar.convertOptions(options3));

	}
	
});
</script>
<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
	<h1 class="h3 mb-0 text-gray-800">Guest Chart</h1>
</div>
<form action="chartGuest.do" method="post">
	<div class="card shadow mb-4" style="width: 1200px;">
		<div class="card-header py-2">
			<h6 class="m-1 font-weight-bold text-primary"
				style="line-height: 16px; font-size: 1.3em">
				<input type="button" value="Guest Chart"
					class="btn btn-success btn-sm"
					style="float: left; margin-right: 10px;"
					onclick="location.href='chartGuest.do' "> <input
					type="button" value="Q&A Chart" class="btn btn-success btn-sm"
					style="float: left; margin-right: 10px;"
					onclick="location.href='chartQna.do' "> <input
					type="button" value="Orders Chart" class="btn btn-success btn-sm"
					style="float: left; margin-right: 10px;"
					onclick="location.href='chartOrders.do' "> <select
					name="year" style="float: right; width: 90px;">
					<option id="one"></option>
					<option id="two"></option>
					<option id="three"></option>
					<option id="four"></option>
					<option id="five"></option>
				</select><select name="month" style="float: right; width: 65px;">
					<option value="">선택</option>
					<option value="1" <c:if test="${month ==  1 }"> selected</c:if>>1월</option>
					<option value="2" <c:if test="${month == 2 }"> selected</c:if>>2월</option>
					<option value="3" <c:if test="${month == 3 }"> selected</c:if>>3월</option>
					<option value="4" <c:if test="${month == 4 }"> selected</c:if>>4월</option>
					<option value="5" <c:if test="${month == 5 }"> selected</c:if>>5월</option>
					<option value="6" <c:if test="${month == 6 }"> selected</c:if>>6월</option>
					<option value="7" <c:if test="${month == 7 }"> selected</c:if>>7월</option>
					<option value="8" <c:if test="${month == 8 }"> selected</c:if>>8월</option>
					<option value="9" <c:if test="${month == 9 }"> selected</c:if>>9월</option>
					<option value="10" <c:if test="${month == 10 }"> selected</c:if>>10월</option>
					<option value="11" <c:if test="${month == 11 }"> selected</c:if>>11월</option>
					<option value="12" <c:if test="${month == 12 }"> selected</c:if>>12월</option>
				</select> <input type="submit" value="검색" class="btn btn-primary btn-sm" style="float: right;">
			</h6>
		</div>
		<!-- <!-- card-body -->
		<div class="card-body">
			<div class="table-responsive">
				<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">

					<hr>
					<div class="row mb-2">
						<div class="col-sm-12 col-md-6" style="float: right;">
							<div id="dataTable_filter" class="dataTables_filter "></div>
						</div>
					</div>
					<div class="card-body">
						<!-- <div id="myChart1"></div>
						<br> <br>
						<hr> -->
						<!-- <div id="myChart2" style="width: 300px; height: 240px;"></div>
						<br> <br>
						<hr> -->
						<div id="myChart3" style="width: 100%; height: 400px;"></div>
						<br> <br>
					</div>
				</div>
			</div>
		</div>
	</div>
</form>



<%@ include file="../include/footer.jsp"%>
