<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
				<a href="/login">로그인</a>
				<a href="/beforeSignup">회원가입</a>
			</sec:authorize>   
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal" var="principal"/>
					<p>${principal.uName }님</p>
				<a href="/logout">로그아웃</a>
			</sec:authorize>            
		</div>
		<div>
			<sec:authorize access="isAuthenticated()">        
				<a href="/user/info">내 정보</a>
				<a href="/admin">관리자</a>
			</sec:authorize>
		</div>
		<div>
			<a href="/board_list">자유게시판</a>
			<a href="/player_list">선수 DB</a>
			<a href="/skin_list">스킨 목록</a>
			<a href="/stone_list">스톤 DB</a>
			<a href="/deck">덱 구성</a>
			<a href="/update">패치 노트</a>
		</div>
</body>
</html>
