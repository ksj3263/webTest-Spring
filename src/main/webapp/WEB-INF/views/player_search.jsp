<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<table border=1>
	<tr>
		<td>이름</td>
		<td>이미지</td>
		<td>포지션</td>
		<td>속성</td>
		<td>등급</td>
	</tr>
	<c:forEach var="list" items="${list }">
		<tr>
			<td><a href="/player_detail?p_num=${list.p_num}">${list.p_name }</a></td>
			<td><img src="${list.p_thumb }" width=50px height=50px> </td>
			<td>${list.p_position }</td>
			<td>${list.p_attribute }</td>
			<td>${list.p_tier}</td>
		</tr>
	</c:forEach>
</table>