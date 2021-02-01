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
$(document).ready(function() {
	setDateBox();
    
    $('#position option').each(function() {
    	if($(this).val() == "${player.p_position}") {
    		$(this).attr("selected", "selected");
        }
	});
      
    $('#attribute option').each(function() {
		if($(this).val() == "${player.p_attribute}") {
			$(this).attr("selected", "selected");
		}
	});
      
	$('#tier option').each(function() {
		if($(this).val() == "${player.p_tier}") {
			$(this).attr("selected", "selected");
		}
	});
      
	$('#stone1 option').each(function() {
		if($(this).val() == "${player.p_stone1}") {
			$(this).attr("selected", "selected");
		}
	});
      
	$('#stone2 option').each(function() {
		if($(this).val() == "${player.p_stone2}") {
			$(this).attr("selected", "selected");
		}
	});
      
	$('#stone3 option').each(function() {
		if($(this).val() == "${player.p_stone3}") {
			$(this).attr("selected", "selected");
		}
	});
      
    let date = "${player.p_date}".split("-");
    let year = date[0];
    let month = parseInt(date[1], 10);
    let day = parseInt(date[2], 10);
      
	$('#year option').each(function() {
		if($(this).val() == year) {
			$(this).attr("selected", "selected");
		}
	});
      
	$('#month option').each(function() {
		if($(this).val() == month) {
			$(this).attr("selected", "selected");
		}
	});
      
	$('#day option').each(function() {
		if($(this).val() == day) {
			$(this).attr("selected", "selected");
		}
	});
      
      console.log("ready");
});    

function setDateBox() {
	var dt = new Date();
	var com_year = dt.getFullYear();

	for(var y = 2014 ; y <= com_year ; y++) {
    	$("#year").append("<option value='" + y + "'>"+ y +"년</option>");
	}

	for(var i = 1; i <= 12; i++) {
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
	<input type="hidden" name="p_num" value="${player.p_num }">
	<p> 선수명 : <input type="text" name="p_name" value="${player.p_name }"></p>
	<p> 이미지 : <input type="file" name="p_image" onchange="setThumbnail(event);"></p>	
	<div id="image_container">
		<img src="${player.p_full }">
	</div>
	<script>
	function setThumbnail(event) {
		$('#image_container').empty();
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
			<option value="암흑">암흑</option>
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
	<p> 파워 : <input type="text" name="p_power" value="${player.p_power}"></p>
	<p> 테크닉 : <input type="text" name="p_technique" value="${player.p_technique}"></p>
	<p> 피지컬 : <input type="text" name="p_physical" value="${player.p_physical }"></p>
	<p> 스피드 : <input type="text" name="p_speed" value="${player.p_speed }"></p>
	
	<p> 에이스 : <input type="text" name="p_name_ace" value="${player.p_name_ace }"> <input type="text" name="p_ace" value="${player.p_ace }"></p>
	<p> 액티브 : <input type="text" name="p_name_a" value="${player.p_name_a }"> <input type="text" name="p_active" value="${player.p_active }"></p>
	<p> 패시브1 : <input type="text" name="p_name_p1" value="${player.p_name_p1 }"> <input type="text" name="p_passive1" value="${player.p_passive1 }"></p>
	<p> 패시브2 : <input type="text" name="p_name_p2" value="${player.p_name_p2 }"> <input type="text" name="p_passive2" value="${player.p_passive2 }"></p>
	<p> 패시브3 : <input type="text" name="p_name_p3" value="${player.p_name_p3 }"> <input type="text" name="p_passive3" value="${player.p_passive3 }"></p>
	
	<p> 스톤1 :
		<select name="p_stone1" id="stone1">
			<option value="열혈">열혈</option>
			<option value="질풍">질풍</option>
			<option value="천둥">천둥</option>
			<option value="섬광">섬광</option>
			<option value="암흑">암흑</option>
		</select>
	</p>
	<p> 스톤2 :
		<select name="p_stone2" id="stone2">
			<option value="열혈">열혈</option>
			<option value="질풍">질풍</option>
			<option value="천둥">천둥</option>
			<option value="섬광">섬광</option>
			<option value="암흑">암흑</option>
		</select>
	</p>
	<p> 스톤3 :
		<select name="p_stone3" id="stone3">
			<option value="열혈">열혈</option>
			<option value="질풍">질풍</option>
			<option value="천둥">천둥</option>
			<option value="섬광">섬광</option>
			<option value="암흑">암흑</option>
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
	
	<p> 협동기/결전기 : <input type="text" name="p_coop" value="${player.p_coop }"></p>
	<p> 협동 선수1 : <input type="text" name="p_coop1" value="${player.p_coop1 }"></p>
	<p> 협동 선수2 : <input type="text" name="p_coop2" value="${player.p_coop2 }"></p>
	<p> 협동 선수3 : <input type="text" name="p_coop3" value="${player.p_coop3 }"></p>
	
	<p> 스토리 : </p>
	<textarea id="story" name="p_story" style="resize:none;" rows=20 cols=200>${player.p_story }
	</textarea> 
	<p> 일러스트레이터 : <input type="text" name="p_ill" value="${player.p_ill }"></p>
	<p> CV : <input type="text" name="p_cv" value="${player.p_cv }"></p>
	<input type="button" value="완료" onclick="transfer();">
</form>
<a href="/player_detail?p_num=${player.p_num }">돌아가기</a>
</body>
<script>
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
		url: "/player_edit_result",
		data: formData,
		contentType: false,
		processData: false,
		error:function(request, status, error) {
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	}).success(function(data) {
		console.log("ok");
		location.href = "/player_detail?p_num=" + ${player.p_num};
	});
}
</script>
</html>
