/**
 * 
 */

function info_update(){
	alert('정보가 변경되었습니다');
	location.href="guestInfo.do?id=" + '${guest.guestId}';
};

function go_save() {
	  if (document.formm.id.value == "") {
	    alert("아이디를 입력하여 주세요.");
	    document.formm.id.focus();
	    return;
	    
	  } else if (document.formm.id.value != document.formm.reid.value) {
	    alert("중복확인을 클릭하여 주세요.");
	    document.formm.id.focus();
	    return;
	  } else if (document.formm.pwd.value == "") {
	    alert("비밀번호를 입력해 주세요.");
	    document.formm.pwd.focus();
	    return;
	  } else if ((document.formm.pwd.value != document.formm.pwdCheck.value)) {
	    alert("비밀번호가 일치하지 않습니다.");
	    document.formm.pwd.focus();
	    return;
	  } else if (document.formm.name.value == "") {
	    alert("이름을 입력해 주세요.");
	    document.formm.name.focus();
	    return;
	  } else if (document.formm.email.value == ""  ) {
	    alert("이메일을 입력해 주세요.");
	    return;
	    
	/*    document.formm.email.focus();
	    var email = document.getElementById("email").value;
		var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
				if(exptext.test(email)==false){
			//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
		alert("이 메일형식이 올바르지 않습니다.");*/
			
	  } else if (document.formm.birth.value == "") {
		 alert("생년월일을 입력해 주세요.");
		 document.formm.birth.focus();
		 return;
	  } else if (document.formm.phone.value == "") {
		alert("연락처를 입력해 주세요.");
		document.formm.phone.focus();
		return;
	  } else if(document.formm.gender[0].checked == false && document.formm.gender[1].checked == false ){
		  alert('성별을 체크해주세요.');
		  return;
	  } else {
	    document.formm.action = "guestAdd.do";
	    document.formm.submit();
	    alert('고객이 등록되었습니다.')
	  }
	}


	function idcheck() {
	/*  if (document.formm.id.value == "") {
	    alert('아이디를 입력하여 주십시오.');
	    document.formm.id.focus();
	    return;
	  }*/
	  var url = "idCheck.do?id=" 
	+ document.formm.id.value;
	  window.open( url, "_blank_1",
	"toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=400, height=200");
	}
	
	
function go_order(){
	location.href="bookingToOrder.do?no=${no}"
}

function event_add(){
	alert('이벤트등록');
	document.formm.action = "eventAdd.do";
    document.formm.submit();
}
