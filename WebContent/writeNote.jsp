<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지 작성창</title>
 <script src="https://code.jquery.com/jquery-3.5.0.js"></script>  
 <style>
 	#writeForm>#content{
 	margin: 10px 0;
 	width: 360px;
 	height:250px;
 	}
 </style>
</head>
<body>
	<%-- <form action = "${pageContext.request.contextPath}/sendNote" method = "POST"> --%>
	<form id = "writeForm">
		<input type="hidden" id="counterpartNo" name="counterpartNo" value="${ requestScope.counterpart.no }"/>
		<input type="hidden" id="counterpartNickname" name="counterpartNickname" value="${ requestScope.counterpart.nickname }"/>
		받는 사람 : ${ requestScope.counterpart.nickname } <br>
		<textarea rows="10" name="content" id="content"></textarea><br>
		<button type="button" id = "sendBtn">전송</button> <!-- 이거 눌렸을 때 보내고 난 뒤 자바스크립트로 창 닫히게..? -->
	</form> 
	
<script>
	$('#sendBtn').on('click', function() {	
		//var params = $("#writeForm").serialize();
		$.ajax({
			url : '/petopiaWebApp/sendNote',
			method: 'POST',
			data : {
				counterpartNo : $("#counterpartNo").val(),
				counterpartNickname : $("#counterpartNickname").val(),
				content : $("#content").val()
			},
			success : function(data)
			{									
				window.close();
			},
			error: function(e) {
				console.log(e);
			}
		})
	});
</script>
</body>
</html>