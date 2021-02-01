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
	<table>
		<tr>
			<td>rownum</td>
			<td>title</td>
			<td>writer</td>
			<td>datetime</td>
		</tr>
		<c:forEach var="list" items="${list }">
			<tr>
				<td><a href="/board_detail?bId=${list.bId }">${list.rowNum }</a></td>
				<td>${list.bTitle }</td>
				<td>${list.bWriter }</td>
				<td>${list.bDateTime }</td>
			</tr>
		</c:forEach>
	</table>
	
	<sec:authorize access="isAuthenticated()">
		<a href="/board_write">글쓰기</a>
	</sec:authorize>
	
	<a href="/">돌아가기</a>
	
	<br>
	<form id="form">
		<select name="searchType" id="searchType">
			<option value="1">글 제목&내용</option>
			<option value="2">글 제목</option>
			<option value="3">글 내용</option>
			<option value="4">글 작성자</option>
			<option value="5">댓글 내용</option>
			<option value="6">댓글 작성자</option>
		</select>
		<input type="text" name="content" id="content"> 
	</form>
	<button onclick="transfer()">검색</button>

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
</body>
<script>
$(document).ready(function() {
	let content = "${search.content}";
	
	$('#searchType option').each(function() {
    	if($(this).val() == "${search.searchType}") {
    		$(this).attr("selected", "selected");
        }
	});			
	
	$("#content").val(content);
	
	$(document).on('click', '.page', function() {		
		let params=$("#form").serialize();
		let id = $(this).attr('id');
		let url = "/board_list?page=" + id + "&" + params;
		
		location.href = url;
	});
});

function transfer() {	
	let params = $('#form').serialize();
	
	location.href = "/board_list?" + params;
};
</script>
</html>