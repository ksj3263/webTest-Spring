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
<body>	
	<p> 스킨명 : ${skin.s_name }</p>
	<p> 스킨 이미지 <br> <img src="${skin.s_full }" width=236px height=338px></p>
	<p> 종류 : ${skin.s_property } </p>
	<p> 등급 : ${skin.s_tier } </p>
	
	<p> 업데이트 날짜 : ${skin.s_date } </p>
	<p> 일러스트레이터 : ${skin.s_ill }</p>
	<p> CV : ${skin.s_cv }</p>
	
	<a href="/skin_edit?s_num=${skin.s_num }">수정하기</a>
	<a href="/skin_list">돌아가기</a>
	
	<br>
	<p> 관련 선수 </p>
	<table border=1>
		<tr>
			<td>이름</td>
			<td>이미지</td>
			<td>포지션</td>
			<td>속성</td>
			<td>등급</td>
		</tr>
		<tr>
			<td><a href="/player_detail?p_num=${player.p_num}">${player.p_name }</a></td>
			<td><img src="${player.p_thumb }" width=50px height=50px> </td>
			<td>${player.p_position }</td>
			<td>${player.p_attribute }</td>
			<td>${player.p_tier}</td>
		</tr>
	</table>
	
	<br>
	<form id="form">
		<sec:authorize access="isAuthenticated()">
			<input type="hidden" name="s_num" value="${skin.s_num }">
			<input type="text" name="rContent" id="cont"> <input type="button" value="댓글달기" id="btn">
			<sec:authentication property="principal" var="principal"/>
				<input type="hidden" name="rWriter" value="${principal.uName }">
				<input type="hidden" name="uId" value="${principal.username }">
		</sec:authorize>
	</form>
		
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
	</div>
</body>
<script>
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