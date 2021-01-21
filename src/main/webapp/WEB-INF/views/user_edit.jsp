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
	<form>
		<p> username : ${user.username } <input type="hidden" value="${user.username}" name="username"></p>
		<p> uName : <input type="text" value="${user.uName }" name="uName"></p>
		<p> datetime : ${user.uDateTime}</p>
		
		 <c:choose>
			<c:when test="${user.isAccountNonExpired }">
				<p> isAccountNonExpired <input type="checkbox" checked name="ANE"></p>
			</c:when>
			<c:when test="${not user.isAccountNonExpired }">
				<p> isAccountNonExpired <input type="checkbox" name="ANE"></p>
			</c:when>
		</c:choose>
		
		<c:choose>		
			<c:when test="${user.isAccountNonLocked }">
				<p> isAccountNonLocked <input type="checkbox" checked name="ANL"></p>
			</c:when>
			<c:when test="${not user.isAccountNonLocked }">
				<p> isAccountNonLocked <input type="checkbox" name="ANL"></p>
			</c:when>
		</c:choose>
		
		<c:choose>
			<c:when test="${user.isCredentialsNonExpired }">
				<p> isCredentialsNonExpired <input type="checkbox" checked name="CNE"></p>
			</c:when>
			<c:when test="${not user.isCredentialsNonExpired }">
				<p> isCredentialsNonExpired <input type="checkbox" name="CNE"></p>
			</c:when>
		</c:choose>
		
		<c:choose>		
			<c:when test="${user.isEnabled }">
				<p> isEnabled <input type="checkbox" checked name="E"></p>
			</c:when>
			<c:when test="${not user.isEnabled }">
				<p> isEnabled <input type="checkbox" name="E"></p>
			</c:when>
		</c:choose>
		
		<input type="submit" value="수정하기">	
	</form>
	<a href="/user_detail?username=${user.username }"><input type="button" value="돌아가기"></a>	
</body>
<script>
$('form').on('submit', function (event) {	
	let ANE = $("input:checkbox[name=ANE]").is(":checked");
	let ANL = $("input:checkbox[name=ANL]").is(":checked");
	let CNE = $("input:checkbox[name=CNE]").is(":checked");
	let E = $("input:checkbox[name=E]").is(":checked");
	let uName = $('input[name="uName"]').val();
	let username = $('input[name="username"]').val();
	let url = '/user_edit_result?username=' + username;
	
	console.log(ANE);
	console.log(ANL);
	console.log(CNE);
	console.log(E);
	console.log(uName);

	$.ajax({
		  method: "POST",
		  url: url,
		  data: { ANE: ANE, ANL: ANL, CNE: CNE, E: E, uName: uName },
		  dataType: "text"
		}).success(function(data) {
			location.href = data + username;
		});

	event.preventDefault();
});
</script>
</html>