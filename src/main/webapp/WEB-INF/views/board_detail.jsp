<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>제목 : ${board.bTitle }</p>
	<p>내용 : ${board.bContent }</p>
	<p>날짜 : ${board.bDateTime }</p>
	<p>작성자 : ${board.bWriter }</p>
	<a href="/board_list">돌아가기</a>
</body>
</html>