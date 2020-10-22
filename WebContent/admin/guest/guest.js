/**
 * 
 */

function guest_delete(){
	if(confirm('탈퇴처리 하시겠습니까?')== true){
		document.formm.action = "guestDelete.do";
		document.formm.submit();
	}else {
		return;
	}
	
}