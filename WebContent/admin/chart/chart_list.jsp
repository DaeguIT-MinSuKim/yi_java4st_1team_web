<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	// Load Charts and the corechart package.
	google.charts.load('current', {
		'packages' : [ 'corechart' ]
	});

	google.charts.setOnLoadCallback(drawChart);

	google.charts.setOnLoadCallback(drawChart2);

	google.charts.setOnLoadCallback(drawChart3);
	
	google.charts.setOnLoadCallback(drawChart4);

	function drawChart() {

		var data = [ [ '원소', '밀도' ], [ '구리', 8.94 ], [ '은', 10.49 ],
				[ '금', 19.30 ], [ '백금', 21.45 ], ];
		var options = {
			title : '귀금속 밀도 (단위: g/cm³)',
		};

		var chart = new google.visualization.ColumnChart(document
				.getElementById('myChart'));
		chart.draw(google.visualization.arrayToDataTable(data), options);

	}

	function drawChart2() {

		var data = new google.visualization.DataTable();
		data.addColumn('string', 'Foods');
		data.addColumn('number', '비중');

		data.addRows([ [ '피자', 5 ], [ '치킨', 2 ], [ '햄버거', 3 ] ]);
		var opt = {
			'title' : '좋아하는 음식',
			pieSliceText : 'label',
			legend : 'none'
		};

		var chart = new google.visualization.PieChart(document
				.getElementById('myChart2'));
		chart.draw(data, opt);

	}

	function drawChart3() {

		var data = google.visualization.arrayToDataTable([
				[ 'Year', 'Sales', 'Expenses' ], [ '2004', 1000, 400 ],
				[ '2005', 1170, 460 ], [ '2006', 660, 1120 ],
				[ '2007', 1030, 540 ] ]);

		var options = {
			title : 'Company Performance',
			curveType : 'function',
			legend : {
				position : 'bottom'
			}
		};

		var chart = new google.visualization.LineChart(document
				.getElementById('myChart3'));

		chart.draw(data, options);
	}
	
	function drawChart4() {

		var options = {
			title : 'QnA Day',
			height : '100%',
			width : '100%',
			pieHole: 0.4,
			hAxis : {
				title : 'Day',
				titleTextStyle : {
					color : 'black'
				}
			}
		};
		
		var qnaTable = google.visualization.arrayToDataTable(${qnaArray});

		var objDiv = document.getElementById('myChart4');
		var chart = new google.visualization.PieChart(objDiv);
		chart.draw(qnaTable, options);
		
	};
</script>
<h1>예시 차트</h1>

<div id="myChart" style="width: 900px; height: 500px;"></div>

<div id="myChart2" style="width: 900px; height: 500px;"></div>

<div id="myChart3" style="width: 900px; height: 500px;"></div>

<div id="myChart4" style="width: 900px; height: 500px;"></div>

<h1>차트 사용</h1>

<table class="columns">
	<tr>
		<td><div id="piechart_div" style="border: 1px solid #ccc"></div></td>
		<td><div id="barchart_div" style="border: 1px solid #ccc"></div></td>
	</tr>
</table>

<!-- var data = new google.visualization.DataTable();
data.addColumn('string', 'Foods'); data.addColumn('number', '비중');

data.addRows([ [ '피자', 5 ], [ '치킨', 2 ], [ '햄버거', 3 ] ]); var opt = {
'title' : '좋아하는 음식', pieSliceText : 'label', legend : 'none' };

	var chart = new google.visualization.PieChart(document
				.getElementById('myChart'));
		chart.draw(data, opt); -->

<%@ include file="../include/footer.jsp"%>