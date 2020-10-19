$(document).ready(function() {
	$(function() {
		$('#secret').on("click",function(){
			if($('#secret').is(":checked")){
				$("#secretPwd").attr("readonly", false);
				// document.getElementById('secretPwd').readOnly = false; 
			}else{
				$("#secretPwd").attr("readonly", true);
				$("#secretPwd").val("");
				//document.getElementById('secretPwd').readOnly = true; 
			}
		})
	});
})