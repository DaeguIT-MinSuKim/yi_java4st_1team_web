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
}
	
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


function checkBookForm() {
	if (document.bookForm.bookHair.value == "") {
		alert("시술을 선택해주세요");
		document.bookForm.bookHair.focus();
		return false;
	} else if (document.bookForm.bookDesigner.value == "") {
		alert("디자이너를 선택해주세요.");
		document.bookFrom.bookDesigner.focus();
		return false;
	} else if($(".time_table .active").attr("time24") == "") {
		alert("예약 시간을 선택해주세요.");
		return false;
	}
	
	console.log("일시 : " + $("#bookDate").val() + " " + $(".time_table .active").attr("time24"));
	
	var hair = {
			hairNo: $('#hairbox').val()
		};
	
	var designer = {
			deNo: $('#designerBox').val()
		};
	
	var booking = {
			 bookDate: $("#bookDate").val() + " " + $(".time_table .active").attr("time24"),
			 hair: hair,
			 designer: designer
		};

	console.log(JSON.stringify(booking));
	
	
	$.ajax({
       type:"post",
       url:"bookingRegister.do",
       cache: false, // refresh할 때 중복으로 추가 되지 않게 캐시 삭제
       data: JSON.stringify(booking),
       // success 메서드 호출하고 complete 호출 됨.
       complete: function(data) {
          alert("예약이 완료되었습니다. (nextNo: " + data.responseText + ")");
          console.log(data);
          window.location.href = "bookingDetail.do?no=" + data.responseText;
       }
    });
	
	
	// document.bookForm.action = "bookingRegister.do";
	// document.bookForm.submit();
	return true;
}

</script>
<form name="bookForm">
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
			<select name="bookDesigner" id="designerBox">
				<c:forEach var="de" items="${deList}">
					<option value="${de.deNo }">${de.deName }</option>
				</c:forEach>
			</select>
		</li>		
	</ul>
	<div class="time_table">
		<ul>
		    <c:forEach var="i"  begin="10" end="19">
		    	<c:forEach var="j" begin="0" end="1">
		    		<!-- <a href="#juno" time24="18:30" ampm="pm" time="6:30">6:30</a> -->
					<li time24="${i}:${j==0 ? '00' : j*30}">${i>9 ? i :'0'}${i>9 ? '' : i} : ${j==0 ? '00' : j*30}</li>		    
		    	</c:forEach>
		    </c:forEach>
		</ul>
	</div>
	<input type="button" name="submit" value="예약 등록" onclick="return checkBookForm();">
</form>
	${hairList }<br>
	${deList }


<!-- 
<div class="juno">
<div class="timeselectbox">
	<div class="timeline" id="timeline">
		<div class="timesec">
			<p class="tit">오전</p>
			<ul>
				<li><span class="disabled">10:00</span></li>
			</ul>
		</div>
		<div class="timesec">
			<div class="line">
				<span></span>
			</div>
			<p class="tit">오후</p>
			<ul>
				<li><span class="disabled">8:30</span></li>
			</ul>
		</div>
	</div>
</div>
</div> -->
<%@ include file="../footer.jsp" %>  