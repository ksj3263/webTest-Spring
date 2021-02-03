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
        	if(i < 10)
        		$("#month").append("<option value='" + i + "'>0"+ i +"월</option>");
        	else
        		$("#month").append("<option value='" + i + "'>"+ i +"월</option>");
        }
        
        for(let d = 1 ; d <= 31 ; d++) {
        	if(d < 10)
        		$("#day").append("<option value='" + d + "'>0" + d + "일</option>");
        	else
        		$("#day").append("<option value='" + d + "'>" + d + "일</option>");
        }
    }
</script>
<body>
<form id="form" method="post" enctype="multipart/form-data">
	<p> 선수명 : <input type="text" name="p_name"></p>
	<p> 이미지 : <input type="file" name="p_image" onchange="setThumbnail(event);"></p>	
	<div id="image_container">
	</div>
	<script>
	function setThumbnail(event) {
		var reader = new FileReader(); 
		reader.onload = function(event) { 
			var img = document.createElement("img");
			img.setAttribute("src", event.target.result);
			document.querySelector("div#image_container").appendChild(img); 
			}; 
		reader.readAsDataURL(event.target.files[0]);
	}
	</script>
	
	<p> 포지션 :
		<select name="p_position" id="position">
			<option value="스트라이커">스트라이커</option>
			<option value="어시스터">어시스터</option>
			<option value="어태커">어태커</option>
			<option value="디펜더">디펜더</option>
			<option value="리더">리더</option>
			<option value="골키퍼">골키퍼</option>
		</select>
	</p>
	<p> 속성 :
		<select name="p_attribute" id="attribute">
			<option value="열혈">열혈</option>
			<option value="질풍">질풍</option>
			<option value="천둥">천둥</option>
			<option value="섬광">섬광</option>
			<option value="어둠">어둠</option>
		</select>
	</p>
	<p> 등급 :
		<select name="p_tier" id="tier">
			<option value="L">L</option>
			<option value="SR">SR</option>
			<option value="SRB">SRB</option>
			<option value="RB">RB</option>
			<option value="R">R</option>
			<option value="N">N</option>			
		</select>
	</p>
	<p> 파워 : <input type="text" name="p_power"></p>
	<p> 테크닉 : <input type="text" name="p_technique"></p>
	<p> 피지컬 : <input type="text" name="p_physical"></p>
	<p> 스피드 : <input type="text" name="p_speed"></p>
	
	<p> 에이스 : <input type="text" name="p_name_ace"> <input type="text" name="p_ace"></p>
	<p> 액티브 : <input type="text" name="p_name_a"> <input type="text" name="p_active"></p>
	<p> 패시브1 : <input type="text" name="p_name_p1"> <input type="text" name="p_passive1"></p>
	<p> 패시브2 : <input type="text" name="p_name_p2"> <input type="text" name="p_passive2"></p>
	<p> 패시브3 : <input type="text" name="p_name_p3"> <input type="text" name="p_passive3"></p>
	
	<p> 스톤1 :
		<select name="p_stone1" id="stone1">
			<option value="열혈">열혈</option>
			<option value="질풍">질풍</option>
			<option value="천둥">천둥</option>
			<option value="섬광">섬광</option>
			<option value="어둠">어둠</option>
		</select>
	</p>
	<p> 스톤2 :
		<select name="p_stone2" id="stone2">
			<option value="열혈">열혈</option>
			<option value="질풍">질풍</option>
			<option value="천둥">천둥</option>
			<option value="섬광">섬광</option>
			<option value="어둠">어둠</option>
		</select>
	</p>
	<p> 스톤3 :
		<select name="p_stone3" id="stone3">
			<option value="열혈">열혈</option>
			<option value="질풍">질풍</option>
			<option value="천둥">천둥</option>
			<option value="섬광">섬광</option>
			<option value="어둠">어둠</option>
		</select>
	</p>	
	
	<p> 협동기/결전기 : <input type="text" name="p_coop"><br>
	<input type="text" name="p_coop_count">회 사용 가능/
	<input type="text" name="p_coop_cool">분 후 재사용 가능/
	경기 시작 <input type="text" name="p_coop_pre">분 후 사용 가능</p>
	<p> 협동 선수1 : <input type="text" name="p_coop1"> <button type="button" onclick="dup1();">확인</button></p>
	<p> 협동 선수2 : <input type="text" name="p_coop2"> <button type="button" onclick="dup2();">확인</button></p>
	<p> 협동 선수3 : <input type="text" name="p_coop3"> <button type="button" onclick="dup3();">확인</button></p>
	
	<p> 연관 선수1 : <input type="text" name="p_r1"> </p>
	<p> 연관 선수2 : <input type="text" name="p_r2"> </p>
	<p> 연관 선수3 : <input type="text" name="p_r3"> </p>
	
	<p> 스토리 :	</p>
	<textarea id="story" name="p_story" style="resize:none; width:90%;" rows=20></textarea>
	<p> 일러스트레이터 : <input type="text" name="p_ill"></p>
	<p> CV : <input type="text" name="p_cv"></p>
	
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
	
	<input type="button" value="완료" onclick="transfer();"> 
</form>
<a href="/player_list">돌아가기</a>
</body>
<script>
function dup1() {
	let name = $('input[name="p_coop1"]').val();
	
	$.ajax({
		type: "POST",
		url: "/player_duplicate",
		data : { name : name }
	}).success(function (data) {
		if(data == "ok") {
			console.log("yes");
		}			
		else {
			console.log("no");
		}
	});
};
function dup2() {
	let name = $('input[name="p_coop2"]').val();
	
	$.ajax({
		type: "POST",
		url: "/player_duplicate",
		data : { name : name }
	}).success(function (data) {
		if(data == "ok") {
			console.log("yes");
		}			
		else {
			console.log("no");
		}
	});
};
function dup3() {
	let name = $('input[name="p_coop3"]').val();
	
	$.ajax({
		type: "POST",
		url: "/player_duplicate",
		data : { name : name }
	}).success(function (data) {
		if(data == "ok") {
			console.log("yes");
		}			
		else {
			console.log("no");
		}
	});
};
function transfer() {	
	let form = $('#form')[0];
	let formData = new FormData(form);
	
	formData.delete('year');
	formData.delete('month');
	formData.delete('day');
	
	let year = document.getElementById("year");
	let vYear = year.options[year.selectedIndex].value;
	let month = document.getElementById("month");
	let vMonth = month.options[month.selectedIndex].value;
	let day = document.getElementById("day");
	let vDay = day.options[day.selectedIndex].value;
	let date = vYear;				
	if(vMonth < 10)
		date += '0';
	date += vMonth;
	if(vDay < 10)
		date += '0';
	date += vDay;	
	
	formData.append('p_date', date);
	
	$.ajax({
		type:"POST",
		url: "/player_write_result",
		data: formData,
		contentType: false,
		processData: false
	}).success(function(data) {
		location.href = "/player_list";
	});
};
</script>
</html>
