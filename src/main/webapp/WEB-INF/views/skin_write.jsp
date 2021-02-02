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
	<p> 스킨명 : <input type="text" name="s_name"></p>
	<p> 선수명 : <input type="text" name="p_name"> <button type="button" onclick="dup();">확인</button></p>
	<p> 이미지 : <input type="file" name="s_image" onchange="setThumbnail(event);"></p>	
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
	<p> 종류 :
		<select name="s_property" id="property">
			<option value="라이브">라이브</option>
			<option value="유니크">유니크</option>
			<option value="일반">일반</option>
			<option value="이벤트">이벤트</option>			
		</select>
	</p>
	<p> 등급 :
		<select name="s_tier" id="tier">
			<option value="L">L</option>
			<option value="SR">SR</option>
			<option value="SRB">SRB</option>
			<option value="RB">RB</option>
			<option value="R">R</option>
			<option value="N">N</option>			
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
	
	<p> 일러스트레이터 : <input type="text" name="s_ill"></p>
	<p> CV : <input type="text" name="s_cv"></p>
	<input type="button" value="완료" onclick="transfer();" id="com" disabled> 
</form>
<a href="/skin_list">돌아가기</a>
</body>
<script>
function dup() {
	let name = $('input[name="p_name"]').val();
	
	$.ajax({
		type: "POST",
		url: "/player_duplicate",
		data : { name : name }
	}).success(function (data) {
		if(data == "ok") {
			$('#com').attr('disabled', false);
		}			
		else {
			$('#com').attr('disabled', true);
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
	
	formData.append('s_date', date);
	
	$.ajax({
		type:"POST",
		url: "/skin_write_result",
		data: formData,
		contentType: false,
		processData: false
	}).success(function(data) {
		location.href = "/skin_list";
	});
};
</script>
</html>
