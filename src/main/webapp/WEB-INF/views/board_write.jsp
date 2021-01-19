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
	<h1>글쓰기</h1>
	<hr>
	<form action="/board_write_result" method="post">					
		<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal" var="principal"/>
			<input type="hidden" name="bWriter" value="${principal.username }">
		</sec:authorize>
		<p><input type="text" name="bTitle"></p>
		<p><textarea style="resize:vertical;" name="bContent" cols="40" rows="8"></textarea></p>
		<button type="submit">작성하기</button>			
	</form>
	<a href="/board_list"><button>돌아가기</button></a>	
</body>
</html>