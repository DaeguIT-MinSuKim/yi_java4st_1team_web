<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<h1>문의 공지사항 상세</h1>
<form method="post" action="qnaResult.do" enctype="multipart/form-data">
	
	<div id="add-wrapper">
			
			<table class="add-table">
				
				<tr>
					<td>문의 제목</td>
					<td><input type="text"  readonly value="${qna.qnaTitle }"/> 
				</tr>
				
				
				<tr>
					<td>문의 내용</td>
					<td><input type="text"  readonly value="${qna.qnaContent }"/></td>
				</tr>
				
				
				<tr>
					<td>업로드 사진</td>
					<td><img alt="" src="${qna.qnaFile }"></td>
				</tr>

			</table>
			<br>
			
			<table class="add-table" >
				
				<tr>
					<td>답변 제목</td>
					<td><input type="text" name="title" readonly value="${qnaResult.qnaContent }" /> 
				</tr>
				
				
				<tr>
					<td>답변 내용</td>
					<td><input type="text"  readonly value="${qnaResult.qnaContent }"/></td>
				</tr>
				
				
				<tr>
					<td>업로드 사진</td>
					<td><img alt="" src="${qnaResult.qnaFile }"></td>
				</tr>

			</table>
			
			
			
			<br><br>
			<div class="clear"></div>
			<br>
			<div class="add-buttons" style="float:right">
				<input type="button" value="홈으로" class="btn btn-light btn-sm" onclick="location.href='qnaList.do'">
				
			</div>
				</div>
	
	
</form>
<%@ include file="../include/footer.jsp"%>