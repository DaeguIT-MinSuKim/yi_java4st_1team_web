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
</style>

<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
$(function(){
			google.charts.load('current', {
				'packages' : [ 'corechart' ]
			});
		
			google.charts.setOnLoadCallback(drawChart);
		
		function drawChart(){

			var options1 = {
				title : 'Guest Join',
				height : '100%',
				width : '100%',
				curveType: 'function',
			    legend: { position: 'bottom' },
				backgroundColor: "transparent"
			};
			
			var options2 = {
				title : 'Guest Gender',
				height : '100%',
				width : '100%',
				pieHole: 0.4,
				backgroundColor: "transparent"
			};
			
			var options3 = {
				title : 'Guest Out',
				height : '100%',
				width : '100%',
				pieHole: 0.4,
				backgroundColor: "transparent"
			};
			
			var qnaTable = google.visualization.arrayToDataTable(${join});
	
			var objDiv = document.getElementById('myChart1');
			var chart = new google.visualization.LineChart(objDiv);
			chart.draw(qnaTable, options1);
			
			
			var resTable = google.visualization.arrayToDataTable(${gender})
			
			var objDiv = document.getElementById('myChart2');
			var chart = new google.visualization.PieChart(objDiv);
			chart.draw(resTable, options2);
			
			var seTable = google.visualization.arrayToDataTable(${out})
			
			var objDiv = document.getElementById('myChart3');
			var chart = new google.visualization.PieChart(objDiv);
			chart.draw(seTable, options3);
		}
});

/* $(document).on('click','[id=chartSearch]',function(){
	var year = $('#year').val();
	location.href='chartQna.do?year?='+year;
}) */

</script>
<h1 class="h3 mb-2 text-gray-800 font-weight">Q&A Chart</h1>
<br>
<form method="post"> 
	<div class="card shadow mb-4" style="width: 80%; margin: 0 auto;">
		<div class="card-header">
			<select id="year" name="year">
				<option value="all" >전체</option>
				<option value="2020">2020</option>
				<option value="2000">2019</option>
				<option value="2000">2018</option>
			</select> <input type="submit" value="검색" id="chartSearch"
				class="btn btn-primary btn-sm">
		</div>
		<div class="card-body">
			<div id="myChart1" ></div>
			<br><br>
			<hr>
			<div id="myChart2"></div>
			<br><br>
			<hr>
			<div id="myChart3"></div>
			<br><br>
		</div>

	</div>
</form>

<%@ include file="../include/footer.jsp"%>
