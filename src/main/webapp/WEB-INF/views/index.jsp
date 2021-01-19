<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>Home Page</h1>
		<hr>
		<div>
			<sec:authorize access="isAnonymous()">
				<a href="/login">�α���</a>
				<a href="/beforeSignup">ȸ������</a>
			</sec:authorize>   
			<sec:authorize access="isAuthenticated()">
			<a href="/logout">�α׾ƿ�</a>
			<sec:authentication property="principal" var="principal"/>
				<h2>${principal }</h2>
			</sec:authorize>
            
		</div>
		<div>
			<sec:authorize access="isAuthenticated()">        
				<a href="/user/info">�� ����</a>
				<a href="/admin">������</a>
			</sec:authorize>
		</div>
		<div>
			<a href="/board_list">�����Խ���</a>
			<a href="/skin_list">��Ų ���</a>
			<a href="/player_list">���� DB</a>
		</div>
</body>
</html>