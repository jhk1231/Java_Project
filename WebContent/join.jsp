<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>


<meta charset="UTF-8">

<title>회원가입</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<script>
	var duplicate = false;
	//닉네임 function
	var duplicatenickname = false;
	$(document).ready(function() {
		
		//function
      	const getAjax = function(url, email) {
			
      		return new Promise( (resolve, reject) => {
          		$.ajax({
      				url: url,
      				method: 'POST',
      				dataType: 'json',
      				data: {
      					email: email
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
		
		
      	const getAjax1 = function(url, nickname) {
			
      		return new Promise( (resolve, reject) => {
          		$.ajax({
      				url: url,
      				method: 'POST',
      				dataType: 'json',
      				data: {
      					nickname: nickname
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
		
		//[시작] 아이디 중복검사 (db확인)
      	async function sendProcess(url, email) {
      		try {
      			var result = await getAjax(url, email);
      			
      			if (result.isEmail == 'true') {  //이메일이 존재하는 경우
      				$('#errmsgid').html("존재하는 아이디입니다.");
      				$('#errmsgid').css("color", "red");
      				duplicate = true;
      			} else if (result.isEmail == 'false') {  //이메일이 존재하지 않는 경우
      				$('#errmsgid').html("사용 가능한 아이디입니다.");
      				$('#errmsgid').css("color", "green");
      				duplicate = false;
      			}
      		}
      		catch(e) {
      			console.log(e);
      		}      		
		} //[끝] 아이디 중복검사 (db확인)
		      	
		//아이디 중복확인 버튼 눌렀을 시 실행되는 코딩 [시작]
      	$('#idcheckbtn').on("click", function(event) {
      		const email = $('#email').val();
      		console.log('email : ', email);
      
      		if(CheckEmail(email)){
      			sendProcess('${pageContext.request.contextPath}/checkid.do', email);
      		} else {
      			alert("올바른 이메일 주소를 입력해주세요.");
      		}
      	}); //아이디 중복확인 버튼 눌렀을 시 실행되는 코딩 [끝]
      	 
      	//이메일 형식으로 유효성 검사 [시작]
      	function CheckEmail(str){                                                 
      		var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
			if(!reg_email.test(str)) {                            
			
				return false;         
			
			} else {                       
				return true;         
			}                            
		} //이메일 형식으로 유효성 검사 [끝]
		
	
		
		//[시작] 닉네임 중복검사 (db확인)
      	async function sendProcess1(url, nickname) {
      		try {
      			var result = await getAjax1(url, nickname);
      			
      			if (result.isNickname == 'true') {  //닉네임이 존재하는 경우
      				$('#errmsgnn').html("존재하는 닉네임입니다.");
      				$('#errmsgnn').css("color", "red");
      				duplicatenickname = true;
      				
      			} else if (result.isNickname == 'false') {  //닉네임이 존재하지 않는 경우
      				$('#errmsgnn').html("사용 가능한 닉네임입니다.");
      				$('#errmsgnn').css("color", "green");
      				duplicatenickname = false;
      			}
      		}
      		catch(e) {
      			console.log(e);
      		}//[끝]닉네임 중복검사 (db확인)  		
		} 
      //닉네임 중복확인 버튼 눌렀을 시 실행되는 코딩 [시작]
      	$('#nncheckbtn').on("click", function(event) {
      		const nickname = $('#nickname').val();
      		console.log('nickname : ', nickname);
      

      		sendProcess1('${pageContext.request.contextPath}/NicknameCheck.do', nickname);
      		
      		
      	}); //닉네임 중복확인 버튼 눌렀을 시 실행되는 코딩 [끝]
      	 
		 
       //[시작] input 박스 커서 선택 시 "~입력해주세요." 에러메세지 없애기
      	//이메일 인풋박스 선택시 "이메일을 입력해주세요." 경고 문구 "    "로 공백 만들기
      	$( "#email" ).focus(function() {
      		$('#errmsgid').html("	");
      	});
        //비밀번호 인풋박스 선택시 "비밀번호를 입력해주세요." 경고 문구 "    "로 공백 만들기
      	$( "#password" ).focus(function() {
      		$('#errmsgpw').html("	");
      	});
        //닉네임 인풋박스 선택시 "닉네임을 입력해주세요." 경고 문구 "    "로 공백 만들기 
      	$( "#nickname" ).focus(function() {
      		$('#errmsgnn').html("	");
      	}); 
        //[끝] input 박스 커서 선택 시 "~입력해주세요." 에러메세지 없애기
      	
      	
        //[시작] 회원가입 버튼 눌렀을 시 발생하는 코드 
      	$('#joinForm').submit(function(event) {
      	  
      		 //인풋박스 값에 대한 변수 정의
             const email = $('#email').val(); //이메일 인풋박스에 value(값)을 가져온걸 email이라 부르겠다.
             const password = $('#password').val(); //패스워드 인풋박스에 value(값)을 가져온걸 password이라 부르겠다.
             const nickname = $('#nickname').val(); //닉네임 인풋박스에 value(값)을 가져온걸 nickname이라 부르겠다.
            
             //인풋박스가 빈칸일때 경고 문구 노출
             if (email == "") { //email 인풋박스가 공백일 때
            	 $('#errmsgid').html("아이디를 입력해주세요."); //errmsgid 공간(div)에 "아이디를 입력해주세요." 문구 노출
   				 $('#errmsgid').css("color", "red");  //errmsgid는 빨간색 글씨로 css 처리하겠다.
   				 return false; //if에 맞는 조건에 걸리면 밑에거 건너 뛰어라 (지금 당장 내가 에러나서 뭘 발생해야겠으니 밑에까지 갈 필요도 없다.)
             }
                        
             
             if (password == "") { //password 인풋박스가 공백일 때
            	 $('#errmsgpw').html("비밀번호를 입력해주세요.");//errmsgpw 공간(div)에 "비밀번호를 입력해주세요." 문구 노출
   				 $('#errmsgpw').css("color", "red"); //errmsgpw는 빨간색 글씨로 css 처리하겠다.
   				 return false; 
             } 
             
             if (nickname == "") { //nickname 인풋박스가 공백일 때
            	 $('#errmsgnn').html("닉네임을 입력해주세요.");//errmsgnn 공간(div)에 "비밀번호를 입력해주세요." 문구 노출
   				 $('#errmsgnn').css("color", "red");//errmsgnn는 빨간색 글씨로 css 처리하겠다.
   				 return false;
             }
             
             if(duplicate == true){ //중복된 아이디를 입력 시에 
        			$('#errmsgid').html("아이디 중복확인을 해주세요."); //errmsgid 공간(div)에 "아이디 중복확인을 해주세요."
     				$('#errmsgid').css("color", "red");//errmsgid는 빨간색 글씨로 css 처리하겠다.
        			return false;
        			 
              }	 
             
             if(duplicatenickname == true){ //중복된 닉네임 입력시에
     			$('#errmsgnn').html("닉네임 중복확인을 해주세요."); //errmsgnn 공간(div)에 "닉네임 중복확인을 해주세요."
  				$('#errmsgnn').css("color", "red");//errmsgnn는 빨간색 글씨로 css 처리하겠다.
     			return false;
     			 
           }	 //[끝] 회원가입 버튼 눌렀을 시 발생하는 코드 
              
            alert("회원가입이 완료되었습니다.")
            return true; //모든게 끝나고 return
      		
         	});
         	
      	});

      	
</script>

</head>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Gaegu:wght@700&display=swap')
	;

@import
	url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap')
	;

.logo {
	font-family: 'Gaegu', cursive;
	font-size: 120px;
}

* {
	font-family: 'Noto Sans KR', sans-serif;
}

/* ===============================================예나==========================  */
.--center {
	margin: 0 auto;
}

.--inputBox {
	border-radius: 6px 6px 6px 6px;
	box-shadow: none;
	border: 1px solid #dadada;
	padding: 17px 18px 17px 19px;
	width: 361px;
}
/* ===============================================예나==========================  */
/* .loginBox {
	width: 400px;
	height: 500px;
} */

.joinBox {
	width: 1000px;
	height: 1000px;
	display: flex;
	justify-content: center;
}

.joinButton {
	width: 400px;
	height: 40px;
	border: 1px solid black;
	border-radius: 3px 3px 3px 3px;
}

.joinBottom {
	width: 100%;
	text-align: center;
}

.forcenter {
	display: inline-block;
	text-align: center;
	width: 50%;
	height: 20px;
}

.loginView__a {
	font-size: 16px;
	line-height: 18px;
	text-decoration: none;
	color: #888;
}

.wrap {
	width: 500px;
	height: 500px;
}
</style>
<body>


	<div class="joinBox">
		<div class="wrap">
			<div class="logo --center">PETOPIA</div>
			<h3>회원가입 정보를 입력해주세요 :)</h3>
			<div>
				<span class="material-icons-outlined"></span>
				<form action="${pageContext.request.contextPath}/join.do"
					method="post" id="joinForm">

					 <!-- 아이디(이메일) <br><input class="--inputBox" type="email" name="email" id="email"> -->
					<label for="email"></label> <input class="--inputBox" type="email"
						name="email" id="email" placeholder="E-MAIL">

					<button type="button" id="idcheckbtn">중복 확인</button>
					<!-- 아이디 에러메시지 문구 공간 -->
					<div id='errmsgid'></div>

					<!-- 비밀번호 <br><input class = "--inputBox" type="password" name="password" id="password"> -->
					<label for="password"></label> <input class="--inputBox"
						type="password" name="password" id="password"
						placeholder="PASSWORD">
					<!-- 비밀번호 에러메시지 문구 공간 -->
					<div id='errmsgpw'></div>

					<!-- 닉네임 <br> <input class="--inputBox" type="text" name="nickname"
					id="nickname"> -->
					<label for="nickname"></label> <input class="--inputBox"
						type="text" name="nickname" id="nickname" placeholder="닉네임">

					<button type="button" id="nncheckbtn">중복 확인</button>

					<!-- 닉네임 에러메시지 문구 공간 -->
					<div id='errmsgnn'></div>

					<input class="joinButton" type="submit" value="회원가입 하기">
					<div class="joinBottom">
						<div class="forcenter"></div>
					</div>
				</form>
			</div>

		</div>
	</div>
</body>
</html>