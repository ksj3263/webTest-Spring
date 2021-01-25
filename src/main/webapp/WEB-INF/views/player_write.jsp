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
        var com_year = dt.getFullYear();
        
        for(var y = 2014 ; y <= com_year ; y++){
            $("#year").append("<option value='" + y + "'>"+ y +"년</option>");
        }
        
        for(var i = 1; i <= 12; i++){
            $("#month").append("<option value='" + i + "'>"+ i +"월</option>");
        }
        
        for(let d = 1 ; d <= 31 ; d++) {
        	$("#day").append("<option value='" + d + "'>" + d + "일</option>");
        }
    }
</script>
<body>
<form action="player_write_result" method="post">
	<p> 선수명 : <input type="text" name="p_name"></p>
	<p> 이미지 : </p>
	<p> 포지션 :
		<select name="position" id="position">
			<option value="st">스트라이커</option>
			<option value="as">어시스터</option>
			<option value="at">어태커</option>
			<option value="df">디펜더</option>
			<option value="le">리더</option>
			<option value="gk">골키퍼</option>
		</select>
	</p>
	<p> 속성 :
		<select name="attribute" id="attribute">
			<option value="am">열혈</option>
			<option value="wh">질풍</option>
			<option value="th">천둥</option>
			<option value="li">섬광</option>
			<option value="da">암흑</option>
		</select>
	</p>
	<p> 등급 :
		<select name="tier" id="tier">
			<option value="l">L</option>
			<option value="sr">SR</option>
			<option value="srb">SRB</option>
			<option value="rb">RB</option>
			<option value="r">R</option>
			<option value="n">N</option>
		</select>
	</p>
	<p> 파워 : <input type="text" name="p_power"></p>
	<p> 테크닉 : <input type="text" name="p_technique"></p>
	<p> 피지컬 : <input type="text" name="p_physical"></p>
	<p> 스피드 : <input type="text" name="p_speed"></p>
	
	<p> 액티브 : <input type="text" name="p_active"></p>
	<p> 패시브1 : <input type="text" name="p_passive1"></p>
	<p> 패시브2 : <input type="text" name="p_passive2"></p>
	<p> 패시브3 : <input type="text" name="p_passive3"></p>
	
	<p> 스톤1 :
		<select name="stone1" id="stone1">
			<option value="am">열혈</option>
			<option value="wh">질풍</option>
			<option value="th">천둥</option>
			<option value="li">섬광</option>
			<option value="da">암흑</option>
		</select>
	</p>
	<p> 스톤2 :
		<select name="stone2" id="stone2">
			<option value="am">열혈</option>
			<option value="wh">질풍</option>
			<option value="th">천둥</option>
			<option value="li">섬광</option>
			<option value="da">암흑</option>
		</select>
	</p>
	<p> 스톤3 :
		<select name="stone3" id="stone3">
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
		<select name="day" id="day">
		</select>
	</p>
	
	<p> 협동기 : <input type="text" name="p_coop"></p>
	<p> 협동 선수1 : <input type="text" name="p_coop1"></p>
	<p> 협동 선수2 : <input type="text" name="p_coop2"></p>
	<p> 협동 선수3 : <input type="text" name="p_coop3"></p>
	<input type="submit" value="완료"> 
</form>
<a href="/player_list">돌아가기</a>
<input type="button" value="테스트용" id="btn">
</body>
<script>
$(document).on('click', '#btn', function () {
	let year = document.getElementById("year");
	let vYear = year.options[year.selectedIndex].value;
	let month = document.getElementById("month");
	let vMonth = month.options[month.selectedIndex].value;
	let day = document.getElementById("day");
	let vDay = day.options[day.selectedIndex].value;
	console.log(vYear);
	console.log(vMonth);
	console.log(vDay);
	
	let position = document.getElementById("position");
	let vPosition = position.options[position.selectedIndex].text;
	let attribute = document.getElementById("attribute");
	let vAttribute = attribute.options[attribute.selectedIndex].text;
	let tier = document.getElementById("tier");
	let vTier = tier.options[tier.selectedIndex].text;
	let stone1 = document.getElementById("stone1");
	let vStone1 = stone1.options[stone1.selectedIndex].text;
	let stone2 = document.getElementById("stone3");
	let vStone2 = stone2.options[stone2.selectedIndex].text;
	let stone3 = document.getElementById("stone3");
	let vStone3 = stone3.options[stone3.selectedIndex].text;
	
	console.log(vPosition);
	console.log(vAttribute);
	console.log(vTier);
	console.log(vStone1);
	console.log(vStone2);
	console.log(vStone3);
});

$('form').on('submit', function (event) {	
	let year = document.getElementById("year");
	let vYear = year.options[year.selectedIndex].value;
	let month = document.getElementById("month");
	let vMonth = month.options[month.selectedIndex].value;
	let day = document.getElementById("day");
	let vDay = day.options[day.selectedIndex].value;
	let position = document.getElementById("position");
	let vPosition = position.options[position.selectedIndex].text;
	let attribute = document.getElementById("attribute");
	let vAttribute = attribute.options[attribute.selectedIndex].text;
	let tier = document.getElementById("tier");
	let vTier = tier.options[tier.selectedIndex].text;
	let stone1 = document.getElementById("stone1");
	let vStone1 = stone1.options[stone1.selectedIndex].text;
	let stone2 = document.getElementById("stone3");
	let vStone2 = stone2.options[stone2.selectedIndex].text;
	let stone3 = document.getElementById("stone3");
	let vStone3 = stone3.options[stone3.selectedIndex].text;
	
	$.ajax({
		  method: "POST",
		  url: "/player_write_result",
		  data: { vYear: vYear, vMonth: vMonth, vDay: vDay, vPosition: vPosition, vAttribute: vAttribute, vTier: vTier, vStone1: vStone1, vStone2: vStone2, vStone3: vStone3 },
		  dataType: "text"
		}).success(function(data) {
			location.href = "/player_list";
		});

	event.preventDefault();
});
</script>
</html>
