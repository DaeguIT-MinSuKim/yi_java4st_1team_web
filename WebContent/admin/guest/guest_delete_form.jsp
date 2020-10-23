<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<div>
<form method="post" name="formm">
<input type="hidden" name="guest" value="${guest.guestId}">
${data }
<p style="">${guest.guestName}(${guest.guestId})님을 탈퇴처리 하시겠습니까?</p>
<input type="submit" name="delete" onclick="guest_delete()" value="확인">
<input type="button" onclick="location.href='guestList.do'" value="취소">
</form>
</div>

<%@ include file="../include/footer.jsp" %>