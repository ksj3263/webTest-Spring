<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>수정하기</h1>
	<hr>
	<form action="/board_edit_result" method="post">					
		<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal" var="principal"/>
			<input type="hidden" name="bWriter" value="${principal.username }">
		</sec:authorize>
		<input type="hidden" name="bId" value="${board.bId}">
		<p><input type="text" name="bTitle" value="${board.bTitle }"></p>
		<p><textarea style="resize:vertical;" name="bContent" cols="40" rows="8">${board.bContent }</textarea></p>
		<button type="submit">수정하기</button>			
	</form>
	<a href="/board_list"><button>돌아가기</button></a>	
</body>
</html>