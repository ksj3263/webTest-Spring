<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</head>
<body>
	<p>제목 : ${board.bTitle }</p>
	<p>내용 : ${board.bContent }</p>
	<p>날짜 : ${board.bDateTime }</p>
	<p>작성자 : ${board.bWriter }</p>
	<sec:authorize access="isAuthenticated()">		
		<a href="/board_add?bId=${board.bId }">답글쓰기</a>
		<a href="/board_edit?bId=${board.bId }">수정하기</a>
		<a href="/board_delete?bId=${board.bId }">삭제하기</a>
	</sec:authorize>
	
	<a href="/board_list">돌아가기</a>
	
<br><br>
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
<form id="form">
	<sec:authorize access="isAuthenticated()">
		<input type="hidden" name="bId" value="${board.bId }">
		<input type="text" name="rContent" id="cont"> <input type="button" value="댓글달기" id="btn">
		<sec:authentication property="principal" var="principal"/>
			<input type="hidden" name="rWriter" value="${principal.uName }">
			<input type="hidden" name="uId" value="${principal.username }">
	</sec:authorize>
</form>
</body>
<script>
$(document).on('click', '.page', function() {
	let id = $(this).attr('id');
	let url = "/board_detail?bId=" + ${board.bId} + "&page=" + id;
	
	//location.href = url;
	
	$.ajax({
		method: "POST",
		url: "/write_reply",
		data: { bId:${board.bId}, page:id },
		dataType: "html",
	})
	.done(function(data) {
		console.log("ok");
		$("#replyList").html(data);
	});	
});
$(document).on('click', '#btn', function () {
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
			console.log("ok");
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
	console.log(r_id);
	console.log(td.eq(1).text());
	
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
	console.log(r_id);
	console.log(edit_content);
	
	$.ajax({
		  method: "POST",
		  url: "/edit_reply_result",
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
		  url: "/delete_reply",
		  data: { rId: r_id },
		  dataType: "html"
		})
		.done(function(data) {
			console.log(data);
			if(data == 'denied') {
				location.href = data;
			} else {
			 	$("#replyList").html(data);
			}
		});
});
</script>
</html>