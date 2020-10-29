<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<h1>문의 공지사항  답변수정</h1>
<form method="post" action="qnaUpdate.do" enctype="multipart/form-data">
	
	<div id="add-wrapper">
			<input type="hidden" name="no" value="${qnaRes.qnaNo }">
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
					<c:if test="${qna.qnaNotice eq 'y' }">
						<td><img alt="" src="../notice/setload/${qna.qnaFile }"></td>
					</c:if>
					<c:if test="${qna.qnaNotice eq 'n' }">
							<td><img alt="" src="../qna/upload/${qna.qnaFile }"></td>
					</c:if>
				</tr>

			</table>
			<br>
			
			<table class="add-table" >
				
				<tr>
					<td>답변 제목</td>
					<td><input type="text" name="title" value="${qnaRes.qnaTitle }"/> 
				</tr>
				
				
				<tr>
					<td>답변 내용</td>
					<td><textarea rows="20" cols="100" name="content">${qnaRes.qnaContent }</textarea></td>
				</tr>
				
				
				<tr>
					<td>업로드 사진</td>
					<c:if test="${qna.qnaNotice eq 'y' || qna.qnaRefNo != null }">
						<td><img alt="" src="../notice/setload/${qnaRes.qnaFile }"></td>
					</c:if>
					<c:if test="${qna.qnaNotice eq 'n' }">
							<td><img alt="" src="../qna/upload/${qnaRes.qnaFile }"></td>
					</c:if>
					<td><input type="file" name="setload" multiple></td>
				</tr>

			</table>
			
			
			
			<br><br>
			<div class="clear"></div>
			<br>
			<div class="add-buttons" style="float:right">
				<input type="submit" value="수정완료" class="btn btn-primary btn-sm">
				<input type="button" value="홈으로" class="btn btn-light btn-sm" onclick="location.href='qnaList.do'">
				<input type="reset" value="초기화" class="btn btn-light btn-sm"/>
				
			</div>
				</div>
	
	
</form>
<%@ include file="../include/footer.jsp"%>