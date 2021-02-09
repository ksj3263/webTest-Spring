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
	div {
		width:100%;
	}
	div.left {
		width:30%;
		float:left;
	}
	div.right {
		width:70%;
		float:right;
	}
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
<div>
	<div class='left'>
		<iframe src="player_list.jsp">
		</iframe>
	</div>
	
	<div class="right">
		<div id="forward">
			<span id="drop1" class="drop">
				dropzone
			</span>
			
			<span id="drop2" class="drop">
				dropzone
			</span>
			
			<span id="drop3" class="drop">
				dropzone
			</span>
		</div>
		<div id="mid">
			<span id="drop1" class="drop">
				dropzone
			</span>
			
			<span id="drop2" class="drop">
				dropzone
			</span>
			
			<span id="drop3" class="drop">
				dropzone
			</span>
		</div>
		<div id="defense">
			<span id="drop1" class="drop">
				dropzone
			</span>
			
			<span id="drop2" class="drop">
				dropzone
			</span>
			
			<span id="drop3" class="drop">
				dropzone
			</span>
		</div>
	</div>
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

$(document).on('click', 'img', function () {
	console.log("click");
	let target = $(this);
	console.log(target);
	let data = target.context;	
	console.log(data);
	console.log(data.id);
});
</script>
</html>