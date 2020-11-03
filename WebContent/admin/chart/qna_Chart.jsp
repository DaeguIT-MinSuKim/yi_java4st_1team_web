<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/header.jsp"%>
<h1 class="h3 mb-2 text-gray-800 font-weight">Q&A Chart</h1>
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
				title : 'QnA Day',
				height : '100%',
				width : '100%',
				curveType: 'function',
			    legend: { position: 'bottom' },
				backgroundColor: "transparent"
			};
			
			var options2 = {
				title : 'QnA Result',
				height : '100%',
				width : '100%',
				pieHole: 0.4,
				backgroundColor: "transparent"
			};
			
			var qnaTable = google.visualization.arrayToDataTable(${qna});
	
			var objDiv = document.getElementById('myChart1');
			var chart = new google.visualization.LineChart(objDiv);
			chart.draw(qnaTable, options1);
			
			
			var resTable = google.visualization.arrayToDataTable(${res})
			
			var objDiv = document.getElementById('myChart2');
			var chart = new google.visualization.PieChart(objDiv);
			chart.draw(resTable, options2);
		}
});

</script>
<div class="card shadow mb-4" style="width: 80%; margin: 0 auto;">
	<div class="card-body" >
		<div id="myChart1" style="width: 500px; height: 300px;"></div>
		<div id="myChart2" style="width: 500px; height: 300px;"></div>
	</div>
</div>


<%@ include file="../include/footer.jsp"%>
