
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<script>
//start날짜보다 큰 end날짜 선택

function date_check(){
	var start = $("#startDate").val();
	var end = $("#endDate").val();
	$("#endDate").attr("min", start)
}


//이미지 미리보기
$(function() {
		$("#file").on('change', function() {
			readURL(this);
		});
	});
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();

			reader.onload = function(e) {
				$('#img').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	
function event_info(){
		alert('이벤트가 수정되었습니다.');
		document.formm.action = "eventInfo.do?no=" + ${event.eventNo};
	    document.formm.submit();
}	


</script>

<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">이벤트 관리 - 이벤트 수정</h1>
<p class="mb-4">
</p>
<form method="post" name="formm" enctype="Multipart/form-data">
<!-- DataTales Example -->
<div class="card shadow mb-4" style="width:700px">
	<div class="card-header py-2">
		<h6 class="m-1 font-weight-bold text-primary" style="line-height: 16px; font-size: 1.3em">
		</h6>
	</div>
	<!-- card-body -->
	<div class="card-body">
		<div class="table-responsive">
			<!-- bootStrap table wrapper-->
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">


		<div id="add-wrapper">
		
			<table class="add-table">
				<tr>
					<td>번호</td>
					<td>${event.eventNo}<input type="hidden" name="no" value="${event.eventNo}"></td>
				</tr>
				<tr>
					<td>이벤트명</td>
					<td><input type="text" name="name" value="${event.eventName }"> </td>
				
				</tr>
				<tr>
					<td>이벤트 상태</td>
					<td>
						<c:if test="${event.eventStatus == 's'}">
							<div class="btn-info btn-sm" style="width:80px;text-align:center;">진행중</div>
							</c:if>
						<c:if test="${event.eventStatus == 'e'}">
							<div class="btn-secondary btn-sm" style="width:80px; text-align:center;">종료</div>
						</c:if>
							<c:if test="${event.eventStatus == 'w'}">
							<div class="btn-warning btn-sm" style="width:80px; text-align:center;">대기중</div>
							</c:if>
					</td>
					
				</tr>
				<tr>
					<td>이벤트 내용</td>
					<td> <input type='text' name="content" value="${event.eventContent}" style="height:60px;"/></td>
				</tr>
				
				<tr>
					<td>할인율(%)</td>
					<td>
					<input type="text" name="saleRate" value="<fmt:parseNumber value="${event.eventSaleRate * 100}" integerOnly="true"/>" />
					</td>

				</tr>
				<tr>
				<td>이벤트 시작일</td>
					<td> <input type='date' name="start" max="9999-12-31" id="startDate" onchange="date_check()" value="${event.eventStart}"/></td>
				<tr>
				<td>이벤트 종료일</td>
					<td><input type='date' name="end" max="9999-12-31" id="endDate" onchange="date_check()" value="${event.eventEnd}" /></td>
				</tr>
				<tr>
					<td>파일 선택</td>
					<td><input type='file' name="file" id="file"/></td>
				</tr>
				
			</table>
			<div style="text-align:center">
				<p style="padding:10px;">미리보기 </p>
				<img id="img" src="../event/images/${event.eventPic}" alt="" width=30%/>
			</div>
			<br><br>
			<div class="clear"></div>
			<br>
			<div class="add-buttons" style="float:right">
			${event.eventPic}
				<input type="button" value="수정" onclick="event_info()" class="btn btn-primary btn-sm">
				<input type="reset" value="취소" class="btn btn-light btn-sm" onclick="location.href='eventList.do'">
				
			</div>		
			</div>
				</div>
				<!-- bootStrap table wrapper-->
			</div>
			<!-- tableRespnsible -->
		</div>
		<!-- cardBody-->
	</div>

</form>

<%@ include file="../include/footer.jsp" %>