<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>  
<script src="booking/booking_register.js"></script>
	<div class="book_wrapper" style="width: 1000px; margin: 0 auto;">
		<form name="bookForm">
		<p style="font-size:30px; text-align:center;">예약 등록</p>
		<h4 style="text-align:center;">방문일 당일 예약은 어렵습니다. (예약일로부터 최소 1일 전 예약 가능)</h4>
		<br>
			<table class="bookForm" style="margin: 10px auto;">
				<tr>
					<td style="width: 200px;"><label for="bookName">예약자 </label></td>
					<td><input type="text" name="bookName" value="${loginUser.guestName }" readOnly></td>
				</tr>
				<tr>
					<td><label for="bookDate">예약일 </label></td>
					<td><input type="date" name="bookDate" id="bookDate"></td>
				</tr>
				<tr>
					<td><label for="bookHairKind">시술분류 </label></td>
					<td><select name="bookHairKind" id="hairkindbox">
					</select></td>
				</tr>
				<tr>
					<td><label for="bookHair">시술 </label></td>
					<td><select name="bookHair" id="hairbox">
						<option selected disabled>--시술 선택--</option><
					</select></td>
				</tr>
				<tr>
					<td><label for="bookDesigner">디자이너 </label></td>
					<td><select name="bookDesigner" id="designerBox">
						<c:forEach var="de" items="${deList}">
							<option value="${de.deNo }">${de.deName }</option>
						</c:forEach>
					</select></td>
				</tr>		
			</table>
			<div class="time_table" style="width: 1000px; margin: 0 auto;">
				<ul>
				</ul>
			</div>
			<div class="addedHairList" style="width: 580px; margin: 0 auto;">
				<ul>
				</ul>
			</div>
			<div class style="width: 1000px; margin: 0 auto; text-align: center;">
				<input class="button" style="margin: 0 auto;" type="button" name="submit" value="예약 등록" onclick="return checkBookForm();">
			</div>
		</form>
	</div>
<%@ include file="../footer.jsp" %>  
