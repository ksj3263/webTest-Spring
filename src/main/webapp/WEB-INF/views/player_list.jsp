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
<div>
<p> 속성 : 열혈<input type="checkbox"> 질풍<input type="checkbox"> 천둥<input type="checkbox"> 섬광<input type="checkbox"> 암흑<input type="checkbox"> </p>
<p> 포지션 : 스트라이커<input type="checkbox"> 스트라이커(원거리)<input type="checkbox"> 골키퍼<input type="checkbox"> 어태커<input type="checkbox"> 디펜더<input type="checkbox"></p>
<p> &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 어시스터(지정)<input type="checkbox"> 어시스터(전방)<input type="checkbox"> 어시스터(세로)<input type="checkbox"> 어시스터(롱)<input type="checkbox"> 리더<input type="checkbox"> </p>
<p> 등급 : LR<input type="checkbox"> SR<input type="checkbox"> SRB<input type="checkbox"> R<input type="checkbox"> RB<input type="checkbox"> N<input type="checkbox"> </p>
<input type="button" id="btn-all" value="전체선택"> <input type="button" id="btn-not-all" value="선택해제"> <br>
<input type="text"> <input type="button" value="검색"> <a href="/">돌아가기</a>
</div>
<br>
<table border=1>
	<tr>
		<td>이름</td>
		<td>이미지</td>
		<td>포지션</td>
		<td>속성</td>
		<td>등급</td>
	</tr>
	<c:forEach var="list" items="${list }">
		<tr>
			<td><a href="/player_detail?p_num=${list.p_num}">${list.p_name }</a></td>
			<td><img src="${list.p_image }" width=50px height=50px> </td>
			<td>${list.p_position }</td>
			<td>${list.p_attribute }</td>
			<td>${list.p_tier}</td>
		</tr>
	</c:forEach>
</table>
</body>
<script>
$(document).on('click', '#btn-all', function () {
	$("input[type=checkbox]").prop("checked", true);
});

$(document).on('click', '#btn-not-all', function () {
	$("input[type=checkbox]").prop("checked", false);
});
</script>
</html>