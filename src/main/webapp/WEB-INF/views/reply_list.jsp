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
		<tr id="tr">
			<td>${item.rWriter}</td>
			<td>${item.rContent}</td>
			<td>${item.rDateTime}</td>
			<td><input type="button" class="btn-edit" data-e_r_id="${item.rId }" value="수정"></td>
			<td><input type="button" class="btn-del" data-d_r_id="${item.rId }" value="삭제"></td>
		<tr>
	</c:forEach>
</table>