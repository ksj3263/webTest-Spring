<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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
</style>
<body>
<div>
	<div class='left'>
		<span id='1' draggable='true' ondragstart='onDragStart(event);'>
			1
		</span>
		
		<span id='2' draggable='true' ondragstart='onDragStart(event);'>
			2
		</span>
		
		<span id='3' draggable='true' ondragstart='onDragStart(event);'>
			3
		</span>
		
		<table>
			<tr>
				<th>
					<img src="resources/img/bean.jpg" id="123" ondragstart='onDragStart(event);' width=50px height=50px>
				</th>
				<th>
					<img src="resources/img/waterfall.jpg" id="456" ondragstart='onDragStart(event);' width=50px height=50px>
				</th>
				<th>날짜</th>
			</tr>
			<tr>
				<th>ID</th>
				<th>내용</th>
				<th>날짜</th>
			</tr>
		</table>		
	</div>
	
	<div class="right">
		<span ondragover='onDragOver(event);' ondrop='onDrop(event);' id="t1">
			dropzone
		</span>
		
		<span ondragover='onDragOver(event);' ondrop='onDrop(event);' id="t2">
			dropzone
		</span>
		
		<span ondragover='onDragOver(event);' ondrop='onDrop(event);' id="t3">
			dropzone
		</span>
	</div>
	</div>
</body>
<script>
function onDragStart(event) {
	event.dataTransfer.setData('text/plain', event.target.id);
}

function onDragOver(event) {
	event.preventDefault();
}

function onDrop(event) {
	const id = event.dataTransfer.getData('text');
	
	const draggableElement = document.getElementById(id);
	const dropzone = event.target;
	
	console.log(draggableElement);
	console.log(dropzone.id);
	let testId = dropzone.id;
	
	let temp = document.getElementById(testId);
	console.log(temp);
	
	temp.html('');	
		
	dropzone.appendChild(draggableElement);
	
	event.dataTransfer.clearData();
}
</script>
</html>