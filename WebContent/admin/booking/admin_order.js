var selectedBookingNo = 0; // 선택된 예약번호
var selBooking; // 선택된 예약 정보

/* 주문하기로 들어온 경우 */
// 1. 예약리스트에서
$(function() {
	var thisUrlStr = window.location.href;
	var thisUrl = new URL(thisUrlStr);
	selectedBookingNo = thisUrl.searchParams.get("no");
	console.log("selectedBookingNo = " + selectedBookingNo);
	setBookingData();
});

// 2. 고객리스트에서


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
	
	
	/* 비회원 체크 여부 변화시 */
	$("#nonMemberCK").change(function() {
		var isChecked = $(this).is(":checked");
		
		setOrderViewClear(); // 디자이너, 시술 clear
		
		$("#guestInput").prop("readonly", isChecked);
		$(this).prop("checked", isChecked);
		
		if(isChecked) {
			$("#guestInput").val("비회원");
			$("div[name=bookingDetail]").text("-");
		} else {
			$("#guestInput").val("");
			$("div[name=bookingDetail]").text("예약 고객인 경우 검색창을 통해 해당 예약건을 선택해주세요.");
		}
		
		selectedBookingNo = 0;
		$("#todayBookingTable .table-primary").removeClass("table-primary"); // 모달창 선택 clear
	});
	
});	

	
/* 모달 테이블 클릭 시 primary 클래스 */
$(document).on("click", "#todayBookingTable tr[role=button]", function() {
	if($(this).hasClass("table-primary")) {
		return;
	}
	
	$("#todayBookingTable .table-primary").removeClass("table-primary");
	$(this).addClass("table-primary");
});

$(document).on("click", "#guestSearchTable tr[role=button]", function() {
	if($(this).hasClass("table-primary")) {
		return;
	}
	
	$("#guestSearchTable .table-primary").removeClass("table-primary");
	$(this).addClass("table-primary");
});


var hairListRow = 1;

/* 시술 추가 */
function addHair(hairNo, hairName, hairPrice) {
	if(hairNo == 0) {
		return;
	}
	
	var quantity = 1;
	var selectedItem = $(".addedHair[hairNo=" + hairNo + "]");
	
	if (selectedItem.length == 0) {
		
		// 처음 선택한 경우
		var hairPriceStr = hairPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + " 원";
		var addTr = "<tr class='addedHair' hairNo='" + hairNo+ "' hairName='" + hairName + "' hairPrice='" + hairPrice + "' quantity='" + quantity + "'>"
						+ "<td>" + hairListRow + "</td><td>" + hairName + "</td>"
						+ "<td>" + hairPriceStr + "</td><td>x <span class='quanityty'>1</span></td>"
						+ "<td>" + hairPriceStr + "</td>"
						+ "<td><a href='javascript:void(0);' onclick='delHairItem(" + hairNo +")'><i class='fas fa-times'></td></tr>";
//		var addLine = "<li class='addedHair list-group-item' hairNo='" + hairNo + "' hairName='" + hairName + "' quantity='" + quantity + "' hairPrice='" + hairPrice + "'>"
//						+ hairName + " <span class='quantity'>" + quantity + "</span>회 &nbsp;&nbsp;<a href='javascript:void(0);' onclick='delHairItem(" + hairNo +"); return false;'>"
//						+ "<i class='fas fa-times'></i></a></li>";
		$(".addedHairList").append(addTr);
	} else {
		// 이미 존재하는 경우 수량을 증가시킴
		quantity = selectedItem.attr("quantity") * 1;
		quantity += 1;
		var price = hairPrice * quantity; 
		$(selectedItem).children().eq(4).text(price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + " 원");
		$(selectedItem).attr("quantity", quantity);
		$(selectedItem).find("span").text(quantity);
	}
	
	var totalAmount = $("#totalAmount").attr("totalAmount")*1;
	
	if(totalAmount === null) {
		totalAmount = hairPrice*1;
	} else {
		totalAmount += hairPrice*1;
	}
	
	var totalAmountStr = totalAmount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	$("#totalAmount").attr("totalAmount", totalAmount);
	$("#totalAmount").text(totalAmountStr);
	
	calTotalPrice();
}

/* 추가된 시술 삭제 */
function delHairItem(itemNo) {
	// console.log($(".addedHair[hairNo=" + itemNo + "]").attr("hairName"));
	var item = $(".addedHair[hairNo=" + itemNo + "]").get();
	var price = $(item).attr("hairPrice") * $(item).attr("quantity");
	$(".addedHair[hairNo=" + itemNo + "]").remove();
	
	var totalAmount = $("#totalAmount").attr("totalAmount")*1 - price;
	var totalAmountStr = totalAmount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	$("#totalAmount").attr("totalAmount", totalAmount);
	$("#totalAmount").text(totalAmountStr);
	
	calTotalPrice();
}

function calTotalPrice() {
	var totalAmount = $("#totalAmount").attr("totalAmount") * 1;
	var discountAmount = $("#discountAmount").attr("discountAmount") * 1;
	
	var totalPrice = (totalAmount - discountAmount).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	$("#totalPrice").attr("totalPrice", totalAmount-discountAmount);
	$("#totalPrice").text(totalPrice);
}

/* 모달창 선택완료시 주문화면에 set */
$(document).on("click", "#bookingSearchModalConfirm", function(){ 
	setBookingInfoDiv();
	setBookingData();
});


$(document).on("click", "#guestSearchModalConfirm", function(){
	setOrderViewClear();
	$("#guestInput").prop("readonly", true);
	$("#nonMemberCK").prop("checked", false);
	$("#guestInput").val($("#guestSearchTable .table-primary td").eq(1).text());
});


function setBookingData(){
    var url = "bookingToOrder.do";
    $.ajax({
        type: "POST",
        url: url,
        data: { bookNo: selectedBookingNo },
        dataType: "json",
        success: function(data){
        	console.log(data);
            setBookingData_return(data);
            setBookingInfo(data);
        }
    });
    
}

function setBookingData_return(data){
    selBooking = data;
}

function setBookingInfoDiv() {
	var tdArr = "";
	var thead = $("#todayBookingTable thead tr");
	var thead_td = thead.children();
	var tr = $("#todayBookingTable .table-primary");
	var td = tr.children();
	
	$.each(td, function(index, item) {
		var theadStr = $(thead_td[index]).text();
		var tdStr = $(item).text();
		
		tdArr += theadStr + ": " + tdStr + " | ";
	});
	
	selectedBookingNo = $(td).eq(0).text(); // 예약번호
	$("div[name=bookingDetail]").text(tdArr);
	$("#guestInput").val($(td[0]).text());
}

/* 디자이너, 시술 clear */
function setOrderViewClear() {
	$("#guestInput").val("");
	$("#guestInput").prop("readonly", false);
	$("#nonMemberCK").prop("checked", false);
	$("#designerSelector").val("");
	$(".addedHairList").empty();
	
	$("#couponBox").empty();
	$("#couponBox").prop("disabled", true);
	$("#couponTargetBox").empty();
	$("#couponTargetBox").prop("disabled", true);
	
	$("#totalAmount").text("0");
	$("#totalAmount").attr("totalAmount", 0);
	$("#discountAmount").text("0");
	$("#discountAmount").attr("discountAmount", 0);
	$("#totalPrice").text("0");
	$("#totalPrice").attr("totalPrice", 0);
}

/* DB에서 조회한 예약정보 화면에 set */
function setBookingInfo(selBooking) {
	setOrderViewClear();
	
	$("#guestInput").prop("readonly", true);
	$("#nonMemberCK").prop("checked", false);
	$("#guestInput").val(selBooking.guest.guestId);
	$("#designerSelector").val(selBooking.designer.deNo);
	
	$.each(selBooking.hairList, function(index, item) {
		var hairNo = item.hair.hairNo;
		var hairName = item.hair.hairName;
		var hairPrice = item.hair.hairPrice;
		var quantity = item.quantity;
		
		for(var i=0; i < item.quantity; i++ ) {
			addHair(hairNo, hairName, hairPrice);
		}
	});
	
	var bookDate = selBooking.bookDate.date;
	var bookTime = selBooking.bookDate.time;
	
	var bookDateStr = bookDate.year + "-" + bookDate.month + "-" + bookDate.day;
	var bookTimeStr = (bookTime.hour < 10 ? "0" + bookTime.hour : bookTime.hour) + ":" + (bookTime.minute == 0 ? "00" : bookTime.minute);
	
	var bookingDiv = "예약번호: " + selBooking.bookNo + " | 예약일: " + bookDateStr + " " + bookTimeStr + " | 아이디: " + selBooking.guest.guestId + " | 시술: "
					+ (selBooking.hairList.length == 1 ? selBooking.hairList[0].hair.hairName : selBooking.hairList[0].hair.hairName + " 외 " + (selBooking.hairList.length - 1 ) + "건" ) + " | 디자이너: " + selBooking.designer.deName + " | 연락처: " + selBooking.guest.guestPhone;
	
	console.log(bookingDiv);
	$("div [name=bookingDetail]").text(bookingDiv);
	
	loadCouponList(selBooking.guest.guestId);
}


function setClear() {
	setOrderViewClear();
	$("#guestInput").val("");
	$("div[name=bookingDetail]").text("예약 고객인 경우 검색창을 통해 해당 예약건을 선택해주세요.");	
	
	selectedBookingNo = 0;
	$("#guestSearchTable .table-primary").removeClass("table-primary"); // 모달창 선택 clear
	$("#todayBookingTable .table-primary").removeClass("table-primary"); // 모달창 선택 clear
}


function loadCouponList(guestId) {
	$.ajax({
		url: "bookingToOrder.do",
		type: "post",
		dataType: "json",
		data: {
			guestId: guestId
		},
		success: function(data) {
			console.log(data);
			loadCouponBox($("#couponBox"), data);
			$("#couponBox").prop("disabled", false);
			loadCouponTargetBox($("#couponTargetBox"));
			$("#couponTargetBox").prop("disabled", true);
		},
		error: function(error) {
			console.log("[load couponList] error: " + error);
		}
	});
}

function loadCouponBox(target, data) {
	target.empty();
	var dataArr = "<option value=''>사용 안 함</option>";
	
	$.each(data, function(index, item) {
		dataArr += "<option value='" + item.couponId+ "' saleRate='" + Math.round(item.event.eventSaleRate * 10)/10 + "'>" + item.event.eventName + "</option>";
		index++;
	});
	
	target.append(dataArr);
};


function loadCouponTargetBox(target) {
	target.empty();
	var dataArr = "<option value=''>선택 안 함</option>";
	
	var trs = $("#addedHairList").children();
	
	$.each(trs, function(index, item) {
		dataArr += "<option value='" + $(item).attr("hairNo") + "' hairName='" + $(item).attr("hairName") + "' hairPrice='" + $(item).attr("hairPrice")
					+ "' quantity='" + $(item).attr("quantity") + "'>" + $(item).attr("hairName") + "</option>";
	});
	
	target.append(dataArr);
	console.log(dataArr);
};


$(function() {
	searchGuest(1, null, null);
});

function searchGuest(nowPage, opt, value) {
	$.ajax({
		url: "guestListEx.do",
		type: "post",
		dataType: "json",
		data: {
			nowPage: nowPage,
			opt: opt,
			value: value
		},
		success: function(data) {
			console.log("searchGuest()");
			console.log(data.guestList);
			console.log(data.paging);
			loadGuestSearchTable($("#guestSearchTable tbody"), data);
		},
		error: function(error) {
			console.log("[searchGuest] error: " + error);
		}
	});
}


function loadGuestSearchTable(target, data) {
	target.empty();
	var guestList = data.guestList;
	var paging = data.paging;
	
	var dataArr = "";
	$.each(guestList, function(index, item) {
		dataArr += "<tr role='button'><td></td><td>" + item.guestId + "</td><td>" + item.guestName + "</td><td>" + item.guestPhone + "</td></tr>";
	});
	target.append(dataArr);
	
	$("#guestSearchTable tbody tr td:first-child()").each(function(index, item) {
		$(item).text((paging.nowPage-1) * paging.cntPerPage + index + 1);
	});
	
	var pageArr = "";
	if(paging.endPage == 1) {
		// 시작 페이지가 0? 표시만 하기?
		pageArr += "<li class='page-item previous disabled'><a href='#' class='page-link'><</a></li>";
		pageArr += "<li class='page-item active'><a href='#' class='page-link' nowPage='" + paging.startPage + "'>" + paging.startPage + "</a></li>";
		pageArr += "<li class='page-item next disabled'><a href='#' class='page-link'>></a></li>";
	}  else {
		pageArr += "<li class='page-item previous'><a href='#' class='page-link'><</a></li>";
		
		for(var i = paging.startPage; i < paging.endPaging; i++) {
			if(i == paging.nowPaging) {
				// i // 현재 페이지 표시만
				pageArr += "<li class='page-item active'><a href='#' class='page-link' nowPage='" + i + "'>" + i + "</a></li>";
			} else {
				// nowPage=i
				pageArr += "<li class='page-item'><a href='#' class='page-link' nowPage='" + i + "'>" + i + "</a></li>";
			}
		}
		
		pageArr += "<li class='page-item next'><a href='#' class='page-link'>></a></li>";
	}
	
	if(paging.endPage != paging.lastPage) {
		// nowPage=paging.endPage+1
		pageArr += "<li class='page-item'><a href='#' class='page-link' nowPage='" + paging.endPage+1 + "'>" + paging.endPaging+1 + "</a></li>";
	}
	
	console.log(pageArr);
	$("#guestSearchTable_paginate ul").append(pageArr);
}


$(document).on("change", "#couponBox",function() {
	var couponTargetBox = $("#couponTargetBox");
	if($("#couponBox").val() == "") {
		$(couponTargetBox).prop("disabled", true);
	} else {
		$(couponTargetBox).prop("disabled", false);
	}
	changeDiscountAmount($("#discountAmount"));
});

$(document).on("change", "#couponTargetBox" ,function() {
	changeDiscountAmount($("#discountAmount"));
});

/* 쿠폰 또는 쿠폰 적용 대상 시술 변경시 할인 금액 변화 */
function changeDiscountAmount(target){
//	$("#couponBox :selected").val(); // 쿠폰 번호
//	$("#couponBox :selected").attr("saleRate"); // 할인율 소수점
	
//	$("#couponTargetBox :selected").val(); // 시술 번호
//	$("#couponTargetBox :selected").attr("hairPrice"); // 금액
//	$("#couponTargetBox :selected").attr("quantity"); // 시술 회숫
	
	var saleRate = $("#couponBox option:selected").attr("saleRate");
	var unitPrice = $("#couponTargetBox option:selected").attr("hairPrice");
	var discount = 0;
	
	console.log("saleRate: " + saleRate);
	console.log("unitPrice: " + unitPrice);
	
	if(saleRate != undefined && unitPrice != undefined) {
		discount = saleRate * unitPrice;
	}
	
	$(target).text(discount);
	$(target).attr("discountAmount", discount);
	calTotalPrice();
}


/* 주문등록 버튼 클릭 시 input 값들 다 읽어오기 */
$(function(){
	
	
});