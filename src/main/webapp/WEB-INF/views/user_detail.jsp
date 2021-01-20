<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
	<a href="/user_list"><input type="button" value="돌아가기"></a>
</body>
</html>