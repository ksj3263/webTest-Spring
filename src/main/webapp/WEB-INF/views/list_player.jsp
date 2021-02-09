<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div id="playerList">
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
				<td><img src="${list.p_thumb }" width=50px height=50px id="${list.p_num }" class="drag"> </td>
				<td>${list.p_position }</td>
				<td>${list.p_attribute }</td>
				<td>${list.p_tier}</td>
			</tr>
		</c:forEach>
	</table>
	
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
<script>
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
</script>