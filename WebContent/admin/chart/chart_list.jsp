<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<style>
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
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
$(function(){
			// Load Charts and the corechart package.
			google.charts.load('current', {
				'packages' : [ 'corechart' ]
			});
		
			google.charts.setOnLoadCallback(drawChart);
		
		function drawChart(){
		
				var options1 = {
				title : 'Join Guest',
				height : '100%',
				width : '100%',
				curveType: 'function',
			    legend: { position: 'bottom' },
				backgroundColor: "transparent"
			};
			var options2 = {
				title : 'Gender',
				height : '100%',
				width : '100%',
				pieHole: 0.4,
				backgroundColor: "transparent"
			};
	/* 		var options3 = {
				title : 'Booking Time',
				height : '100%',
				width : '100%',
				pieHole: 0.4,
				hAxis : {
					title : '예약 수',
					titleTextStyle : {
						color : 'black'
					}
				}
			}; */
			var options4 = {
				title : 'QnA Day',
				height : '100%',
				width : '100%',
				curveType: 'function',
			    legend: { position: 'bottom' },
				backgroundColor: "transparent"
				
			};
/* 	 		var options5 = {
				title : 'Orders Day',
				height : '100%',
				width : '100%',
				pieHole: 0.4,
				hAxis : {
					title : '주문 수',
					titleTextStyle : {
						color : 'black'
					}
				}
			};  */
			
			var joinTable = google.visualization.arrayToDataTable(${joinGuest});
			var genderTable = google.visualization.arrayToDataTable(${gender});
	/* 		var bookingTimeTable = google.visualization.arrayToDataTable(${bookingTime}); */
			var qnaTable = google.visualization.arrayToDataTable(${qnaArray});
	/* 		var ordersDayTable = google.visualization.arrayToDataTable(${ordersDay}); */
	
			var objDiv = document.getElementById('myChart1');
			var chart = new google.visualization.LineChart(objDiv);
			chart.draw(joinTable, options1);
			
			var objDiv = document.getElementById('myChart2');
			var chart = new google.visualization.PieChart(objDiv);
			chart.draw(genderTable, options2);
			
	/* 		var objDiv = document.getElementById('myChart3');
			var chart = new google.visualization.PieChart(objDiv);
			chart.draw(qnaTable, options3); */
			
			var objDiv = document.getElementById('myChart4');
			var chart = new google.visualization.LineChart(objDiv);
			chart.draw(qnaTable, options4);
			
	 /* 		var objDiv = document.getElementById('myChart5');
			var chart = new google.visualization.PieChart(objDiv);
			chart.draw(ordersDayTable, options5); */
			 
	}
});

</script>
<!-- Page Heading -->
<form name="formm">
	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-2">
			<div class="mt-1 float-left">
				<h6 class="m-1 font-weight-bold text-primary"
					style="font-size: 1.3em">차트 관리</h6>
			</div>
		</div>
		<!-- card-body -->
		<div class="card-body">
			<div class="table-responsive">
				<!-- bootStrap table wrapper-->
				<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
					<div class="de_wrapper">
						<div class="de_sub_wrapper">
							<div style="width: 1200px; margin-left: 30px;">

								<div class="responsive">
									<!-- 사진 하나 -->
									<div class="gallery">
										<div id="myChart1" style="width: 500px; height: 300px;"></div>
										<!--  </a> -->
										<div class="content">
											<span style="font-weight: bold; text-align: left"
												class="tleft">Join Guest</span>
										</div>

									</div>
									<!-- 사진 하나 -->
									<div class="gallery">
										<div id="myChart2" style="width: 500px; height: 300px;"></div>
										<!--  </a> -->
										<div class="content">
											<span style="font-weight: bold; text-align: left"
												class="tleft">Gender</span>
										</div>

									</div>
									<!-- 사진 하나 -->
									<div class="gallery">
										<div id="myChart4" style="width: 500px; height: 300px;"></div>
										<!--  </a> -->
										<div class="content">
											<span style="font-weight: bold; text-align: left"
												class="tleft">QnA</span>
										</div>

									</div>
								</div>

							</div>
						</div>
					</div>
				</div>
				<!-- bootStrap table wrapper-->
			</div>
			<!-- tableRespnsible -->
		</div>
		<!-- cardBody-->
	</div>
	<input type="button" value="qna" src="qnaChart.do">
</form>


<%@ include file="../include/footer.jsp"%>