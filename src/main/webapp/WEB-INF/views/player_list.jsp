<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
	<p> 속성 : 열혈<input type="checkbox" id="열혈" name="attributes" value="열혈">
	질풍<input type="checkbox" id="질풍" name="attributes" value="질풍">
	천둥<input type="checkbox" id="천둥" name="attributes" value="천둥">
	섬광<input type="checkbox" id="섬광" name="attributes" value="섬광">
	어둠<input type="checkbox" id="어둠" name="attributes" value="어둠"> </p>
				
	<p> 포지션 : 스트라이커<input type="checkbox" id="스트라이커" name="positions" value="스트라이커">
	어시스터<input type="checkbox" id="어시스터" name="positions" value="어시스터">
	어태커<input type="checkbox" id="어태커" name="positions" value="어태커">
	디펜더<input type="checkbox" id="디펜더" name="positions" value="디펜더">
	리더<input type="checkbox" id="리더" name="positions" value="리더">
	골키퍼<input type="checkbox" id="골키퍼" name="positions" value="골키퍼"> </p>
	
	<p> 등급 : L<input type="checkbox" id="L" name="tiers" value="L">
	SR<input type="checkbox" id="SR" name="tiers" value="SR">
	SRB<input type="checkbox" id="SRB" name="tiers" value="SRB">
	R<input type="checkbox" id="R" name="tiers" value="R">
	RB<input type="checkbox" id="RB" name="tiers" value="RB">
	N<input type="checkbox" id="N" name="tiers" value="N"> </p>	
	
	<input type="text" name="content" id="content"> <input type="button" value="검색" id="btn-search"> 
</form>
<br>
<a href="/"><input type="button" value="돌아가기"></a>
<button id="btn-all">전체선택</button> <button id="btn-not-all">선택해제</button>
<sec:authorize access="isAuthenticated()">
	<a href="/player_write"><input type="button" value="선수 추가"></a>	
</sec:authorize>
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
					<a href="javascript:void(0);" class="page" id="${pagination.prevPage}">◀</a>
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
							<a href="javascript:void(0);" class="page" id="${i }">${i}</a>
						</li>
					</c:when>
				</c:choose>
		</c:forEach>
		<c:choose>
			<c:when test="${ pagination.nextPage <= pagination.lastPage }">
				<li style="">
					<a href="javascript:void(0);" class="page" id="${pagination.nextPage}">▶</a>
				</li>
			</c:when>
			<c:when test="${ pagination.nextPage > pagination.lastPage}">
				<li style="display:none;">
					<a href="javascript:void(0);" class="page" id="${pagination.nextPage}">▶</a>
				</li>
			</c:when>
		</c:choose> 
	</ul>
</div>
</body>
<script>
$(document).ready(function() {
	let content = "${search.content}";
			
	<c:forEach var="item" items="${search.attributes }">
		$("input[id=${item}]").prop("checked", true);
	</c:forEach>
	<c:forEach var="item" items="${search.positions }">
		$("input[id=${item}]").prop("checked", true);
	</c:forEach>
	<c:forEach var="item" items="${search.tiers }">
		$("input[id=${item}]").prop("checked", true);
	</c:forEach>
	$("#content").val(content);

	$(document).on('click', '.page', function() {
		$("input[type=checkbox]").prop("checked", false);
		<c:forEach var="item" items="${search.attributes }">
			$("input[id=${item}]").prop("checked", true);
		</c:forEach>
		<c:forEach var="item" items="${search.positions }">
			$("input[id=${item}]").prop("checked", true);
		</c:forEach>
		<c:forEach var="item" items="${search.tiers }">
			$("input[id=${item}]").prop("checked", true);
		</c:forEach>
		$("#content").val(content);
		
		let params=$("#form").serialize();
		let id = $(this).attr('id');
		let url = "/player_list?page=" + id + "&" + params;
		
		location.href = url;
	});
});

$(document).on('click', '#btn-all', function () {
	$("input[type=checkbox]").prop("checked", true);
});

$(document).on('click', '#btn-not-all', function () {
	$("input[type=checkbox]").prop("checked", false);
});

$(document).on('click', '#btn-search', function() {
	let params=$("#form").serialize();
	let url = "/player_list?" + params;
	
	location.href = url;
});
</script>
</html>
