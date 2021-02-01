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
	<p> 선수명 : ${player.p_name }</p>
	<p> 선수 이미지 <br> <img src="${player.p_full }" width=236px height=338px></p>
	<p> 포지션 : ${player.p_position } </p>
	<p> 속성 : ${player.p_attribute } </p>
	<p> 등급 : ${player.p_tier } </p>
	<p> 파워 : ${player.p_power }</p>
	<p> 테크닉 : ${player.p_technique }</p>
	<p> 피지컬 : ${player.p_physical }</p>
	<p> 스피드 : ${player.p_speed }</p>
	
	<p> 에이스 : ${player.p_name_ace} - ${player.p_ace }</p>
	<p> 액티브 : ${player.p_name_a} - ${player.p_active}</p>
	<p> 패시브1 : ${player.p_name_p1} - ${player.p_passive1}</p>
	<p> 패시브2 : ${player.p_name_p2} - ${player.p_passive2}</p>
	<p> 패시브3 : ${player.p_name_p3} - ${player.p_passive3}</p>
	
	<p> 스톤1 : ${player.p_stone1} </p>
	<p> 스톤2 : ${player.p_stone2} </p>
	<p> 스톤3 : ${player.p_stone3} </p>
	
	<p> 업데이트 날짜 : ${player.p_date } </p>
	
	<c:choose>
		<c:when test="${player.p_tier == 'L' }">		
			<p> 결전기 : ${player.p_coop }</p>
		</c:when>
		<c:when test="${player.p_tier == 'SR' }">				
			<p> 협동기 : ${player.p_coop }</p>
			<p> 협동 선수1 : ${player.p_coop1 }</p>
			<p> 협동 선수2 : ${player.p_coop2 }</p>
			<p> 협동 선수3 : ${player.p_coop3 }</p>
		</c:when>
	</c:choose>
		
	<p> 스토리 : </p>
	<textarea id="story" style="resize:none;" cols=200 disabled>${player.p_story }</textarea>
	<p> 일러스트레이터 : ${player.p_ill }</p>
	<p> CV : ${player.p_cv }</p>
	
	<a href="/player_edit?p_num=${player.p_num }">수정하기</a>
	<a href="/player_list">돌아가기</a>
</body>
<script>
$(document).ready(function() {
	let textArea = $('#story');
	textArea[0].style.height = 'auto';
	let textAreaHeight = textArea.prop('scrollHeight');
	textArea.css('height', textAreaHeight);
});
</script>
</html>