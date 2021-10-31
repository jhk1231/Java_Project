<%-- 게시글 세부 조회 --%>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*, model.article.ArticleVo"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page session="true"%>



<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Content</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
<link href="./css/viewMainContent.css" rel="stylesheet" type="text/css">
<style>
p.pageName{
	background-color: #D8D8D8;
	background-size: weidth=30;
	
}
div.content {
	background-size: 80% 100%;
	background-image: url(./img/writeForm.jpg);
	background-repeat: no-repeat;
	background-color: #FAF0E6;
}
div.selectBoard{
	size=60px;
}
table.writeForm {
	left: 115px;
	top: 70px;
}
.bbs>tbody>tr{
	width: 300px;
}
div .content{
	font-family: "Trebuchet MS", Verdana, sans-serif;
}
div.content{
	border : 1.5px solid #bcbcbc;
	
}
table.bbs{
	border-collapse: collapse;
	border : 2px solid #bcbcbc;
}

</style>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
    	$(document).ready(function() {
    		// 추천 버튼 클릭시
    		$('#rec_update').click(function(){
    			$.ajax({
    				url: "${pageContext.request.contextPath}/RecUpdate.do",
    				type: "POST",
    				data:{
    					// 게시글을 추천 했는지 안했는지 확인.
    					articleNo: '${param.articleNo}',
    					memberNo: '${sessionScope.user.no }'
    				},
    				success: function(count){
    					$(".rec_count").html(JSON.parse(count).totalCount);
    					//recCount();
    				},
    			})
    		})
    		
    		// 게시글 추천수
    		function recCount(){
    			$.ajax({
    				url: "${pageContext.request.contextPath}/RecCount.do",
    				type: "POST",
    				data: {
    					// 게시글의 총 추천수만 구하면 되니 게시글 번호만 넘겨준다.
    					articleNo: '${param.articleNo}'
    				},
    				success: function(count){
    					// rec_count 내용을 비우고 count로 갱신
    					$(".rec_count").html(JSON.parse(count).totalCount);
    				},
    			})
    		};
    		// 맨처음 시작시 호출
    		recCount();
    		
    		
    		
    		
    		 const getAjax = function(url, no, content) {
                // resolve, reject는 자바스크립트에서 지원하는 콜백 함수이다.
                return new Promise( (resolve, reject) => {
                    $.ajax({                        
                        url: url,
                        method: 'GET',
                        dataType: 'json',
                        data: {
                        	no: no,
                        	content: content,
                        	articleNo: '${param.articleNo}'
                        	
                        },
                        success: function(data) {                    	
                            resolve(data);
                        }, 
                        error: function(e) {                    	
                            reject(e);
                        }
                    });
                });
            }   
    		 
    		const removeReply = function(url, no) {
                // resolve, reject는 자바스크립트에서 지원하는 콜백 함수이다.
                return new Promise( (resolve, reject) => {
                    $.ajax({                        
                        url: url,
                        method: 'GET',
                        dataType: 'json',
                        data: {
                        	no: no,
                        	articleNo: '${param.articleNo}'
                        },
                        success: function(data) {                    	
                            resolve(data);
                        }, 
                        error: function(e) {
                        	console.trace();
                            reject(e);
                        }
                  });
                });
            }   
    		
            async function requestProcess(url, no, content) {
                try {
                    
                	let replyList = null;
                	if(content == null || content == '' || typeof content == "undefined") {
                		replyList = await removeReply(url, no);
                	} else {
                		replyList = await getAjax(url, no, content);	
                	}
                	     
                    $('#ListReply').html("");
                   
				 	let htmlStr = [];
				 
				 	console.log(htmlStr);
				 	for(let i = 0; i< replyList.length; i++) {
				 		htmlStr.push('<table id=' + replyList[i].replyNo +'>');
				 		htmlStr.push('<tbody>');
				 		htmlStr.push('<tr>');
				 		htmlStr.push('<td>' + replyList[i].nickname + '</td>');
				 		htmlStr.push('<td>' + replyList[i].writedate  + '</td>');
				 		htmlStr.push('</tr>');		
				 		htmlStr.push('<tr>');	
				 		htmlStr.push('<td colspan="2" class="Content">' + replyList[i].content + '</td>');
				 		htmlStr.push('</tr>');
				 		htmlStr.push('<tr>');	
				 		htmlStr.push('<td colspan="2">');
				 		if('${sessionScope.user.nickname}' == replyList[i].nickname) {
				 			htmlStr.push('<button class="modifyFormBtn" type="button">수정</button>&nbsp;');		
					 		htmlStr.push('<button class="removeBtn" type="button">삭제</button>');			
				 		}
				 		htmlStr.push('</td>');					
				 		htmlStr.push('</tr>');
				 		htmlStr.push('</tbody>');
				 		htmlStr.push('</table>');				 		
				 	}         
				 	console.log(htmlStr);
				 	$('.ListReply').html(htmlStr.join(""));
				 	
                } catch (error) {
                	console.trace();
                    console.log("error : ", error);   
                }
            }
          //댓글 달기
            $('#addReplyBtn').on('click', function() {
            	const articleNo = '${param.articleNo}';
            	const content = $('#addContent').val();
           		console.log('ajax전');
            	requestProcess('${pageContext.request.contextPath}/addReply.do', articleNo, content);
            	console.log('ajax후');
            });
            
            //댓글 수정폼
            $('.ListReply').on('click', '.modifyFormBtn', function() {                
            	const no = $(this).parents('table').attr('id');
            	$('#modifyReply').insertAfter('#' + no);   
            	const content = $(this).parents('tbody').find('.Content').text();   
                $('#modifyReplyContent').val(content);            	
            	$('#no').val(no);            	
            	$('#modifyReply').show();            	
            	$('#' + no).hide();
            });
            

            //댓글 삭제
            $('.ListReply').on('click', '.removeBtn', function() {
            	const no = $(this).parents('table').attr('id');
            	console.log(1, no)
            	requestProcess('${pageContext.request.contextPath}/removeReply.do', no);        	
            });
            
            
            //댓글 취소
            $('#cancel').on('click', function() {
            	const no = $('#no').val();
            	$('#' + no).show();    
            	$('#modifyReply').hide();
            	$('#modifyReply').insertAfter('#addReply');
            });
            
            //댓글 수정
            $('.modifyBtn').on('click', function() {
            	const no = $('#no').val();
            	const content = $('#modifyReplyContent').val();
            	requestProcess('${pageContext.request.contextPath}/modifyReply.do', no, content); 
            	$('#modifyReply').insertAfter('#addReply');
            	$('#modifyReply').hide();
            	$('#modifyReply').html();            	
            });
				
	});
	

</script>
</head>
<body>
	<div class="content">
		<!-- Content 내용 여기에 추가 -->
		<table class="bbs" border="2" >
			<tbody>
				<tr>
					<p>
					<td>제목:</td>
					<td colspan="5">${requestScope.articles.subject }</td>
					</p>
				</tr>
				<tr>
					<p>
					<td>작성자:</td>
					<td colspan="5">${requestScope.articles.nickname }</td>
					</p>
				</tr>
				<tr>
					<p>
					<td>작성일:</td>
					<td colspan="5">${requestScope.articles.writedate }</td>
					</p>
				</tr>

				<tr>
					<td>내용:</td>
					<td colspan="5">${requestScope.articles.content }</td>
				</tr>
				<tr height="100">
					<td>
						<button id="btn" type="button"
							onclick="location.href='viewWriteArticleForm.do';">글쓰기</button>
					</td>
					<td><c:url var="backUrl"
							value="/viewListArticleContent.do?boardNo=${param.boardNo }" >
							<c:param name="boardName" value= "${param.boardName }"/>
							</c:url>
						<button id="backBtn" type="button"
							onclick="location.href='${backUrl}';">목록</button></td>
					<!-- 추천 기능 -->
					<td>
						<div class="w3-border w3-center w3-padding">
							<button class="w3-button w3-black w3-round" id="rec_update">
								<i class="fa fa-heart" style="font-size: 30px; color: red"></i>
								&nbsp;<span class="rec_count"></span>
							</button>
						</div>
					</td>
						<c:if test='${requestScope.articles.nickname == sessionScope.user.nickname}'>
						<td><c:url var="modifyUrl" value="/viewModifyArticleForm.do">
								<c:param name="articleNo" value="${param.articleNo }" />
								<c:param name="boardNo" value="${param.boardNo }" />
								<c:param name="boardName" value= "${param.boardName }"/>
							</c:url>
							<button id="modifyBtn" type="button"
								onclick="location.href='${modifyUrl}';">수정</button></td>
						<td>
							<form>
								<c:url var="removeUrl" value="removeArticle.do">
									<c:param name="articleNo" value="${param.articleNo }" />
									<c:param name="boardNo" value="${param.boardNo }" />
									<c:param name="boardName" value= "${param.boardName }"/>
								</c:url>
								<button id="reomveBtn" type="button"
									onclick="location.href='${removeUrl}';">삭제</button>
							</form>
						</td>
					</c:if>
				</tr>
			</tbody>
		</table>
		&nbsp;
		<%-- 첨부파일 출력. --%>
		<div class="file">
			<c:if test="${empty requestScope.articles.fileList }">등록된 파일이 없습니다.
		</c:if>

			<c:if test="${not empty requestScope.articles.fileList }">
				<th>파일명</th>
				<th>파일크기</th>
				<c:forEach var="file" items="${requestScope.articles.fileList }">
					<c:url var="downloadUrl" value="/fileDownload">
						<c:param name="originalFileName" value="${file.originalFileName}" />
						<c:param name="systemFileName" value="${file.systemFileName}" />
					</c:url>
					<td><a href="${downloadUrl}">${file.originalFileName }</a></td>
					<td>${file.fileSize }bytes</td>
				</c:forEach>
			</c:if>
		</div>
		&nbsp;
		<%-- 댓글 --%>
		<%-- 댓글 달기 --%>
		<div id="addReply">
			<div>
				<textarea id="addContent" rows="5" cols="50"
					placeholder="댓글을 입력해주세오 ."></textarea>
			</div>
			<div>
				<button id="addReplyBtn">댓글 달기</button>
			</div>
		</div>
		<div class="ListReply">
			<c:forEach var="reply" items="${requestScope.replyList }">
				<%--<table id="${reply.replyNo }" width="800" height="200">--%>
				<table id="${reply.replyNo }" height="200">
					<tbody>
						<tr>
							<td>${reply.nickname }</td>
							<td>${reply.writedate }</td>
						</tr>
						<tr>
							<td colspan="2" class="replyContent">${reply.content }</td>
						</tr>
						<c:if test="${reply.nickname } == ${sessionScope.user.nickname }">
							<tr>
								<td colspan="2">
									<button class="modifyFormBtn" type="button">수정</button>
									<button class="removeBtn" type="button">삭제</button>
								</td>

							</tr>
						</c:if>
					</tbody>
				</table>
			</c:forEach>
		</div>

		<%-- 댓글 수정--%>
		<div id="modifyReply" style="display: none;">
			<div>
				<input type="hidden" id="no" />
				<textarea id="modifyReplyContent" rows="5" cols="50"
					placeholder="댓글을 입력해주세오 ."></textarea>
			</div>
			<div>
				<button id="cancel">취소</button>
				<button class="modifyBtn">수정하기</button>
			</div>
		</div>
	</div>
</body>
</html>