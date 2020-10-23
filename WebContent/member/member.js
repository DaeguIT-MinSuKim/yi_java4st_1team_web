function go_save() {
  if (document.formm.id.value == "") {
    alert("아이디를 입력하여 주세요.");
    document.formm.id.focus();
  } else if (document.formm.id.value != document.formm.reid.value) {
    alert("중복확인을 클릭하여 주세요.");
    document.formm.id.focus();
  } else if (document.formm.pwd.value == "") {
    alert("비밀번호를 입력해 주세요.");
    document.formm.pwd.focus();
  } else if ((document.formm.pwd.value != document.formm.pwdCheck.value)) {
    alert("비밀번호가 일치하지 않습니다.");
    document.formm.pwd.focus();
  } else if (document.formm.name.value == "") {
    alert("이름을 입력해 주세요.");
    document.formm.name.focus();
  } else if (document.formm.email.value == ""  ) {
    alert("이메일을 입력해 주세요.");
    
/*    document.formm.email.focus();
    var email = document.getElementById("email").value;
	var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
			if(exptext.test(email)==false){
		//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			
	alert("이 메일형식이 올바르지 않습니다.");*/
		
  } else if (document.formm.birth.value == "") {
	 alert("생년월일을 입력해 주세요.");
	 document.formm.birth.focus();
  } else if (document.formm.phone.value == "") {
	alert("연락처를 입력해 주세요.");
	document.formm.phone.focus();
  } else if(document.formm.gender[0].checked == false && document.formm.gender[1].checked == false ){
	  alert('성별을 체크해주세요.');
  } else {
    document.formm.action = "join.do";
    document.formm.submit();
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


function go_next() {
  if (document.formm.okon1[0].checked == true && document.formm.okon1[1].checked == true ) {
    document.formm.action = "join.do";
    document.formm.submit();
  } else if (document.formm.okon1[0].checked == false || document.formm.okon1[1].checked == false) {
    alert('약관에 동의하셔야만 합니다.');
  }
}

function go_idSearch() {
	var url="idSearch.do";
	window.open( url, "_blank_1",
	"toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=500, height=400");
}


function go_pwdSearch() {
	var url="pwdSearch.do";
	window.open( url, "_blank_1",
	"toolbar=no, menubar=no, scrollbars=yes, resizable=no, width=500, height=400");
}


function idSearch(){
	if (document.formm.id_name.value == "") {
	    alert('이름을 입력하여 주십시오.');
	    document.formm.id_name.focus();
	    return;
    } else if(document.formm.id_email.value == "") {
	    alert('이메일을 입력하여 주십시오.');
	    document.formm.id_email.focus();
	    return;
    } else{
    	document.formm.action = "idSearch.do";
        document.formm.submit();
    }
};

function pwdSearch(){
	if (document.formm.id.value == "") {
	    alert('아이디를 입력하여 주십시오.');
	    document.formm.id.focus();
	    return;
	} else if(document.formm.name.value == "") {
		 alert('이름을 입력하여 주십시오.');
		 document.formm.name.focus();
		 return;
	} else if(document.formm.email.value == "") {
	    alert('이메일을 입력하여 주십시오.');
	    document.formm.email.focus();
	    return;
    } else {
    	document.formm.action = "pwdSearch.do";
        document.formm.submit();
    }
};

function pwd_confirm(){
	if (document.formm.pwd.value == "") {
	    alert('비밀번호를 입력하여 주십시오.');
	    document.formm.pwd.focus();
	    return;
    } else{
    	document.formm.action = "pwdConfirm.do";
        document.formm.submit();
    }
};


function info_update(){
	alert('정보가 변경되었습니다');
	document.formm.action = "guestInfoUpdate.do";
    document.formm.submit();
    location.reload();
};

function pwd_update(){
	alert('비밀번호가 변경되었습니다.');
	document.formm.action = "guestPwdUpdate.do";
    document.formm.submit();
};

function go_leave(){
	 if (document.formm.ok[0].checked == true && document.formm.ok[1].checked == true && document.formm.ok[2].checked == true ) {
		 if(confirm('탈퇴하시겠습니까?')== true){
			 document.formm.action = "guestInfoDelete.do";
			 document.formm.submit();
		 }else{
			 return;
		 } 
		 
	 } else if (document.formm.ok[0].checked == false || document.formm.ok[1].checked == false ||  document.formm.ok[2].checked == false) {
		 alert('약관에 동의하셔야만 합니다.');
	 }
}

function book_cancel(){
	if(confirm('예약을 취소하시겠습니까?')== true){
		document.formm.action = "guestBookCancel.do";
		document.formm.submit();
	}else {
		return;
	}
	
}
