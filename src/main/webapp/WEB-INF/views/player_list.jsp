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
<p> 속성 : 열혈<input type="checkbox" id="열혈" class="attribute" value="열혈">
질풍<input type="checkbox" id="질풍" class="attribute" value="질풍">
천둥<input type="checkbox" id="천둥" class="attribute" value="천둥">
섬광<input type="checkbox" id="섬광" class="attribute" value="섬광">
암흑<input type="checkbox" id="암흑" class="attribute" value="암흑"> </p>
			
<p> 포지션 : 스트라이커<input type="checkbox" id="스트라이커" value="스트라이커" class="position">
어시스터<input type="checkbox" id="어시스터" value="어시스터" class="position">
어태커<input type="checkbox" id="어태커" value="어태커" class="position">
디펜더<input type="checkbox" id="디펜더" value="디펜더" class="position">
리더<input type="checkbox" id="리더" value="리더" class="position">
골키퍼<input type="checkbox" id="골키퍼" value="골키퍼" class="position"> </p>

<p> 등급 : L<input type="checkbox" id="L" value="L" class="tier">
SR<input type="checkbox" id="SR" value="SR" class="tier">
SRB<input type="checkbox" id="SRB" value="SRB" class="tier">
R<input type="checkbox" id="R" value="R" class="tier">
RB<input type="checkbox" id="RB" value="RB" class="tier">
N<input type="checkbox" id="N" value="N" class="tier"> </p>

<input type="button" id="btn-all" value="전체선택"> <input type="button" id="btn-not-all" value="선택해제"> <br>
<input type="text" id="content"> <input type="button" value="검색" id="btn-search"> <button onclick="history.back()">돌아가기</button>
</div>
<br>
<div id="playerList">
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
				<td><img src="${list.p_thumb }" width=50px height=50px> </td>
				<td>${list.p_position }</td>
				<td>${list.p_attribute }</td>
				<td>${list.p_tier}</td>
			</tr>
		</c:forEach>
	</table>
</div>
<br>
<a href="/player_write">추가하기</a>
<a href="/player_test">이미지 업로드 테스트</a>
<input type="button" value="테스트" id="btn-test">
</body>
<script>
$(document).ready(function () {
	$("input[type=checkbox]").prop("checked", true);
});

$(document).on('click', '#btn-all', function () {
	$("input[type=checkbox]").prop("checked", true);
});

$(document).on('click', '#btn-not-all', function () {
	$("input[type=checkbox]").prop("checked", false);
});

$(document).on('click', '#btn-test', function() {
	let attributeList = [];
	let positionList = [];
	let tierList = [];
	
	$('input[class="attribute"]:checked').each(function(){
		attributeList.push($(this).val());
	});
	console.log(attributeList);
	
	$('input[class="position"]:checked').each(function(){
		positionList.push($(this).val());
	});
	console.log(positionList);
	
	$('input[class="tier"]:checked').each(function(){
		tierList.push($(this).val());
	});
	console.log(tierList);
});

$(document).on('click', '#btn-search', function() {
	let attributes = [];
	let positions = [];
	let tiers = [];
	
	$('input[class="attribute"]:checked').each(function(){
		attributes.push($(this).val());
	});	
	$('input[class="position"]:checked').each(function(){
		positions.push($(this).val());
	});	
	$('input[class="tier"]:checked').each(function(){
		tiers.push($(this).val());
	});
		
	$.ajax({
		type:"POST",
		url: "/player_search",
		data: {attributes: attributes, positions: positions, tiers: tiers, checkAttributes: true, checkPositions: true, checkTiers: true},
		dataType: "html"
	}).success(function(data) {
		$("#playerList").html(data);	
	});
});
</script>
</html>