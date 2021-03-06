<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>  
<script>
$(document).on("click", ".time_table ul li", function() {
	if(!$(this).hasClass("disabled")) {
		$(".active").removeClass("active");
		$(this).attr("class", "active");
	}
})

$(function() {
	$(document).ready(function() {
		document.title += ' - 예약하기'
		var today = new Date();
		document.getElementById('bookDate').valueAsDate = today;
		
		var maxDate = new Date();
		maxDate.setDate(today.getDate() + 28);
		
		var minDateStr = today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate();
		var maxDateStr = maxDate.getFullYear() + "-" + (maxDate.getMonth() + 1) + "-" + maxDate.getDate();
		document.getElementById('bookDate').min = minDateStr;
		document.getElementById('bookDate').max = maxDateStr;
		
		setTimeTable($("#bookDate").val());
	
	
		/* 헤어 대분류 불러오기 */
		$.ajax({
			url: "bookingTest.do",
			type: "post",
			dataType: "json",
			success: function(data) {
				console.log(data);
				loadHairKindCombo($("#hairkindbox"), data);
				$("#hairkindbox").val("");
			}
		});
	
		function loadHairKindCombo(target, data) {
			var dataArr = [];
			var idx = 0;
			target.empty();
			
			$.each(data, function(index, item) {
				dataArr[idx++] = "<option value=" + item.kindNo + ">[" + item.kindNo + "] " + item.kindName + "</option>";
			});
			
			target.append(dataArr);
		}
		
		/* 헤어 대분류 선택시 소분류 불러오기 */
		$("#hairkindbox").change(function() {
			var selectedKindNo = $("#hairkindbox option:selected").val();
			$.ajax({
				url: "bookingTest.do",
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
		
		$("#hairbox").change(function(e) {
			var hairNo = $("#hairbox option:selected").val();
			var hairName = $("#hairbox option:selected").text();
			
			addHair(hairNo, hairName);
			
		});
		
		/* 날짜 선택 시 타임테이블 불러오기 */
		$("#bookDate").change(function() {
			setTimeTable($("#bookDate").val());
		});
		
		// 매개변수 날짜값으로 타임테이블 불러오는 함수
		function setTimeTable(bookDateVal) {
			$.ajax({
				url: "bookingTest.do",
				type: "post",
				data: {
					bookDate: bookDateVal
				},
				dataType: "json",
				success: function(data) {
					console.log(data);
					loadTimeTable($(".time_table ul"), data);
				}
			});
		}
		
		// 타임테이블 ajax로 불러온 데이터로 html 쓰는 함수
		function loadTimeTable(target, data) {
			var dataArr = [];
			var idx = 0;
			target.empty();
			
			$.each(data, function(index, item) {
				dataArr[idx++] = "<li time24='" + item.time + "'" + (item.used === 1 ? " class='disabled'" : "")+ ">" + item.time + "</li>";
			});
			target.append(dataArr);
		}
	});
});

function addHair(hairNo, hairName) {
	// console.log($(".addedHair[hairNo=" + itemNo + "]").attr("hairName"));
	// $(".addedHair[hairNo=" + itemNo + "]").remove();
	
	var quantity = 1;
	var selectedItem = $(".addedHair[hairNo=" + hairNo + "]");
	
	if (selectedItem.length == 0) {
		// 처음 선택한 경우
		var addLine = "<li class='addedHair' hairNo='" + hairNo + "' hairName='" + hairName + "' quantity='" + quantity + "'>"
						+ hairName + " <span class='quantity'>" + quantity + "</span>회 <a href='javascript:void(0);' onclick='delHairItem(" + hairNo +"); return false;'>X</a></li>";
		$(".addedHairList").append(addLine);
	} else {
		// 이미 존재하는 경우 수량을 증가시킴
		quantity = selectedItem.attr("quantity") * 1;
		$(selectedItem).attr("quantity", ++quantity);
		$(selectedItem).children(".quantity").text(quantity);
	}
	
	
	console.log($(".addedHair[hairNo=" + hairNo + "]").attr("hairName"));
	// console.log(selectedItem.attr("hairName"));
	
	
}

function delHairItem(itemNo) {
	// console.log($(".addedHair[hairNo=" + itemNo + "]").attr("hairName"));
	$(".addedHair[hairNo=" + itemNo + "]").remove();
}

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
	
	var hairList = $(".addedHairList").find("li.addedHair").get();
	
	var hairs= new Array();
	for(var i=0; i < hairList.length; i++ ){
		var bookingHairs = {
				hair: {
					hairNo: $(hairList[i]).attr("hairNo")
				},
				quantity: $(hairList[i]).attr("quantity")
		};
		hairs.push(bookingHairs);
	}
	
	console.log(hairs);
	
	var designer = { deNo: $('#designerBox').val() };
	var booking = {
			 bookDate: $("#bookDate").val() + " " + $(".time_table .active").attr("time24"),
			 hairList: hairs,
			 designer: designer
		};


    console.log(JSON.stringify(booking));
	
    $.ajax({
        type:"post",
        url:"bookingRegister.do",
        cache: false, // refresh할 때 중복으로 추가 되지 않게 캐시 삭제
        data: JSON.stringify(booking),
        dataType: "text",
        success: function(data) {
     	  if (data == -1) {
     		  alert("이미 예약된 시간입니다. 새로고침 후 다시 이용해주세요.");
     		  location.reload();
     	  } else if (data == 0) {
     		  alert("오류가 발생했습니다. 다시 시도해주세요.");
     		  location.reload();
     	  } else {
 	          alert("예약이 완료되었습니다. (nextNo: " + data + ")");
 	          console.log(data);
 	          window.location.href = "bookingDetail.do?no=" + data;
     	  }
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
			<label for="bookHairKind">시술분류 : </label>
			<select name="bookHairKind" id="hairkindbox">
			</select>
		</li>
		<li>
			<label for="bookHair">시술 : </label>
			<select name="bookHair" id="hairbox">
				<option selected disabled>--시술 선택--</option>
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
		</ul>
	</div>
	<div class="addedHairList">
		<ul>
		</ul>
	</div>
	<input type="button" name="submit" value="예약 등록" onclick="return checkBookForm();">
</form>
<%@ include file="../footer.jsp" %>  
