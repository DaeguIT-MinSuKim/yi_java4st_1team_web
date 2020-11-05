<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>  
<script src="booking/booking_register.js"></script>
	<div class="book_wrapper" style="width: 840px; margin: 0 auto;">
		<form name="bookForm">
			<p style="font-size:30px; text-align:center; margin: 1.2em;">예약 등록</p>
			<h4 style="text-align:center;">당일 예약은 어렵습니다. (내일부터 한 달간 예약 가능)</h4>
			<hr>
			<div style="border-top: 1px solid lightgray; border-bottom: 1px solid lightgray; padding: 20px 20px;">
				<div style="width: 360px; display: inline-block; border-right: 1px solid lightgray;">
					<table class="bookForm" style="margin: 10px auto; display: inline-block; padding-right: 30px;">
						<tr>
							<td style="width: 180px;"><label for="bookName">예약자 </label></td>
							<td><input type="text" name="bookName" value="${loginUser.guestName }" readOnly></td>
						</tr>
						<tr>
							<td><label for="bookDate">예약일 </label></td>
							<td><input type="date" name="bookDate" id="bookDate"></td>
						</tr>
						<tr>
							<td><label for="bookDesigner">디자이너 </label></td>
							<td><select name="bookDesigner" id="designerBox">
								<c:forEach var="de" items="${deList}">
									<option value="${de.deNo }">${de.deNickname }</option>
								</c:forEach>
							</select></td>
						</tr>	
						<tr>
							<td><label for="bookHairKind">시술분류 </label></td>
							<td><select name="bookHairKind" id="hairkindbox">
							</select></td>
						</tr>
						<tr>
							<td><label for="bookHair">시술 </label></td>
							<td><select name="bookHair" id="hairbox">
								<option selected disabled>--시술 선택--</option>
								</select></td>
						</tr>
					</table>
					<hr>
					<hr>
					<h4>선택 내역</h4>
					<div class="addedHairList" style="width: 360px; min-height: 100px;">
						<ul>
						</ul>
					</div>
				</div>
				<div class="time_table" style="width: 400px;display: inline-block;  margin-left: 20px; vertical-align: top;">
					<ul>
					</ul>
				</div>
			</div>
			<hr>
			
			<div style="margin: 0 auto; text-align: center;">
				<input class="button" style="margin: 0 auto;" type="button" name="submit" value="예약 등록" onclick="return checkBookForm();">
			</div>
		</form>
	</div>
<%@ include file="../footer.jsp" %>  
