<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="file_upload" method="post" enctype="multipart/form-data">
	<p> 선수명 : <input type="text"></p>
	<p> 이미지 : <input id="filename" name="filename" type="file"></p>
	<input type="submit" value="완료">
</form>
<a href="/player_list">돌아가기</a>
<input type="button" value="테스트용" id="btn">
</body>
</html>
