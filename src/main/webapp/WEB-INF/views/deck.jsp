<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<style>
	div {
		width:100%;
	}
	div.left {
		width:30%;
		float:left;
	}
	div.right {
		width:70%;
		float:right;
	}
	table {
		border-collapse:collapse;
		margin:40px auto;
	}
	table tr th {
		font-weight:700;
	}
	table tr td, table tr th {
		border:1px solid #818181;
		width:200px;
		text-align:center;
	}
	a {
		text-decoration:none;
		color:#000;
		font-weight:700;
	}
	ul {
		width:600px;
		height:50px;
		margin:10px auto;
	}
	li {
		list-style:none;
		width:50px;
		line-height:50px;
		border:1px solid #ededed;
		float:left;
		text-align:center;
		margin:0 5px;
		border-radius:5px;
	}
</style>
<body>
<div>
	<div class='left' id="playerList">
		<form id="form">
			<p> 속성 : 열혈<input type="checkbox" id="열혈" name="attributes" value="열혈">
			질풍<input type="checkbox" id="질풍" name="attributes" value="질풍">
			천둥<input type="checkbox" id="천둥" name="attributes" value="천둥">
			섬광<input type="checkbox" id="섬광" name="attributes" value="섬광">
			어둠<input type="checkbox" id="어둠" name="attributes" value="어둠"> </p>
						
			<p> 포지션 : 스트라이커<input type="checkbox" id="스트라이커" name="positions" value="스트라이커">
			어시스터<input type="checkbox" id="어시스터" name="positions" value="어시스터">
			어태커<input type="checkbox" id="어태커" name="positions" value="어태커">
			디펜더<input type="checkbox" id="디펜더" name="positions" value="디펜더">
			리더<input type="checkbox" id="리더" name="positions" value="리더">
			골키퍼<input type="checkbox" id="골키퍼" name="positions" value="골키퍼"> </p>
			
			<p> 등급 : L<input type="checkbox" id="L" name="tiers" value="L">
			SR<input type="checkbox" id="SR" name="tiers" value="SR">
			SRB<input type="checkbox" id="SRB" name="tiers" value="SRB">
			R<input type="checkbox" id="R" name="tiers" value="R">
			RB<input type="checkbox" id="RB" name="tiers" value="RB">
			N<input type="checkbox" id="N" name="tiers" value="N"> </p>	
			
			<input type="text" name="content" id="content"> <input type="button" value="검색" id="btn-search"> 
		</form>
		<br>
		<a href="/"><input type="button" value="돌아가기"></a>
		<button id="btn-all">전체선택</button> <button id="btn-not-all">선택해제</button>		
		
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
					<td><img src="${list.p_thumb }" width=50px height=50px id="${list.p_num }" class="drag"> </td>
					<td>${list.p_position }</td>
					<td>${list.p_attribute }</td>
					<td>${list.p_tier}</td>
				</tr>
			</c:forEach>
		</table>
		
		<ul>
			 <c:choose>
				<c:when test="${ pagination.prevPage < 5 }">
					<li style="display:none;">
						<span>◀</span>
					</li>
				</c:when>
				<c:when test="${ pagination.prevPage >= 5}">
					<li>
						<a href="javascript:void(0);" class="page" id="${pagination.prevPage}">◀</a>
					</li>
				</c:when>
			</c:choose> 
			<c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}" step="1">				
					<c:choose>
						<c:when test="${ pagination.page eq i }">							
							<li style="background-color:#ededed;">
								<span>${i}</span>
							</li>
						</c:when>
						<c:when test="${ pagination.page ne i }">
							<li>
								<a href="javascript:void(0);" class="page" id="${i }">${i}</a>
							</li>
						</c:when>
					</c:choose>
			</c:forEach>
			<c:choose>
				<c:when test="${ pagination.nextPage <= pagination.lastPage }">
					<li style="">
						<a href="javascript:void(0);" class="page" id="${pagination.nextPage}">▶</a>
					</li>
				</c:when>
				<c:when test="${ pagination.nextPage > pagination.lastPage}">
					<li style="display:none;">
						<a href="javascript:void(0);" class="page" id="${pagination.nextPage}">▶</a>
					</li>
				</c:when>
			</c:choose> 
		</ul>
	</div>
	
	<div class="right">
		<table>		
			<tr id="forward">
				<td id="LW">
					<h4>LW</h4>
					<img src="resources/img/bean.jpg" width=50px height=50px id="LW" class="drop">
				</td>				
				<td id="SS">
					<h4>SS</h4>
					<img src="resources/img/bean.jpg" width=50px height=50px id="SS" class="drop">
				</td>
				<td id="SP">
					<h4>SP</h4>
					<img src="resources/img/bean.jpg" width=50px height=50px id="SP1" class="drop">
				</td>				
				<td id="RW">
					<h4>RW</h4>
					<img src="resources/img/bean.jpg" width=50px height=50px id="RW" class="drop">
				</td>
				<td>
					<p> 버프 </p>
					<p> 디버프 </p>
				</td>
			</tr>
			<tr id="mid">
				<td id="LM">
					<h4>LM</h4>
					<img src="resources/img/bean.jpg" width=50px height=50px id="LM" class="drop">
				</td>				
				<td id="CM">
					<h4>CM</h4>
					<img src="resources/img/bean.jpg" width=50px height=50px id="CM" class="drop">
				</td>			
				<td id="SP">
					<h4>SP</h4>
					<img src="resources/img/bean.jpg" width=50px height=50px id="SP2" class="drop">
				</td>	
				<td id="RM">
					<h4>RM</h4>
					<img src="resources/img/bean.jpg" width=50px height=50px id="RM" class="drop">
				</td>
				<td>
					<p> 버프 </p>
					<p> 디버프 </p>
				</td>
			</tr>
			<tr id="defense">
				<td id="LB">
					<h4>LB</h4>
					<img src="resources/img/bean.jpg" width=50px height=50px id="LB" class="drop">
				</td>				
				<td id="CB">
					<h4>CB</h4>
					<img src="resources/img/bean.jpg" width=50px height=50px id="CB" class="drop">
				</td>
				<td id="SP">
					<h4>SP</h4>
					<img src="resources/img/bean.jpg" width=50px height=50px id="SP3" class="drop">
				</td>		
				<td id="RB">
					<h4>RB</h4>
					<img src="resources/img/bean.jpg" width=50px height=50px id="RB" class="drop">
				</td>
				<td>
					<p> 버프 </p>
					<p> 디버프 </p>
				</td>
			</tr>
			<tr id="goalkeeper">
				<td></td>
				<td id="GK">
					<h4>GK</h4>
					<img src="resources/img/bean.jpg" width=50px height=50px id="GK" class="drop">
				</td>
				<td></td>
			</tr>
			<tr>
				<td>
					<p> 버프 </p>
					<p> 디버프 </p>
				</td>
				<td>
					<p> 버프 </p>
					<p> 디버프 </p>
				</td>
				<td>
				</td>
				<td>
					<p> 버프 </p>
					<p> 디버프 </p>
				</td>
			</tr>
		</table>
	</div>
</div>
</body>
<script>
$(document).on('click', '.page', function() {	
	let form = $('#form')[0];
	let formData = new FormData(form);
	let id = $(this).attr('id');
	formData.append('page', id);
	
	$.ajax({
		method: "POST",
		url: "/list_player",
		data: formData,
		dataType: "html",
		processData: false,
		contentType: false
	})
	.done(function(data) {
		$("#playerList").html(data);
	});	
});

$(document).on('click', '#btn-all', function () {
	$("input[type=checkbox]").prop("checked", true);
});

$(document).on('click', '#btn-not-all', function () {
	$("input[type=checkbox]").prop("checked", false);
});

$(document).on('click', '#btn-search', function() {
	let form = $('#form')[0];
	let formData = new FormData(form);
	formData.append('page', 1);
	
	$.ajax({
		method: "POST",
		url: "/list_player",
		data: formData,
		dataType: "html",
		processData: false,
		contentType: false
	})
	.done(function(data) {
		$("#playerList").html(data);
	});	
});

$(document).on('click', '.drag', function () {
	let target = $(this);
	let data = target.context;
	let chk = 0;	
		
	$(document).on('click', '.drop', function() {
		if(chk == 0) {		
			let target2 = $(this);			
			let temp = target2.parent();
			let temp2 = temp.children();
						
			$(temp2[1]).attr('src', data.src);
			chk=1;
			
			if(temp[0].id == "SP") {				
				for(let i = 1 ; i <= 3 ; i ++) {
					if(target2.context.id != "SP" + i)
						$("#SP" + i).attr('src', "resources/img/bean.jpg");
				}
			}
			
			tr = temp.parent();
			td = tr.children();
			console.log(td.eq(4));
			
			$.ajax({
				method: "POST",
				url: "/player_skill",
				data: { p_num:data.id},
				dataType: "json"
			})
			.done(function(data) {
				console.log(data);
				td.eq(4).html(data.p1 + "<br>" +  data.p2 + "<br>" + data.p3);
				// 선수 바꾸면 내용 바꾸기
			});
		}
	});
});
</script>
</html>