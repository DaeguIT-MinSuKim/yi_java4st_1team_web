var selectedGuestId;
var selectedBookingNo = 0; // 선택된 예약번호
var selBooking; // 선택된 예약 정보

$(document).on("keydown", "input:not(#guestSearchInput)", function(event) {
	  if (event.keyCode === 13) {
	    event.preventDefault();
	  };
});


/* 주문하기로 들어온 경우 */
// 1. 예약리스트에서
$(function() {
	var thisUrlStr = window.location.href;
	var thisUrl = new URL(thisUrlStr);
	selectedBookingNo = thisUrl.searchParams.get("no");
	setBookingData();
	
	var guestId = thisUrl.searchParams.get("guestId");
	if(guestId != null) {
		$("#guestInput").prop("readonly", true);
		$("#nonMemberCK").prop("checked", false);
		$("div[name=bookingDetail]").text("-");	
		$("#guestInput").val(guestId);
		loadCouponList(guestId);
	}
});

// 2. 고객리스트에서


/* 헤어 대분류 선택시 소분류 불러오기 */
$(function() {
	$(document).on("click", "#hairkindbox li", function() {
		var selectedKindNo = $(this).attr("kindNo");
		
		if($(this).hasClass("active")) {
			return;
		}
		
		$("#hairkindbox .active").removeClass("active");
		$(this).addClass("active");
		
		$.ajax({
			url: "orderForm.do",
			type: "post",
			dataType: "json",
			data: {
				kindNo: selectedKindNo
			},
			success: function(data) {
				loadHairBox($("#hairbox"), data);
			},
			error: function(error) {
				alert("헤어 소분류를 읽어오는데 실패했습니다.");
			}
		});
	});
	
	function loadHairBox(target, data) {
		target.empty();
		var dataArr = "";
		
		$.each(data, function(index, item) {
			dataArr += "<li class='list-group-item flex-fill text-center' role='button' hairNo='"
				+ item.hairNo + "' hairPrice='" + item.hairPrice + "'>" + item.hairName + "</li>";
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
	loadCouponTargetBox($("#couponTargetBox"));
}

/* 추가된 시술 삭제 */
function delHairItem(itemNo) {
	var item = $(".addedHair[hairNo=" + itemNo + "]").get();
	var price = $(item).attr("hairPrice") * $(item).attr("quantity");
	$(".addedHair[hairNo=" + itemNo + "]").remove();
	
	var totalAmount = $("#totalAmount").attr("totalAmount")*1 - price;
	var totalAmountStr = totalAmount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	$("#totalAmount").attr("totalAmount", totalAmount);
	$("#totalAmount").text(totalAmountStr);
	
	calTotalPrice();
	loadCouponTargetBox($("#couponTargetBox"));
}

function calTotalPrice() {
	var totalAmount = $("#totalAmount").attr("totalAmount") * 1;
	var discountAmount = $("#discountAmount").attr("discountAmount") * 1;
	
	var totalPrice = (totalAmount - discountAmount).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	$("#totalPrice").attr("totalPrice", totalAmount-discountAmount);
	$("#totalPrice").text(totalPrice);
}

/* 모달창에서 booking 선택 완료시 주문화면에 set */
$(document).on("click", "#bookingSearchModalConfirm", function(){ 
	setBookingInfoDiv();
	setBookingData();
});


/* 모달창에서 guest 선택 완료 */
$(document).on("click", "#guestSearchModalConfirm", function(){
	setOrderViewClear();
	
	selectedGuestId = $("#guestSearchTable .table-primary td").eq(1).text();
	$("#guestInput").prop("readonly", true);
	$("#nonMemberCK").prop("checked", false);
	$("div[name=bookingDetail]").text("-");	
	$("#guestInput").val(selectedGuestId);
	
	loadCouponList(selectedGuestId);
});


function setBookingData(){
    var url = "orderForm.do";
    $.ajax({
        type: "POST",
        url: url,
        data: { bookNo: selectedBookingNo },
        dataType: "json",
        success: function(data){
            setBookingData_return(data);
            setBookingInfo(data);
        }
    });
    
}

function setBookingData_return(data){
    selBooking = data;
    console.log("예약 정보");
    console.log(data);
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
	
	$("div [name=bookingDetail]").empty();
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
	
	var bookingDiv = "예약번호 : " + selBooking.bookNo + "<br>예약일 : " + bookDateStr + " " + bookTimeStr + "<br>아이디 : " + selBooking.guest.guestId + "<br>시술 : "
					+ (selBooking.hairList.length == 1 ? selBooking.hairList[0].hair.hairName : selBooking.hairList[0].hair.hairName + " 외 " + (selBooking.hairList.length - 1 ) + "건" )
					+ "<br>디자이너 : " + selBooking.designer.deName + "<br>연락처 : " + selBooking.guest.guestPhone;
	
	$("div [name=bookingDetail]").append(bookingDiv);
	
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
		url: "orderForm.do",
		type: "post",
		dataType: "json",
		data: {
			guestId: guestId
		},
		success: function(data) {
			loadCouponBox($("#couponBox"), data);
			$("#couponBox").prop("disabled", false);
			loadCouponTargetBox($("#couponTargetBox"));
			$("#couponTargetBox").prop("disabled", true);
		},
		error: function(error) {
			alert("쿠폰 리스트를 불러오는데 실패했습니다.");
			console.log(error.responseText);
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
};


/* 고객 검색 기능부 */

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
			loadGuestSearchTable($("#guestSearchTable tbody"), data);
		},
		error: function(error) {
			alert("고객 검색 테이블을 불러오는 데 실패했습니다.");
		}
	});
}

//페이지 로드시 1페이지 셋팅
$(function() {
	searchGuest(1, null, null);
});

$(document).on("click", "#guestSearchBtn", function() {
	var opt = $("#guestSearchOpt").val();
	var input = $("#guestSearchInput").val();
	searchGuest(1, opt, input);
});


$(document).on("click", "#guestSerachModalOpenBtn", function() {
	if(!selectedGuestId) {
		$("#guestSearchTable .table-primary").removeClass("table-primary");
	}
});

$(document).on("click", "#bookingSerchModalOpenBtn", function() {
	console.log(selectedBookingNo);
	if(!selectedBookingNo) {
		$("#todayBookingTable .table-primary").removeClass("table-primary");
	}
});


$(document).on("keydown", "#guestSearchInput", function(event) {
	if (event.keyCode === 13) {
		event.preventDefault();
		
		var opt = $("#guestSearchOpt").val();
		var input = $("#guestSearchInput").val();
		searchGuest(1, opt, input);
	};
});


function loadGuestSearchTable(target, data) {
	target.empty();
	
	var guestList = data.guestList;
	var paging = data.paging;
	
	var dataArr = "";
	console.log(data.guestList);
	
	if(data.guestList == null) {
		dataArr += "<tr><td colspan='4'>조건에 부합하는 검색 결과가 존재하지 않습니다.</td></tr>";
		target.append(dataArr);
	} else {
		$.each(guestList, function(index, item) {
			dataArr += "<tr role='button'><td></td><td>" + item.guestId + "</td><td>" + item.guestName + "</td><td>" + item.guestPhone + "</td></tr>";
		});
		target.append(dataArr);
		
		// 조회 결과 넘버링
		$("#guestSearchTable tbody tr td:first-child()").each(function(index, item) {
			$(item).text((paging.nowPage-1) * paging.cntPerPage + index + 1);
		});
	}
	
	// 조회 결과 페이징
	var pageArr = "";
	if(paging.endPage == 1 || paging.endPage == 0) {
		// 시작 페이지가 0? 표시만 하기?
		pageArr += "<li class='page-item previous disabled'><a href='#' class='page-link'><</a></li>";
		pageArr += "<li class='page-item active'><a href='#' class='page-link' nowPage='" + paging.startPage + "'>" + paging.startPage + "</a></li>";
		pageArr += "<li class='page-item next disabled'><a href='#' class='page-link'>></a></li>";
	}  else {
		if(paging.nowPage == 1) {
			pageArr += "<li class='page-item previous disabled'><a href='#' class='page-link'><</a></li>";
		} else {
			pageArr += "<li class='page-item previous'><a href='#' class='page-link' nowPage='" + (paging.nowPage-1) + "'><</a></li>";
		}
		
		for(var i = paging.startPage; i <= paging.endPage; i++) {
			if(i == paging.nowPage) {
				// i // 현재 페이지 표시만
				pageArr += "<li class='page-item active'><a href='#' class='page-link' nowPage='" + i + "'>" + i + "</a></li>";
			} else {
				// nowPage=i
				pageArr += "<li class='page-item'><a href='#' class='page-link' nowPage='" + i + "'>" + i + "</a></li>";
			}
		}
		
		if(paging.nowPage >= paging.endPage) {
			pageArr += "<li class='page-item next disabled'><a href='#' class='page-link'>></a></li>";
		} else {
			pageArr += "<li class='page-item next'><a href='#' class='page-link' nowPage='" + (paging.nowPage+1) + "'>></a></li>";
		}
	}
	
	if(paging.endPage != paging.lastPage) {
		// nowPage=paging.endPage+1
		pageArr += "<li class='page-item'><a href='#' class='page-link' nowPage='" + paging.endPage+1 + "'>" + paging.endPaging+1 + "</a></li>";
	}
	
	$("#guestSearchTable_paginate ul").empty(pageArr);
	$("#guestSearchTable_paginate ul").append(pageArr);
}


$(document).on("click", ".page-item:not('.disabled')", function(){
	var nowPage = $(this).children().attr("nowPage");
	var opt = $("#guestSearchOpt").val();
	var input = $("#guestSearchInput").val();
	searchGuest(nowPage, opt, input);
});


/* 쿠폰 또는 쿠폰 적용 대상 시술 변경시 할인 금액 변화 */
// 쿠폰 박스 변경시
$(document).on("change", "#couponBox",function() {
	var couponTargetBox = $("#couponTargetBox");
	if($("#couponBox").val() == "") {
		$(couponTargetBox).val("");
		$(couponTargetBox).prop("disabled", true);
	} else {
		$(couponTargetBox).prop("disabled", false);
	}
	changeDiscountAmount($("#discountAmount"));
});

// 쿠폰 적용 대상 변경시
$(document).on("change", "#couponTargetBox" ,function() {
	changeDiscountAmount($("#discountAmount"));
});

function changeDiscountAmount(target){
	var saleRate = $("#couponBox option:selected").attr("saleRate");
	var unitPrice = $("#couponTargetBox option:selected").attr("hairPrice");
	var discount = 0;
	
	if(saleRate != undefined && unitPrice != undefined) {
		discount = saleRate * unitPrice;
	}
	
	$(target).text(discount);
	$(target).attr("discountAmount", discount);
	calTotalPrice();
}

$(document).on("click", "#orderRegBtn", function() {
	var order = readInputOrder();
	if(order == undefined) {
		return;
	}
	
	var info;
	if(selectedBookingNo == null) {
		selectedBookingNo = 0;
	}
	
	info = {
		bookNo: selectedBookingNo,
		order: order
	};
	
	console.log(info);
	alert(JSON.stringify(info));
	/*
	$.ajax({
		url: "orderRegister.do",
		type: "post",
		dataType: "text",
		data: JSON.stringify(info),
		success: function(data) {
			if(data != 0) {
				alert("주문이 등록되었습니다.");
				location.href="orderList.do";
//				location.href="orderDetail.do?no="+data;
			} else {
				console.log(data);
			}
		},
		error: function(error) {
			console.log(error)
			alert("주문 등록에 실패했습니다.");
		}
	});
	*/
});

/* 주문등록 버튼 클릭 시 input 값들 다 읽어오기 */
function readInputOrder(){
	var guestId;
	
	if($("#nonMemberCK").is("checked")) {
		guestId = "nonmember";
	} else {
		$("#guestInput").prop("disabled", false);
		guestId = $("#guestInput").val();
	}

	if(guestId.length == 0) {
		alert("고객을 선택해주세요.");
		return;
	}
	
	var deNo = $("#designerSelector").val();
	if(deNo.length == 0) {
		alert("디자이너를 선택해주세요.");
		return;
	}
	
	if($("#addedHairList tr").length == 0) {
		alert("시술을 선택해주세요.");
		return;
	}
	
	// 상세주문 리스트
	var odList = new Array();
	var couponTargetNo = $("#couponTargetBox").val();
	
	$("#addedHairList tr").each(function(i, item) {
		var coupon = null;
		if (couponTargetNo == $(item).attr("hairNo")) {
			coupon = { couponId: $("#couponBox").val() };
		}
		var od = {
				hair: {	hairNo: $(item).attr("hairNo") },
				odQuantity: $(item).attr("quantity"),
				coupon: coupon
		};
		
		odList.push(od);
	})
	
	
	
	var order = {
			guest: { guestId: guestId },
			designer: { deNo: deNo },
			odList: odList
	};
	
	return order;
}