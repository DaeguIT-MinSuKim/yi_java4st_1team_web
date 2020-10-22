<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<script>
$(function(){
	$(document).ready(function() {
		
	});
	document.title += ' - 예약 목록'
	
	/* 헤어 대분류 선택시 소분류 불러오기 */
	$("#hairkindbox li").on("click", function() {
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
				+ item.hairNo + "'>[" + item.hairNo + "] "+ item.hairName+ "</li>";
			index++;
		});
		
		console.log(dataArr);
		console.log(target);
		target.append(dataArr);
	};
	
	
	$("#hairbox li").on("click", function() {
		alert("눌렀다!");
		//var hairNo = $(this).attr("hairNo");
		//var hairName = $(this).text();

		/* addHair(hairNo, hairName);
		
		if($(this).hasClass("active")) {
			return;
		}
		
		$("#hairkind .active").removeClass("active");
		$(this).addClass("active"); */
	});
	
	/* function addHair(hairNo, hairName) {
		// console.log($(".addedHair[hairNo=" + itemNo + "]").attr("hairName"));
		// $(".addedHair[hairNo=" + itemNo + "]").remove();
		if(hairNo == 0) {
			return;
		}
		
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
	} */
});
	
</script>
			<!-- Page Heading -->
          <h1 class="h3 mb-2 text-gray-800 font-weight">등록 페이지</h1>
          <p class="mb-4">여기에 간단한 설명 추가해주세요. 이렇게 링크도 달아도 됩니다. <a target="_blank" href="https://datatables.net">링크</a></p>

          <!-- card -->
          <div class="card shadow mb-4" style="width: 800px;">
            <div class="card-header py-2">
              <h6 class=" font-weight-bold text-primary" style="font-size: 1.3em;">
                <div class="mt-2 pl-3 float-left">
               		주문하기
                </div>
                <div class="float-right">
                  <a href="#" id="prevPage" class="btn btn-secondary btn-sm" style="margin-right: 10px;"><span class="text">이전</span></a>
                  <a href="#" id="nextPage" class="btn btn-secondary btn-sm" style="margin-right: 10px;"><span class="text">다음</span></a>
                  <a href="#" id="toList" class="btn btn-primary btn-sm" style="margin-right: 10px;"><span class="text">목록</span></a>
                </div>			
                <!-- <a href="#" class="btn btn-danger btn-sm" style="float: right;">
                  <span class="text">삭제</spa>
                </a>
                <a href="#" class="btn btn-info btn-sm" style="float: right;  margin-right: 10px;">
                  <span class="text">수정</span>
                </a> -->
              </h6>
            </div>
            <!-- card-body -->
            <div class="card-body p-5">
              <form>
                <div class="form-group row">
                  <label for="inputEmail3" class="col-sm-3 col-form-label font-weight-bold">고객</label>
                  <div class="col-sm-5">
                    <input type="email" class="form-control" id="inputEmail3" placeholder="검색 후 선택해주세요.">
                  </div>
                  <div class="col-auto">
                    <a href="#" class="btn btn-primary btn-sm">
                      <span class="text">검색</spa>
                    </a>
                  </div>
                </div>
                <div class="form-group row">
                  <label for="inputPassword3" class="col-sm-3 col-form-label font-weight-bold">예약건</label>
                  <div class="col-sm-5" name="bookingDetail">
						예약 고객인 경우 검색 후 해당 예약건을 선택해주세요.
                  </div>
                </div>

                <div class="col-sm divider"></div>

                <div class="form-gruop row">
                  <label for="designerSelector" class="col-sm-3 col-form-label font-weight-bold">디자이너</label>
                    <div class="col-sm-5">
                      <select class="form-control" id="designerSelector">
                        <option value="">- 디자이너 선택 -</option>
                        <c:forEach items="${deList }" var="de">
                        	<option value="${de.deNo }">${de.deName} ${de.deLevel }</option>
                        </c:forEach>
                      </select>
                    </div>
                </div>

                <div class="col-sm divider"></div>
                <div class="spacing"></div>

                <h7 class="mb-3 font-weight-bold">시술 대분류</h7>
                <ul class="list-group list-group-horizontal-md" id="hairkindbox">
               		<c:forEach items="${hairKindList }" var="hk">
                  		<li class="list-group-item flex-fill text-center" role="button" id="hairkindbox" kindNo="${hk.kindNo }">${hk.kindNo }. ${hk.kindName }</li>
                	</c:forEach>
                </ul>

                <div class="spacing"></div>
                
                <h7 class="mt-3 mb-3 font-weight-bold">시술 소분류</h7>
                <ul class="list-group list-group-horizontal-md" id="hairbox">
                </ul>
                
                <div class="spacing bg"></div>

				<ul class="addedHairList">
				</ul>
				
                <div class="form-group row">
                  <div class="col-sm" style="text-align: right;">
                    <button type="submit" class="btn btn-primary">등록</button>
                  </div>
                </div>
              </form>
            </div>
            <!-- cardBody-->
            <!-- card-footer -->
            <div class="card-footer p-1">
              <div class="row control-inline">
                <div class="col-12 text-right">
                  <!-- <a href="#" id="prevPage" class="btn btn-secondary btn-sm" style="margin-right: 10px;"><span class="text">이전</span></a>
                  <a href="#" id="nextPage" class="btn btn-secondary btn-sm" style="margin-right: 10px;"><span class="text">다음</span></a>
                  <a href="#" id="toList" class="btn btn-primary btn-sm" style="margin-right: 10px;"><span class="text">목록</span></a> -->
                  <a href="#" class="btn btn-danger btn-sm" ><span class="text">삭제</span></a>
				          <a href="#" class="btn btn-warning btn-sm" ><span class="text-gray-800">주문하기</span></a>
                </div>
              </div>
            </div>
            <!-- card-footer -->
          </div>

<%@ include file="../include/footer.jsp"%>
