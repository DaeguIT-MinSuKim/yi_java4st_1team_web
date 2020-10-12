<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>  
<script>
	window.onload = function() {
		document.title += ' - 예약하기'
		document.getElementById('bookDate').valueAsDate = new Date();
		
		$(".time_table ul li").click(function(){
			console.log($(this));
			
			$(".active").removeClass("active");
			$(this).attr("class", "active");
		});
		
		
		$(function() {
			$.ajax({
				url: "booking.do",
				type: "post",
				dataType: "json",
				success: function(data) {
					console.log(data);
					loadHairKindCombo($("#hairkindbox"), data);
					$("#hairkindbox").val("");
				}
			});
		
			/* var hairKind; */
						
			function loadHairKindCombo(target, data) {
				var dataArr = [];
				var idx = 0;
				target.empty();
				
				$.each(data, function(index, item) {
					dataArr[idx++] = "<option value=" + item.kindNo + ">[" + item.kindNo + "] " + item.kindName + "</option>";
				});
				
				target.append(dataArr);
			}
			
			
			$("#hairkindbox").change(function() {
				var selectedKindNo = $("#hairkindbox option:selected").val();
				// changeHairBox("#hairbox", selectedKindNo);
				$.ajax({
					url: "booking.do",
					type: "post",
					dataType: "json",
					data: {
						kindNo: selectedKindNo
					},
					success: function(data) {
						loadHairBox($("#hairbox"), data);
					},
					error: function(error) {
						console.log("[load hiarbox] error: " + error);
					}
				});
			});
			 
			function loadHairBox(target, data) {
				var dataArr = [];
				var idx = 0;
				target.empty();
				
				$.each(data, function(index, item) {
					dataArr[idx++] = "<option value=" + item.hairNo + ">" + item.hairName+ "</option>";
				});
				
				target.append(dataArr);
			};
			
		});
	}
</script>
<form>
	<ul>
		<li>
			<label for="bookName">예약자 : </label>
			<input type="text" name="bookName" value="${loginUser.guestName }" readOnly>
		</li>
		<li>
			<label for="bookDate">예약일 : </label>
			<input type="date" name="bookDate" id="bookDate">
		</li>
		<li>
			<label for="bookHairKind">시술 : </label>
			<select name="bookHairKind" id="hairkindbox">
				<%-- <c:forEach var="hairKind" items="${hairList}">
					<option value="${hairKind.kindNo }">[${hairKind.kindNo}]${hairKind.kindName }</option>
				</c:forEach> --%>
			</select>
		</li>
		<li>
			<label for="bookHair">시술 : </label>
			<select name="bookHair" id="hairbox">
			</select>
		</li>
		<li>
			<label for="bookDesigner">디자이너 : </label>
			<select name="bookDesigner">
				<c:forEach var="de" items="${deList}">
					<option value="${de.deNo }">${de.deName }</option>
				</c:forEach>
			</select>
		</li>		
	</ul>
	<div class="time_table">
		<ul>
		    <c:forEach var="i"  begin="9" end="19">
		    	<c:forEach var="j" begin="0" end="1">
		    		<!-- <a href="#juno" time24="18:30" ampm="pm" time="6:30">6:30</a> -->
					<li time24="${i}:${j==0 ? '00' : j*30}">${i>9 ? i :'0'}${i>9 ? '' : i} : ${j==0 ? '00' : j*30}</li>		    
		    	</c:forEach>
		    </c:forEach>
		</ul>
	</div>
	${hairList }<br>
	${deList }
</form>



<!-- 
<div class="juno">
<div class="timeselectbox">
	<div class="timeline" id="timeline">
		<div class="timesec">
			<p class="tit">오전</p>
			<ul>
				<li><span class="disabled">10:00</span></li>
				<li><span class="disabled">10:30</span></li>
				<li><span class="disabled">11:00</span></li>
				<li><span class="disabled">11:30</span></li>
			</ul>
		</div>
		<div class="timesec">
			<div class="line">
				<span></span>
			</div>
			<p class="tit">오후</p>
			<ul>
				<li><span class="disabled">12:00</span></li>
				<li><span class="disabled">12:30</span></li>
				<li><span class="disabled">1:00</span></li>
				<li><span class="disabled">1:30</span></li>
				<li><span class="disabled">2:00</span></li>
				<li><span class="disabled">2:30</span></li>
				<li><span class="disabled">3:00</span></li>
				<li><span class="disabled">3:30</span></li>
				<li><span class="disabled">4:00</span></li>
				<li><span class="disabled">4:30</span></li>
				<li><span class="disabled">5:00</span></li>
				<li><span class="disabled">5:30</span></li>
				<li><span class="disabled">6:00</span></li>
				<li><span class="disabled">6:30</span></li>
				<li><span class="disabled">7:00</span></li>
				<li><span class="disabled">7:30</span></li>
				<li><span class="disabled">8:00</span></li>
				<li><span class="disabled">8:30</span></li>
			</ul>
		</div>
	</div>
</div>
</div> -->
<%@ include file="../footer.jsp" %>  