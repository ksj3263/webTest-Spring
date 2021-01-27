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
				<p> isAccountNonExpired <input type="checkbox" checked name="isAccountNonExpired" value="true"></p>
			</c:when>
			<c:when test="${not user.isAccountNonExpired }">
				<p> isAccountNonExpired <input type="checkbox" name="isAccountNonExpired" value="true"></p>
			</c:when>
		</c:choose>
		
		<c:choose>		
			<c:when test="${user.isAccountNonLocked }">
				<p> isAccountNonLocked <input type="checkbox" checked name="isAccountNonLocked" value="true"></p>
			</c:when>
			<c:when test="${not user.isAccountNonLocked }">
				<p> isAccountNonLocked <input type="checkbox" name="isAccountNonLocked" value="true"></p>
			</c:when>
		</c:choose>
		
		<c:choose>
			<c:when test="${user.isCredentialsNonExpired }">
				<p> isCredentialsNonExpired <input type="checkbox" checked name="isCredentialsNonExpired" value="true"></p>
			</c:when>
			<c:when test="${not user.isCredentialsNonExpired }">
				<p> isCredentialsNonExpired <input type="checkbox" name="isCredentialsNonExpired" value="true"></p>
			</c:when>
		</c:choose>
		
		<c:choose>		
			<c:when test="${user.isEnabled }">
				<p> isEnabled <input type="checkbox" checked name="isEnabled" value="true"></p>
			</c:when>
			<c:when test="${not user.isEnabled }">
				<p> isEnabled <input type="checkbox" name="isEnabled" value="true"></p>
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
	let username = $('input[name="username"]').val();
	let url = '/user_edit_result?username=' + username;
	
	for(var pair of formData.entries()) {
	   console.log(pair[0]+ ', '+ pair[1]);
	}
	
	$.ajax({
		type: "POST",
		url: url,
		data: formData,
		processData: false,
		contentType: false,
		dataType: "html"
	}).success(function (data) {
		console.log("ok");
	});
};
</script>
</html>