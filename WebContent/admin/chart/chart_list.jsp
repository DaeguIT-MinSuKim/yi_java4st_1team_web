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

.col-sm-12 col-md-6 {
	
}
</style>



<!-- Page Heading -->
<div class="d-sm-flex align-items-center justify-content-between mb-4">
	<h1 class="h3 mb-0 text-gray-800">공지사항 관리 - 공지사항 목록</h1>
</div>
<form method="get" name="formm">
	<div class="card shadow mb-4">
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
					onclick="location.href='chartOrders.do' ">
			</h6>
		</div>
		<!-- card-body -->
		<div class="card-body">
			<div class="table-responsive">
				<!-- bootStrap table wrapper-->
				<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">
					<!-- 테이블 상단 필터링 시작 -->
					<div class="row m-0 mb-2">
						<div class="col-sm-12 col-md-12 p-0">
							<div class="form-inline justify-content-center">
								<i class="far fa-calendar-alt mr-3" style="font-size: 22px;"></i>
								<div class="input-group input-group-sm mr-3">
									<div class="input-group-prepend">
										<input type="text" class="form-control" id="startDate"
											name="startDate" style="width: 120px;" placeholder="시작일">
									</div>
									<div class="input-group-prepend">
										<label class="input-group-text">~</label>
									</div>
									<input type="text" class="form-control" id="endDate"
										name="endDate" style="width: 120px;" placeholder="종료일">
								</div>
								<button type="submit" class="form-control btn-primary btn-sm"
									id="dateBtn">조회</button>
							</div>
						</div>
					</div>
					<div class="row m-0">
						<div class="col-sm-12 col-md-12 p-0">
							<div class="form-inline justify-content-center"
								style="height: 32px;">
								<div class="btn-group btn-group-sm" role="group"
									aria-label="Basic example">
									<button type="button"
										class="btn btn-sm btn-outline-secondary dateBtn" value="1"
										id="todayBtn">오늘</button>
									<button type="button"
										class="btn btn-sm btn-outline-secondary dateBtn" value="7"
										id="aWeekBtn">1주</button>
									<button type="button"
										class="btn btn-sm btn-outline-secondary dateBtn" value="14"
										id="twoWeeksBtn">2주</button>
									<button type="button"
										class="btn btn-sm btn-outline-secondary dateBtn" value="31"
										id="aMonthBtn">1개월</button>
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
</form>

<%@ include file="../include/footer.jsp"%>

