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
	
	<p> 스톤1 :
		<select name="stone1">
			<option value="am">열혈</option>
			<option value="wh">질풍</option>
			<option value="th">천둥</option>
			<option value="li">섬광</option>
			<option value="da">암흑</option>
		</select>
	</p>
	<p> 스톤2 :
		<select name="stone2">
			<option value="am">열혈</option>
			<option value="wh">질풍</option>
			<option value="th">천둥</option>
			<option value="li">섬광</option>
			<option value="da">암흑</option>
		</select>
	</p>
	
	<input type="submit" value="완료">
</form>
<a href="/player_list">돌아가기</a>
<input type="button" value="테스트용" id="btn">
</body>
</html>
