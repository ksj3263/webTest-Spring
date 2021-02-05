<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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