<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<body>
	<form id="form">
		<p> username : ${user.username } <input type="hidden" value="${user.username}" name="username"></p>
		<p> uName : <input type="text" value="${user.uName }" name="uName"></p>
		<p> datetime : ${user.uDateTime}</p>
		
		 <c:choose>
			<c:when test="${user.isAccountNonExpired }">
				<p> isAccountNonExpired <input type="checkbox" checked name="ANE" value="true"></p>
			</c:when>
			<c:when test="${not user.isAccountNonExpired }">
				<p> isAccountNonExpired <input type="checkbox" name="ANE" value="true"></p>
			</c:when>
		</c:choose>
		
		<c:choose>		
			<c:when test="${user.isAccountNonLocked }">
				<p> isAccountNonLocked <input type="checkbox" checked name="ANL" value="true"></p>
			</c:when>
			<c:when test="${not user.isAccountNonLocked }">
				<p> isAccountNonLocked <input type="checkbox" name="ANL" value="true"></p>
			</c:when>
		</c:choose>
		
		<c:choose>
			<c:when test="${user.isCredentialsNonExpired }">
				<p> isCredentialsNonExpired <input type="checkbox" checked name="CNE" value="true"></p>
			</c:when>
			<c:when test="${not user.isCredentialsNonExpired }">
				<p> isCredentialsNonExpired <input type="checkbox" name="CNE" value="true"></p>
			</c:when>
		</c:choose>
		
		<c:choose>		
			<c:when test="${user.isEnabled }">
				<p> isEnabled <input type="checkbox" checked name="E" value="true"></p>
			</c:when>
			<c:when test="${not user.isEnabled }">
				<p> isEnabled <input type="checkbox" name="E" value="true"></p>
			</c:when>
		</c:choose>
		
		<input type="button" onClick="edit();" value="수정하기">
	</form>
	<a href="/user_detail?username=${user.username }"><input type="button" value="돌아가기"></a>
</body>
<script>
function edit() {	
	let form = $('#form')[0];
	let formData = new FormData(form);
	let url = '/user_edit_result';
	let username = $('input[name="username"]').val();
	
	if(!formData.get("ANE"))
		formData.append("ANE", "false");
	if(!formData.get("ANL"))
		formData.append("ANL", "false");
	if(!formData.get("CNE"))
		formData.append("CNE", "false");
	if(!formData.get("E"))
		formData.append("E", "false");
		
	$.ajax({
		type: "POST",
		url: url,
		data: formData,
		processData: false,
		contentType: false,
		dataType: "html"
	}).success(function (data) {
		location.href = data + username;
	});
};
</script>
</html>