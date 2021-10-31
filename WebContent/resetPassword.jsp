<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>

<script>
	$(document).ready(function() {
		
		//function
      	const getAjax = function(url, newpassword) {
			
      		return new Promise( (resolve, reject) => {
          		$.ajax({
      				url: url,
      				method: 'POST',
      				dataType: 'json',
      				data: {
      					newpassword: newpassword
      				},
      				async: true,
      				success: function(data) {						
						resolve(data);
					},
					error: function(e) {						
						reject(e);
					}
   			
      			});
          		
      		}); 
      		
		};
		
		
		async function sendProcess(url, email) {
      		try {
      			var result = await getAjax(url, email);
      			
      			if (result.isEmail == 'true') {  //비밀번호가 일치하는 경우
      				$('#errmsgid').html("존재하는 아이디입니다.");
      				$('#errmsgid').css("color", "red");
      				
      			} else if (result.isEmail == 'false') {  //이메일이 존재하지 않는 경우
      				$('#errmsgid').html("사용 가능한 아이디입니다.");
      				$('#errmsgid').css("color", "green");
      			}
      		}
      		catch(e) {
      			console.log(e);
      		}      		
		}
		      	
      	
      	$('#idcheckbtn').on("click", function() {
      		const email = $('#email').val();
      		console.log('id : ', email);
      		
      		sendProcess('${pageContext.request.contextPath}/idCheck.do', email);
      		
      	});
      	
      	    	
		$('#newpwform').submit(function(event) {

			const newpassword = $('#newpassword').val();
			const checkNewpassword = $('#checkNewpassword').val();

			if (newpassword == "") {
				$('#errmsnewpw1').html("새로운 비밀번호를 입력해주세요.");
				$('#errmsnewpw1').css("color", "red");
				return false;
			}

			if (checkNewpassword == "") {
				$('#errmsnewpw2').html("비밀번호 확인을 입력해주세요.");
				$('#errmsnewpw2').css("color", "red");
				return false;
			}

			return true;
		});

	});
	
</script>
</head>
<body>
	<h1>비밀번호 재설정</h1>
	<form action="${pageContext.request.contextPath}/resetpassword.do?userNo=${param.userNo}"
		method="post" id="">
		새로운 비밀번호 <input type="password" name="newpassword" id="newpassword">
		<br>
		<div id='errmsnewpw1'></div>

		비밀번호 확인 <input type="password" name="checkNewpassword" id="checkNewpassword"> <br>
		<div id='errmsnewpw2'></div>
		<input type="submit" value="비밀번호 변경">
	</form>

</body>
</html>