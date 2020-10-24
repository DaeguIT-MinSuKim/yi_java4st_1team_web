/* 헤어 대분류 선택시 소분류 불러오기 */
$(function() {
	$(document).on("click", "#hairkindbox li", function() {
		console.log($(this).attr("kindNo"));
		var selectedKindNo = $(this).attr("kindNo");
		
		if($(this).hasClass("active")) {
			return;
		}
		
		$("#hairkindbox .active").removeClass("active");
		$(this).addClass("active");
		
		$.ajax({
			url: "bookingToOrder.do",
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
		target.empty();
		var dataArr = "";
		
		$.each(data, function(index, item) {
			dataArr += "<li class='list-group-item flex-fill text-center' role='button' hairNo='"
				+ item.hairNo + "' hairPrice='" + item.hairPrice + "'>[" + item.hairNo + "] "+ item.hairName+ "</li>";
			index++;
		});
		
		target.append(dataArr);
	};
	
	
	$(document).on("click", "#hairbox li", function() {
		var hairNo = $(this).attr("hairNo");
		var hairName = $(this).text();
		var hairPrice = $(this).attr("hairPrice");

		addHair(hairNo, hairName, hairPrice);
		
		if($(this).hasClass("active")) {
			return;
		}
		
		$("#hairbox .active").removeClass("active");
		$(this).addClass("active");
	});
	
	function addHair(hairNo, hairName, hairPrice) {
		if(hairNo == 0) {
			return;
		}
		
		var quantity = 1;
		var selectedItem = $(".addedHair[hairNo=" + hairNo + "]");
		
		if (selectedItem.length == 0) {
			// 처음 선택한 경우
			var addLine = "<li class='addedHair list-group-item' hairNo='" + hairNo + "' hairName='" + hairName + "' quantity='" + quantity + "' hairPrice='" + hairPrice + "'>"
							+ hairName + " <span class='quantity'>" + quantity + "</span>회 &nbsp;&nbsp;<a href='javascript:void(0);' onclick='delHairItem(" + hairNo +"); return false;'>"
							+ "<i class='fas fa-times'></i></a></li>";
			$(".addedHairList").append(addLine);
		} else {
			// 이미 존재하는 경우 수량을 증가시킴
			quantity = selectedItem.attr("quantity") * 1;
			$(selectedItem).attr("quantity", ++quantity);
			$(selectedItem).children(".quantity").text(quantity);
		}
		
		var totalPrice = $(".totalPrice").attr("totalPrice")*1;
		
		if(totalPrice === null) {
			totalPrice = hairPrice*1;
		} else {
			totalPrice += hairPrice*1;
		}
		
		var totalPriceStr = totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		$(".totalPrice").attr("totalPrice", totalPrice);
		$(".totalPrice").text(totalPriceStr);
	}
	
	$("#nonMemberCK").change(function() {
		console.log($(this));
		if($(this).is(":checked")) {
			$("#guestInput").val("비회원");
			$("#guestInput").attr("readonly", true);
			$("div[name=bookingDetail]").text("-");
		} else {
			$("#guestInput").attr("readonly", false);
			$("#guestInput").val("");
			$("div[name=bookingDetail]").text("예약 고객인 경우 검색창을 통해 해당 예약건을 선택해주세요.");
		}
	});
	
});	

	
var selectedBookingNo = 0;

$(document).on("click", "#todayBookingTable tr[role=button]", function() {
	if($(this).hasClass("table-primary")) {
		return;
	}
	
	$("#todayBookingTable .table-primary").removeClass("table-primary");
	$(this).addClass("table-primary");
});

$(document).on("click", "#modalConfirm", function(){ 
	var tdArr = "";
	var thead = $("#todayBookingTable thead tr");
	var thead_td = thead.children();
	var tr = $("#todayBookingTable .table-primary");
	var td = tr.children();
	
	console.log(thead);
	console.log("thead_tr : " + thead_td);
	// 체크된 체크박스 값을 가져온다
	$.each(td, function(index, item) {
		// td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
		var theadStr = $(thead_td[index]).text();
		var tdStr = $(item).text();
		
		// console.log(theadStr);
		console.log(tdStr);
		
		// 가져온 값을 배열에 담는다.
		tdArr += theadStr + ": " + tdStr + " | ";
	});
	
	$("div[name=bookingDetail]").text(tdArr);
	$("#guestInput").val($(td[0]).text());
});


function delHairItem(itemNo) {
	// console.log($(".addedHair[hairNo=" + itemNo + "]").attr("hairName"));
	var item = $(".addedHair[hairNo=" + itemNo + "]").get();
	var price = $(item).attr("hairPrice") * $(item).attr("quantity");
	$(".addedHair[hairNo=" + itemNo + "]").remove();
	
	var totalPrice = $(".totalPrice").attr("totalPrice")*1 - price;
	var totalPriceStr = totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	$(".totalPrice").attr("totalPrice", totalPrice);
	$(".totalPrice").text(totalPriceStr);
}