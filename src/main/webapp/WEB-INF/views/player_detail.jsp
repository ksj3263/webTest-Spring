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
	
	<c:choose>
		<c:when test="${player.p_tier == 'L' }">		
			<p> 결전기 : ${player.p_coop }<br>
			${player.p_coop_count }회 사용 가능/${player.p_coop_cool }분 후 재사용 가능/경기 시작 ${player.p_coop_pre }분 후 사용 가능</p>
		</c:when>
		<c:when test="${player.p_tier == 'SR' }">				
			<p> 협동기 : ${player.p_coop } <br>
			${player.p_coop_count }회 사용 가능/${player.p_coop_cool }분 후 재사용 가능/경기 시작 ${player.p_coop_pre }분 후 사용 가능</p>
			<p> 협동 선수 :<br>
			<a href="/player_detail?p_name=${player.p_coop1 }">${player.p_coop1 }</a>
			<a href="/player_detail?p_name=${player.p_coop2 }"> ${player.p_coop2 }</a>
			<a href="/player_detail?p_name=${player.p_coop3 }"> ${player.p_coop3 }</a></p>
			<p> 연관 선수 :<br>
			<a href="/player_detail?p_name=${player.p_r1 }"> ${player.p_r1 }</a>
			<a href="/player_detail?p_name=${player.p_r2 }"> ${player.p_r2 }</a>
			<a href="/player_detail?p_name=${player.p_r3 }"> ${player.p_r3 }</a></p>
		</c:when>
	</c:choose>
		
	<p> 스토리 : </p>
	<textarea id="story" style="resize:none; width:90%;" disabled>${player.p_story }</textarea>
	<p> 일러스트레이터 : ${player.p_ill }</p>
	<p> CV : ${player.p_cv }</p>
	<p> 업데이트 날짜 : ${player.p_date } </p>	
	
	<a href="/player_edit?p_num=${player.p_num }">수정하기</a>
	<a href="/player_list">돌아가기</a>
	
	<br>
	<p> 관련 스킨 </p>
	<table border=1>
		<tr>
			<td>이름</td>
			<td>이미지</td>
			<td>종류</td>
			<td>등급</td>
		</tr>
		<c:forEach var="slist" items="${slist }">
			<tr>
				<td><a href="/skin_detail?s_num=${slist.s_num}">${slist.s_name }</a></td>
				<td><img src="${slist.s_thumb }" width=50px height=50px> </td>
				<td>${slist.s_property }</td>
				<td>${slist.s_tier}</td>
			</tr>
		</c:forEach>
	</table>
		
	<br>
	<div id="replyList">
		<table>
			<tr>
				<th>ID</th>
				<th>내용</th>
				<th>날짜</th>
				<th></th>
				<th></th>
			</tr>
			<c:forEach items="${list}" var="item">
				<tr>
					<td>${item.rWriter}</td>
					<td>${item.rContent}</td>
					<td>${item.rDateTime}</td>
					<td><input type="button" class="btn-edit" data-e_r_id="${item.rId }" value="수정"></td>
					<td><input type="button" class="btn-del" data-d_r_id="${item.rId }" value="삭제"></td>
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
						<a href="javascript:void(0);" class="page" id="${pagination.prevPage }">◀</a>
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
						<a href="javascript:void(0);" class="page" id="${pagination.nextPage }">▶</a>
					</li>
				</c:when>
				<c:when test="${ pagination.nextPage > pagination.lastPage}">
					<li style="display:none;">
						<a href="javascript:void(0);" class="page" id="${pagination.nextPage }">▶</a>
					</li>
				</c:when>
			</c:choose> 
		</ul>
	</div>
	<br>
	<form id="form">
		<sec:authorize access="isAuthenticated()">
			<input type="hidden" name="p_num" value="${player.p_num }">
			<input type="text" name="rContent" id="cont"> <input type="button" value="댓글달기" id="btn">
			<sec:authentication property="principal" var="principal"/>
				<input type="hidden" name="rWriter" value="${principal.uName }">
				<input type="hidden" name="uId" value="${principal.username }">
		</sec:authorize>
	</form>
</body>
<script>
$(document).ready(function() {
	let textArea = $('#story');
	textArea[0].style.height = 'auto';
	let textAreaHeight = textArea.prop('scrollHeight');
	textArea.css('height', textAreaHeight);
});

$(window).resize(function() {
	let textArea = $('#story');
	textArea[0].style.height = 'auto';
	let textAreaHeight = textArea.prop('scrollHeight');
	textArea.css('height', textAreaHeight);
});

$(document).on('click', '.page', function() {
	let id = $(this).attr('id');
	
	$.ajax({
		method: "POST",
		url: "/reply_list",
		data: { p_num:${player.p_num}, page:id },
		dataType: "html",
	})
	.done(function(data) {
		$("#replyList").html(data);
	});	
});

$(document).on('click', '#btn', function() {
	let form = $('#form')[0];
	let formData = new FormData(form);
		
	if(formData.get('rContent') != "") {
		$.ajax({
			method: "POST",
			url: "/write_reply",
			data: formData,
			dataType: "html",
			processData: false,
			contentType: false
		})
		.done(function(data) {
			$("#replyList").html(data);	
	 		$("#cont").val('');
		});	
	}
});
$(document).on('click', '.btn-edit', function() {
	let r_id = $(this).attr('data-e_r_id');
	let checkBtn = $(this);	
	let tr = checkBtn.parent().parent();
	let td = tr.children();
	
	$.ajax({
		method: "POST",
		url: "/edit_reply",
		data: {r_id: r_id},
		dateType: "html"
	})
	.done(function(data) {
		console.log(data);
		if(data == 'denied') {
			location.href = data;
		} else {
			td.eq(1).html(data);			
		}
	});
});
$(document).on('click', '#btn-edit-comp', function () {
	let r_id = $('input[name="r_id"]').val();
	let edit_content = $('input[name="edit_content"]').val();
	
	$.ajax({
		  method: "POST",
		  url: "/edit_reply_result",
		  data: { r_id: r_id, edit_content: edit_content },
		  dataType: "html"
		})
		.done(function(data) {
	 		$("#replyList").html(data);	
		});
});
$(document).on('click', '.btn-del', function () {
	let r_id = $(this).attr('data-d_r_id');
	
	$.ajax({
		  method: "POST",
		  url: "/delete_reply",
		  data: { rId: r_id },
		  dataType: "html"
		})
		.done(function(data) {
			if(data == 'denied') {
				location.href = data;
			} else {
			 	$("#replyList").html(data);
			}
		});
});
</script>
</html>