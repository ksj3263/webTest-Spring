<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
</head>
<body>
	<p>제목 : ${board.bTitle }</p>
	<p>내용 : ${board.bContent }</p>
	<p>날짜 : ${board.bDateTime }</p>
	<p>작성자 : ${board.bWriter }</p>
	<a href="/board_add?bId=${board.bId }">답글쓰기</a>
	<a href="/board_edit?bId=${board.bId }">수정하기</a>
	<a href="/board_delete?bId=${board.bId }">삭제하기</a>
	<a href="/board_list">돌아가기</a>
	
<br><br>
<input type="hidden" name="b_id" value="${board.bId }">
<input type="text" name="content" id="cont"> <input type="button" value="댓글달기" id="btn">

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal"/>
	<input type="hidden" name="rWriter" value="${principal.username }">
</sec:authorize>

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

<script>
$(document).on('click', '#btn', function () {
	let b_id = $('input[name="b_id"]').val();
	let content = $('input[name="content"]').val();	
	let rWriter = $('input[name="rWriter"]').val();
	console.log(b_id);
	console.log(content);
	console.log(rWriter);
	
	$.ajax({
		  method: "POST",
		  url: "/board_reply",
		  data: { b_id: b_id, content: content, rWriter: rWriter },
		  dataType: "html"
		})
		.done(function(data) {
	 		console.log("ok");
	 		$("#replyList").html(data);	
	 		$("#cont").val('');
		});
});
$(document).on('click', '.btn-edit', function() {
	let r_id = $(this).attr('data-e_r_id');
	let checkBtn = $(this);	
	let tr = checkBtn.parent().parent();
	let td = tr.children();
	console.log(r_id);
	console.log(td.eq(1).text());
	
	$.ajax({
		method: "POST",
		url: "/board_reply_edit",
		data: {r_id: r_id},
		dateType: "html"
	})
	.done(function(data) {
		console.log(data);
		td.eq(1).html(data);
	});
});
$(document).on('click', '#btn-edit-comp', function () {
	let r_id = $('input[name="r_id"]').val();
	let edit_content = $('input[name="edit_content"]').val();
	console.log(r_id);
	console.log(edit_content);
	
	$.ajax({
		  method: "POST",
		  url: "/board_reply_edit_result",
		  data: { r_id: r_id, edit_content: edit_content },
		  dataType: "html"
		})
		.done(function(data) {
	 		console.log("ok");
	 		$("#replyList").html(data);	
		});
});
$(document).on('click', '.btn-del', function () {
	let r_id = $(this).attr('data-d_r_id');
	console.log(r_id);
	console.log("del");
	
	$.ajax({
		  method: "POST",
		  url: "/board_reply_delete",
		  data: { r_id: r_id },
		  dataType: "html"
		})
		.done(function(data) {
			console.log("ok");
		 	$("#replyList").html(data);
		});
});
</script>
</body>
</html>