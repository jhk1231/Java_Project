<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PETOPIA - 로그인</title>
 <link href="./css/contentStryle.css" rel="stylesheet" type="text/css">
 <script src="https://code.jquery.com/jquery-3.5.0.js"></script>       
</head>
<style>
@import url('https://fonts.googleapis.com/css2?family=Gaegu:wght@700&display=swap');
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap');

.logo{
	font-family: 'Gaegu', cursive;
	font-size: 120px;
}

*{
	font-family: 'Noto Sans KR', sans-serif;
}


/* ===============================================예나==========================  */

.--center {
	margin : 0 auto;
}

.--inputBox {
	border-radius: 6px 6px 6px 6px;
    box-shadow: none;
    border: 1px solid #dadada;
    padding: 17px 18px 17px 19px;
    width : 361px;
}
/* ===============================================예나==========================  */


.loginBox {
	width : 400px;
	height : 500px;
}

.loginButton {
	width : 400px;
	height : 40px;
	border: 1px solid black;
	border-radius: 3px 3px 3px 3px;

}

.loginBottom {
	width : 100%;
	text-align:center;
}

.forcenter {
	display:inline-block;
	text-align:center;
	width:50%;
	height : 20px;
}

.loginView__a{
	font-size: 16px;
    line-height: 18px;
    text-decoration: none;
    color: #888;
}
</style>
<body>
	
	<div class = "loginBox --center">
		<div class = "logo">PETOPIA</div>
		<div>
			<span class="material-icons-outlined"></span>
			<label for="email"></label>
	 		<input class = "--inputBox" type="email" name="email" id="email" placeholder = "E-MAIL">
	 		<p id = "topText"></p>
			<label for="password"></label>
	 		<input class = "--inputBox" type="password" name="password" id="password" placeholder = "PASSWORD">
			<p id = "bottomText"></p>
	 		<button class = "loginButton" type="button" id="loginBtn">로그인</button>
	 		<div class = "loginBottom">
	 		<div class = "forcenter">
	 		<br>
	 			<a class = "loginView__a" href = "${pageContext.request.contextPath}/join.jsp">회원가입</a> 
	 			<span class = "loginView__a">ㅣ</span>
	 			<a class = "loginView__a" href = "${pageContext.request.contextPath}/findPassword.jsp">비밀번호 찾기</a>
	 		</div>
	 		</div>
	 	</div>
 	</div>
	<!--  비동기 메시시 처리 방식 -->
	<script>      

        const getAjax = function(url, email, password) {
            return new Promise( (resolve, reject) => {
                $.ajax({                        
                    url: url,
                    method: 'POST',
                    dataType: 'json',
                    data: {
                     	email: email,
                    	password: password
                    },
                    success: function(data) {  // 비동기 작업 성공 시 호출                  	
                        resolve(data);
                    }, 
                    error: function(e) {  // 비동기 작업 실패 시 호출                  	
                        reject(e);
                    }
                });
            });
        }   
        
		//async : 해당 함수가 비동기 작업을 처리한다는 걸 명시
        async function requestProcess(url, email, password) {
            try {				// await 다음에는 비동기 처리 작업이 와야함.
                const result = await getAjax(url, email, password);
                
                console.log(result);
                
                if( result.isSuccess == 0){
                    $('#bottomText').text(result.failText);	
                } else if (result.isSuccess == 1) {
                	location.href = result.url;
                } else if(result.isSuccess == 2){
                	alert(result.failText);
                } else if(result.isSuccess == 3){
                	alert(result.failText);
                }
                
                  
            } catch (error) {
                console.log("error : ", error);   
            }
        }
        
        
        
	    $('#loginBtn').on('click', function() {		
	    	$('#topText').text("");
	    	$('#bottomText').text("");	
			const email = $('#email').val();
	    	const password = $('#password').val();
	    	
	    	let doRequest = true;
	    	if(email == ""){
	    		$('#topText').text("아이디를 입력해주세요.");
	    		doRequest = false;
	    	}
	    	if(password == ""){
	    		$('#bottomText').text("비밀번호를 입력해주세요.");
	    		doRequest = false;
	    	}
	    	
	    	if(doRequest == true){
	    		requestProcess('/petopiaWebApp/login.do', email, password);	
	    	}
	    });
	</script>
</body>
</html>