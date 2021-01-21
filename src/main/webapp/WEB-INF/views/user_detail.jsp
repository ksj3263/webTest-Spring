<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<p> username : ${user.username }</p>
	<p> uName : ${user.uName }</p>
	<p> datetime : ${user.uDateTime}</p>
	
	 <c:choose>
		<c:when test="${user.isAccountNonExpired }">
			<p> isAccountNonExpired <input type="checkbox" checked disabled></p>
		</c:when>
		<c:when test="${not user.isAccountNonExpired }">
			<p> isAccountNonExpired <input type="checkbox" disabled></p>
		</c:when>
	</c:choose>
	
	<c:choose>		
		<c:when test="${user.isAccountNonLocked }">
			<p> isAccountNonLocked <input type="checkbox" checked disabled></p>
		</c:when>
		<c:when test="${not user.isAccountNonLocked }">
			<p> isAccountNonLocked <input type="checkbox" disabled></p>
		</c:when>
	</c:choose>
	
	<c:choose>
		<c:when test="${user.isCredentialsNonExpired }">
			<p> isCredentialsNonExpired <input type="checkbox" checked disabled></p>
		</c:when>
		<c:when test="${not user.isCredentialsNonExpired }">
			<p> isCredentialsNonExpired <input type="checkbox" disabled></p>
		</c:when>
	</c:choose>
	
	<c:choose>		
		<c:when test="${user.isEnabled }">
			<p> isEnabled <input type="checkbox" checked disabled></p>
		</c:when>
		<c:when test="${not user.isEnabled }">
			<p> isEnabled <input type="checkbox" disabled></p>
		</c:when>
	</c:choose>
	
	<a href="/user_edit?username=${user.username }"><input type="button" value="수정하기"></a>
	<a href="/user_del?username=${user.username }"><input type="button" value="삭제하기"></a>
	<a href="/user_list"><input type="button" value="돌아가기"></a>
</body>
</html>