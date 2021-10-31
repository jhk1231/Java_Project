<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
</head>
<body>

<div>
<label for="email">이메일 : </label>
<input type="text" name="email" id="email">
<button type="button" id = "sendBtn">인증번호 전송</button>
<%-- <span onclick="location.href='${pageContext.request.contextPath}/sendMail.do'">인증번호받기</span> --%>
</div>
<p id = "bottomText"></p>

<div>
<label for="verification">인증번호 : </label>
<input type="text" name="verification" id="verification">
<<button type="button" id = "codeSendBtn">제출</button>
</div>

<script>      
		var code;
		var memNo;
        const getAjax = function(url, email) {
            // resolve, reject는 자바스크립트에서 지원하는 콜백 함수이다.
            return new Promise( (resolve, reject) => {
                $.ajax({                        
                    url: url,
                    method: 'POST',
                    dataType: 'json',
                    data: {
                     	email: email
                    },
                    async: true,
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
                const result = await getAjax(url, email);
                
                console.log(result);
                
                if( result.isSuccess != 1){
                    $('#bottomText').text(result.failText);	
                } else if (result.isSuccess == 1) {
                	alert("인증 번호를 발신했습니다.");
                	code = result.code;
                	memNo = result.memberNo;
                }
                
                  
            } catch (error) {
                console.log("error : ", error);   
            }
        }
        
	    $('#sendBtn').on('click', function() {		
	    	$('#bottomText').text("");	
			const email = $('#email').val();
	    	
	    	let doRequest = true;
	    	if(email == ""){
	    		$('#bottomText').text("아이디를 입력해주세요.");
	    		doRequest = false;
	    	}
	    	if(doRequest == true){
	    		requestProcess('/petopiaWebApp/sendMail.do', email);	
	    	}
	    });
	    
	    $('#codeSendBtn').on('click', function() {		
	    	$('#bottomText').text("");	
			/* const code = '${sessionScope.AuthenticationKey}'; */
	    	const verification = $('#verification').val();
	    	console.log(code);
	    	console.log(verification);
	    	console.log(memNo);
	    	if(code != verification)
	    		$('#bottomText').text("인증 번호가 틀립니다.");
	    	else
	    		location.href = "${pageContext.request.contextPath}/resetPassword.jsp?userNo="+memNo;
	    	
	    });
	</script>
</body>
</html>