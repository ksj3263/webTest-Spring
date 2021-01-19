<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<table>
	<tr>
		<th>ID</th>
		<th>내용</th>
		<th>날짜</th>
		<th>수정</th>
		<th>삭제</th>
	</tr>
	<c:forEach items="${list}" var="item">
		<tr id="tr">
			<td>${item.rWriter}</td>
			<td>${item.rContent}</td>
			<td>${item.rDateTime}</td>
			<td><input type="button" class="btn-edit" data-e_r_idx="${item.rId }"></td>
			<td><input type="button" class="btn-del" data-d_r_idx="${item.rId }"></td>
		<tr>
	</c:forEach>
</table>