<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<script>
	document.title += ' - 예약 목록'
</script>
<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">목록 템플릿</h1>
<p class="mb-4">
	여기에 간단한 설명 추가해주세요. 이렇게 링크도 달아도 됩니다. <a target="_blank"
		href="https://datatables.net">링크</a>
</p>

<!-- DataTales Example -->
<div class="card shadow mb-4">
	<div class="card-header py-2">
		<h6 class="m-1 font-weight-bold text-primary" style="line-height: 16px; font-size: 1.3em">
			리스트 예제
			<a href="#" class="btn btn-danger btn-sm" style="float: right;">
				<span class="text">삭제</span></a>
			<a href="#" class="btn btn-success btn-sm" style="float: right; margin-right: 10px;">
				<span class="text">등록</span></a>
			<a href="#" class="btn btn-secondary btn-sm" style="float: right; margin-right: 10px;">
				<span class="text">전체선택</span></a>
			<a href="#" class="btn btn-outline-secondary btn-sm" style="float: right; margin-right: 10px;">
				<span class="text">선택해제</span></a>
		</h6>
	</div>
	<!-- card-body -->
	<div class="card-body">
		<div class="table-responsive">
			<!-- bootStrap table wrapper-->
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">

				<!-- 테이블 상단 필터링 시작 -->
				<div class="row">
					<div class="col-sm-12 col-md-6">
						<div class="dataTables_length" id="dataTable_length">
							<label> <select name="dataTable_length"
								aria-controls="dataTable"
								class="custom-select custom-select-sm form-control form-control-sm">
									<option value="10">10줄 보기</option>
									<option value="25">25줄 보기</option>
									<option value="50">50줄 보기</option>
									<option value="100">100줄 보기</option>
							</select>
							</label>
						</div>
					</div>
					<div class="col-sm-12 col-md-6">
						<div id="dataTable_filter" class="dataTables_filter ">
							<select class="custom-select custom-select-sm" name="searchCriteria" style="width: 80px;">
								<option value="">기준</option>
							</select>
							<label>
								<input type="search" class="form-control form-control-sm" placeholder="" aria-controls="dataTable">
							</label>
							<a href="#" class="btn btn-primary btn-sm"><span class="text">검색</span>	</a>
						</div>
					</div>
				</div>
				<!-- 테이블 상단 필터링 끝 -->

				<!-- 테이블 시작 -->
				<table class="table table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
					<thead>
						<tr>
							<th style="width: 58px; min-width: 58px; max-width: 58px;">선택</th>
							<th style="width: 100px; min-width: 100px; max-width: 100px;">예약번호</th>
							<th>예약일시</th>
							<th>고객명</th>
							<th>연락처</th>
							<th>시술</th>
							<th>예약상태</th>
							<th style="width: 186px; min-width: 186px; max-width: 186px;"></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="checkbox"></td>
							<td>1</td>
							<td>2020-10-20 오후 2:00</td>
							<td>김뫄뫄</td>
							<td>010-1234-5678</td>
							<td>[1]디자인 컷</td>
							<td>예약완료</td>
							<td><a href="#" class="btn bg-gray-200 btn-sm"><span class="text-gray-800">상세보기</span></a>
								<a href="#" class="btn btn-info btn-sm"><span class="text">수정</span></a>
								<a href="#" class="btn btn-danger btn-sm"><span class="text">삭제</span></a>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- 테이블 끝 -->
				
				<!-- 페이징 시작 -->
				<div class="row">
					<div class="col-sm-12 col-md-5">
						<div class="dataTables_info" id="dataTable_info" role="status"
							aria-live="polite">전체 23개 중 1-10</div>
					</div>
					<div class="col-sm-12 col-md-7">
						<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
							<ul class="pagination">
								<li class="paginate_button page-item previous disabled" id="dataTable_previous">
									<a href="#" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">이전</a></li>
								<li class="paginate_button page-item active">
									<a href="#" aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">1</a></li>
								<li class="paginate_button page-item ">
									<a href="#" aria-controls="dataTable" data-dt-idx="2" tabindex="0" class="page-link">2</a></li>
								<li class="paginate_button page-item ">
									<a href="#" aria-controls="dataTable" data-dt-idx="3" tabindex="0" class="page-link">3</a></li>
								<li class="paginate_button page-item next" id="dataTable_next">
									<a href="#" aria-controls="dataTable" data-dt-idx="4" tabindex="0" class="page-link">다음</a>
								</li>
							</ul>
						</div>
					</div>
					<!-- 페이징 -->
				</div>
				<!-- bootStrap table wrapper-->
			</div>
			<!-- tableRespnsible -->
		</div>
		<!-- cardBody-->
	</div>
</div>

<%@ include file="../include/footer.jsp"%>
