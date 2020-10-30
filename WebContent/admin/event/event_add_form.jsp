
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<script>
//오늘날짜 셋
$(document).ready( function() {
    var now = new Date();
    var month = (now.getMonth() + 1);               
    var day = now.getDate();
    if (month < 10) 
        month = "0" + month;
    if (day < 10) 
        day = "0" + day;
    var today = now.getFullYear() + '-' + month + '-' + day;
    $('#start').val(today);
    $('#end').val(today);
});

//오늘날짜 전 선택불가 넣기



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
	
	
function event_add(){
		alert('이벤트가 등록되었습니다.');
		document.formm.action = "eventAdd.do";
	    document.formm.submit();
}	

</script>

<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">이벤트 관리 - 이벤트 등록</h1>
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
					<td>이벤트명</td>
					<td><input type="text" name="name" /> 
				</tr>
				<tr>
					<td>이벤트 내용</td>
					<td> <input type='text' name="content" style="height:60px;"/></td>
				</tr>
				
				<tr>
					<td>할인율(%)</td>
					<td><input type="text" name="saleRate"/></td>
				</tr>
				
				<tr>
					<td>이벤트 시작일</td>
					<td> <input type='date' name="start" id="start"/></td>
				</tr>
				
				<tr>
					<td>이벤트 종료일</td>
					<td> <input type='date' name="end" id="end"/>
						<p style="padding-top:10px;">※ 선택한 날짜의 23시 59분 59초까지 적용</p>
					</td>
				
				</tr>
				<tr>
					<td>파일 선택</td>
					<td><input type='file' name="file" id="file"/></td>
				</tr>
				<tr>
					<td colspan="2" style="text-align:center"><img id="img" src="/images/imready.png" alt="" width=30%/></td>
				</tr>
				
			</table>
			<br><br>
			<div class="clear"></div>
			<br>
			<div class="add-buttons" style="float:right">
				<input type="button" value="등록" onclick="event_add()" class="btn btn-primary btn-sm">
				<input type="reset" value="취소" class="btn btn-light btn-sm">
				
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