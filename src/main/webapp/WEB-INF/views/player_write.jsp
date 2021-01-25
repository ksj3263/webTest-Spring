<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>
    $(document).ready(function(){
        setDateBox();
    });    
 
    function setDateBox(){
        var dt = new Date();
        var year = "";
        var com_year = dt.getFullYear();
        for(var y = 2014 ; y <= com_year ; y++){
            $("#year").append("<option value='" + y + "'>"+ y +"년</option>");
        }
        
        var month;
        for(var i = 1; i <= 12; i++){
            $("#month").append("<option value='" + i + "'>"+ i +"월</option>");
        }
        
        let date;
        for(let d = 1 ; d <= 31 ; d++) {
        	$("#date").append("<option value='" + d + "'>" + d + "일</option>");
        }
    }
</script>
<body>
<form action="file_upload" enctype="multipart/form-data">
	<p> 선수명 : <input type="text"></p>
	<p> 이미지 : <input id="filename" name="filename" type="file"></p>
	<p> 포지션 :
		<select name="position">
			<option></option>
			<option value="st">스트라이커</option>
			<option value="as">어시스터</option>
			<option value="at">어태커</option>
			<option value="df">디펜더</option>
			<option value="le">리더</option>
			<option value="gk">골키퍼</option>
		</select>
	</p>
	<p> 속성 :
		<select name="attribute">
			<option value="am">열혈</option>
			<option value="wh">질풍</option>
			<option value="th">천둥</option>
			<option value="li">섬광</option>
			<option value="da">암흑</option>
		</select>
	</p>
	<p> 등급 :
		<select name="tier">
			<option value="l">L</option>
			<option value="sr">SR</option>
			<option value="srb">SRB</option>
			<option value="rb">RB</option>
			<option value="r">R</option>
			<option value="n">N</option>
		</select>
	</p>
	<p> 파워 : <input type="text"></p>
	<p> 테크닉 : <input type="text"></p>
	<p> 피지컬 : <input type="text"></p>
	<p> 스피드 : <input type="text"></p>
	
	<p> 액티브 : <input type="text"></p>
	<p> 패시브1 : <input type="text"></p>
	<p> 패시브2 : <input type="text"></p>
	<p> 패시브3 : <input type="text"></p>
	
	<p> 스톤1 :
		<select name="stone1">
			<option value="am">열혈</option>
			<option value="wh">질풍</option>
			<option value="th">천둥</option>
			<option value="li">섬광</option>
			<option value="da">암흑</option>
		</select>
	</p>
	<p> 스톤2 :
		<select name="stone2">
			<option value="am">열혈</option>
			<option value="wh">질풍</option>
			<option value="th">천둥</option>
			<option value="li">섬광</option>
			<option value="da">암흑</option>
		</select>
	</p>
	<p> 스톤3 :
		<select name="stone3">
			<option value="am">열혈</option>
			<option value="wh">질풍</option>
			<option value="th">천둥</option>
			<option value="li">섬광</option>
			<option value="da">암흑</option>
		</select>
	</p>
	
	<p> 업데이트 날짜 :
		<select name="year" id="year">
		</select>
		-
		<select name="month" id="month">
		</select>
		-
		<select name="date" id="date">
		</select>
	</p>
	
	
	<p> 협동기 : <input type="text"></p>
	<p> 협동 선수1 : </p>
	<p> 협동 선수2 : </p>
	<p> 협동 선수3 : </p>
	<input type="submit" value="완료"> 
</form>
<a href="/player_list">돌아가기</a>
<input type="button" value="테스트용" id="btn">
</body>
<script>
$(document).on('click', '#btn', function () {
	let year = document.getElementById("year");
	let month = document.getElementById("month");
	var date = document.getElementById("date");
	alert('선택된 옵션 value 값=' + year.options[year.selectedIndex].value);
	alert('선택된 옵션 value 값=' + month.options[month.selectedIndex].value);
	alert('선택된 옵션 value 값=' + date.options[date.selectedIndex].value);
});
</script>
</html>
