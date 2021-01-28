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
<style>
	table {
		border-collapse:collapse;
		margin:40px auto;
	}
	table tr th {
		font-weight:700;
	}
	table tr td, table tr th {
		border:1px solid #818181;
		width:200px;
		text-align:center;
	}
	a {
		text-decoration:none;
		color:#000;
		font-weight:700;
	}
	ul {
		width:600px;
		height:50px;
		margin:10px auto;
	}
	li {
		list-style:none;
		width:50px;
		line-height:50px;
		border:1px solid #ededed;
		float:left;
		text-align:center;
		margin:0 5px;
		border-radius:5px;
	}
</style>
<body>
<form id="form">
	<p> 속성 : 열혈<input type="checkbox" id="열혈" name="am" class="attribute" value="true">
	질풍<input type="checkbox" id="질풍" name="wh" class="attribute" value="true">
	천둥<input type="checkbox" id="천둥" name="th" class="attribute" value="true">
	섬광<input type="checkbox" id="섬광" name="li" class="attribute" value="true">
	암흑<input type="checkbox" id="암흑" name="da" class="attribute" value="true"> </p>
				
	<p> 포지션 : 스트라이커<input type="checkbox" id="스트라이커" name="position" value="스트라이커" class="position">
	어시스터<input type="checkbox" id="어시스터" name="position" value="어시스터" class="position">
	어태커<input type="checkbox" id="어태커" name="position" value="어태커" class="position">
	디펜더<input type="checkbox" id="디펜더" name="position" value="디펜더" class="position">
	리더<input type="checkbox" id="리더" name="position" value="리더" class="position">
	골키퍼<input type="checkbox" id="골키퍼" name="position" value="골키퍼" class="position"> </p>
	
	<p> 등급 : L<input type="checkbox" id="L" name="tier" value="L" class="tier">
	SR<input type="checkbox" id="SR" name="tier" value="SR" class="tier">
	SRB<input type="checkbox" id="SRB" name="tier" value="SRB" class="tier">
	R<input type="checkbox" id="R" name="tier" value="R" class="tier">
	RB<input type="checkbox" id="RB" name="tier" value="RB" class="tier">
	N<input type="checkbox" id="N" name="tier" value="N" class="tier"> </p>	
	
	<input type="text" id="content"> <input type="button" value="검색" id="btn-search"> 
</form>
<br>
<a href="/"><input type="button" value="돌아가기"></a>
<button id="btn-all">전체선택</button> <button id="btn-not-all">선택해제</button>
<input type="button" value="테스트" id="btn-test">
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

<div>
	<ul>
		 <c:choose>
			<c:when test="${ pagination.prevPage < 5 }">
				<li style="display:none;">
					<span>◀</span>
				</li>
			</c:when>
			<c:when test="${ pagination.prevPage >= 5}">
				<li>
					<a href="/player_list?page=${pagination.prevPage}">◀</a>
				</li>
			</c:when>
		</c:choose> 
		<c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}" step="1">				
				<c:choose>
					<c:when test="${ pagination.page eq i }">							
						<li style="background-color:#ededed;">
							<span>${i}</span>
						</li>
					</c:when>
					<c:when test="${ pagination.page ne i }">
						<li>
							<a href="/player_list?page=${i}">${i}</a>
						</li>
					</c:when>
				</c:choose>
		</c:forEach>
		<c:choose>
			<c:when test="${ pagination.nextPage <= pagination.lastPage }">
				<li style="">
					<a href="/player_list?page=${pagination.nextPage}">▶</a>
				</li>
			</c:when>
			<c:when test="${ pagination.nextPage > pagination.lastPage}">
				<li style="display:none;">
					<a href="/player_list?page=${pagination.nextPage}">▶</a>
				</li>
			</c:when>
		</c:choose> 
	</ul>
</div>

<br>
<a href="/player_write"><input type="button" value="선수 추가"></a>
</body>
<script>
$(document).on('click', '#btn-all', function () {
	$("input[type=checkbox]").prop("checked", true);
});

$(document).on('click', '#btn-not-all', function () {
	$("input[type=checkbox]").prop("checked", false);
});

$(document).on('click', '#btn-search', function() {
	let attributes = [];
	let positions = [];
	let tiers = [];
	let content = $('input[id="content"]').val();
	
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
		data: {attributes: attributes, positions: positions, tiers: tiers, checkAttributes: true, checkPositions: true, checkTiers: true, content: content},
		dataType: "html"
	}).success(function(data) {
		$("#playerList").html(data);	
	});
});

$(document).on('click', '#btn-test', function() {
	let params=$("#form").serialize();
	console.log(params);
	
	$.ajax({
		type:"POST",
		url: "/player_test",
		data: params,
		dataType: "html"
	}).success(function(data) {
		console.log("ok");	
	});
});
</script>
</html>