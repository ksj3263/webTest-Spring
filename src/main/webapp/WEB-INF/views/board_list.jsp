<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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
	<a href="/board_write">글쓰기</a>
	<a href="/">돌아가기</a>
	
	<p> prev : ${pagination.prevPage }</p>
	<p> next : ${pagination.nextPage }</p>
	<p> start : ${pagination.startPage }</p>
	<p> end : ${pagination.endPage }</p>
	<p> last : ${pagination.lastPage }</p>
	<p> cur : ${pagination.page }</p>
	
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
						<a href="/board_list?page=${pagination.prevPage}">◀</a>
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
								<a href="/board_list?page=${i}">${i}</a>
							</li>
						</c:when>
					</c:choose>
			</c:forEach>
			<c:choose>
				<c:when test="${ pagination.nextPage <= pagination.lastPage }">
					<li style="">
						<a href="/board_list?page=${pagination.nextPage}">▶</a>
					</li>
				</c:when>
				<c:when test="${ pagination.nextPage > pagination.lastPage}">
					<li style="display:none;">
						<a href="/board_list?page=${pagination.nextPage}">▶</a>
					</li>
				</c:when>
			</c:choose> 
		</ul>
	</div>
</body>
</html>