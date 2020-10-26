<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<script>
document.title += ' - 고객 목록';
	
function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		location.href="guestList.do?nowPage=1&cntPerPage="+sel;
};

function selectAll(){
	$('[name=check]').prop('checked', true);
};

function deselectAll(){
	$('[name=check]').prop('checked', false);
};


$(document).on('click', '[name=delete]', function() { 
	/* $("#dataTable tr:nth-child(2)").css("background", "red"); */
	 var array = new Array();
    $("#dataTable input[name=check]:checked").each(function() {
    	array.push(this.value);
    });
    console.log(array);
    
    if(array==0){
    	alert('삭제할 회원을 선택하세요');
    	return;
    }
    
   //셀렉트박스 선택한 사람 배열로 ajax로 넘기기
    if(confirm(array + "님을 탈퇴처리 하시겠습니까?") == true){
	    $.ajax({
	  		  type:'post',
	  		  url:'guestDelete.do',
	  		  data:{"string":array},
	  		  async: false,
	  		  success:function(JSON){
	  			  /* alert("성공"); */
	  			  location.reload();
	  		  },
	  		  error:function(){
	  			  alert('삭제할 회원을 선택하세요');
	  		  }
	     	});
    }else {
    	return;
    }
  
    //대현
    /* var delArr = {};
    for(var i=0; i < $("#dataTable input[name=check]:checked").length; i++ ){
  		delArr[i] += $("#dataTable input[name=check]:checked").eq(i).val();
    }
   	
    console.log(delArr);  */
});

$(document).on('click', '[id=btn_delete]', function() { 
	var guest = $(this).attr('guestId');
	if(confirm(guest + '님을 탈퇴처리 하시겠습니까?') == true) {
		location.href="guestDelete.do?id="+guest;	
	}else {
		return;
	}
	
});



</script>

<!-- Page Heading -->
<h1 class="h3 mb-2 text-gray-800 font-weight">웹 고객 등록</h1>
<p class="mb-4">
	<a target="_blank" href="https://datatables.net"></a>
</p>
<form method="post" name="formm">
<!-- DataTales Example -->
<div class="card shadow mb-4">
	<div class="card-header py-2">
		<h6 class="m-1 font-weight-bold text-primary" style="line-height: 16px; font-size: 1.3em">
			
				<input type="button" value="등록" class="btn btn-success btn-sm" style="float: left;  margin-right: 10px;" onclick="location.href='guestAdd.do' ">
				<input type="button"  value="삭제" name="delete" class="btn btn-danger btn-sm" style="float: left;" >
				
		</h6>
	</div>
	<!-- card-body -->
	<div class="card-body">
		<div class="table-responsive">
			<!-- bootStrap table wrapper-->
			<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">


				<!-- 테이블 시작 -->
				<table class="table table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
					<tr><th>~테이블~</th></tr>
				</table>
				<!-- 테이블 끝 -->
			
				
				<!-- 페이징 시작 -->
			
						
					</div>
				</div>
				<!-- bootStrap table wrapper-->
			</div>
			<!-- tableRespnsible -->
		</div>
		<!-- cardBody-->
<!-- 	</div>
</div> -->
</form>
<%@ include file="../include/footer.jsp" %>   