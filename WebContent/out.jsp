<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>	회원 탈퇴 </title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<script>
	
	$(document).ready(function() {

		//function
      	const getAjax = function(url, password) {
			
      		return new Promise( (resolve, reject) => {
          		$.ajax({
      				url: url,
      				method: 'POST',
      				dataType: 'json',
      				data: {
      					password: password
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
		
      	//[시작] 비밀번호 중복검사 (db확인)
      	async function sendProcess(url, password) {
      		try {
      			var result = await getAjax(url, password);
      			
      			if (result.isPwd == 'true') {  //비밀번호가 존재하는 경우
      				$('#errmsgpw').html("비밀번호가 일치합니다. 탈퇴를 원하시면 회원탈퇴 버튼을 눌러주세요.");
      				$('#errmsgpw').css("color", "green");
      			
      			} else if (result.isPwd == 'false') {  //비밀번호가 존재하지 않는 경우
      				$('#errmsgpw').html("비밀번호가 일치하지 않습니다.");
      				$('#errmsgpw').css("color", "red");
      				
      			}
      		}
      		catch(e) {
      			console.log(e);
      		}      		
		} //[끝] 비밀번호 중복검사 (db확인)
		      	
  
        //[시작] 비밀번호 인풋박스 선택시 "비밀번호를 입력해주세요." 경고 문구 "    "로 공백 만들기
      	$( "#password" ).focus(function() {
      		$('#errmsgpw').html("	");
      	}); //[끝] 비밀번호 인풋박스 선택시 "비밀번호를 입력해주세요." 경고 문구 "    "로 공백 만들기

    	
        //[시작] 회원가입 버튼 눌렀을 시 발생하는 코드 
      	$('#pwdcheckbtn').submit(function(event) {
      	  
      		 //인풋박스 값에 대한 변수 정의
  
             const password = $('#password').val(); //패스워드 인풋박스에 value(값)을 가져온걸 password이라 부르겠다.
         
             if (password == "") { //password 인풋박스가 공백일 때
            	 $('#errmsgpw').html("비밀번호를 입력해주세요.");//errmsgpw 공간(div)에 "비밀번호를 입력해주세요." 문구 노출
   				 $('#errmsgpw').css("color", "red"); //errmsgpw는 빨간색 글씨로 css 처리하겠다.
   				 return false; 
             }  //[끝] 회원가입 버튼 눌렀을 시 발생하는 코드 
             else {
            	 sendProcess('${pageContext.request.contextPath}/checkpwd.do', password);
       		} 
            alert("회원탈퇴가 완료되었습니다.")
            return true; //모든게 끝나고 return
      		
         	});
         	
      	});
</script>
</head>
<body>
<h1>회원 탈퇴</h1>
	<form action="${pageContext.request.contextPath}/out.do" method="post">
		<input type="hidden" name = "memberNo" value = "${sessionScope.user.no }" />
		비밀번호 확인 <input type="password" id="name="password">
		<div id='errmsgpw'></div>
	
		<input type="submit" value="회원 탈퇴" id="pwdcheckbtn">
	</form>


</body>
</html>