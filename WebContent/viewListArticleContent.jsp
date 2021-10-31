<%-- 게시글 목록 보기 --%>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous">	</script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
<link href="./css/viewMainContent.css" rel="stylesheet" type="text/css">
<link href="./css/viewMainBoardContent.css" rel="stylesheet"
	type="text/css">
</head>
<body>

	<div class="content">
		<!-- Content 내용 여기에 추가 -->
		<div class="boardName">
			<h1>${requestScope.boardName }</h1>
		</div>
		<table class="boardList cartegory-boards-style">
			<colgroup>
				<col width="80" />
				<%--No --%>
				<col width="500" />
				<%--제목 --%>
				<col width="100" />
				<%--작성자 --%>
				<col width="130" />
				<%--작성일 --%>
				<col width="100" />
				<%--조회수 --%>
				<col width="100" />
				<%--좋아요 --%>
			</colgroup>
			<thead>
				<tr class="cartegory-boards-article-head-style">
					<th>No</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>좋아요</th>
				</tr>
			</thead>
			<tbody id="wetbody">
				<%-- 만약에 request영역에 바인딩된 자료가 비어 있는 경우 --%>
				<c:if test="${empty requestScope.articles }">
					<tr>
						<td colspan="6">등록된 게시글이 없습니다.</td>
					</tr>
				</c:if>

				<c:if test="${not empty requestScope.articles }">
					<c:forEach var="article" items="${requestScope.articles }"
						varStatus="loop">
						<%-- 상세 조회 --%>
						<c:url var="detailArticleUrl" value="/viewDetailArticleContent.do">
							<c:param name="articleNo" value="${pageScope.article.articleNo }" />
							<c:param name="boardNo" value="${param.boardNo }" />
							<c:param name="gradeNo" value="${sessionScope.user.gradeNo }" />
						</c:url>
						<tr class="cartegory-boards-article-style">

							<td>${pageScope.article.articleNo }</td>
							<td><a href="${detailArticleUrl}">${pageScope.article.subject }</a></td>
							<c:url var="noteUrl" value="/writeNote.do">
								<c:param name="memberNo" value="${pageScope.article.memberNo}" />
							</c:url>
							<td><a
								href="javascript:void(window.open('${pageScope.noteUrl}', '쪽지작성창','width=500px, height=500px'))">${pageScope.article.nickname }</a></td>
							<td>${pageScope.article.writedate }</td>
							<td>${pageScope.article.viewcount }</td>
							<td>${pageScope.article.likecount }</td>

						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>

		<%-- ***Pagging**** --%>
		<div id="pagging" class="cartegory-boards-pagging-style">
			<c:set var="pageBlock" value="${requestScope.pageBlock }"
				scope="page" />
			<c:set var="startPage" value="${requestScope.startPage }"
				scope="page" />
			<c:set var="endPage" value="${requestScope.endPage }" scope="page" />
			<c:set var="totalPage" value="${requestScope.totalPage }"
				scope="page" />
			<c:set var="currentPage" value="${param.currentPage }" scope="page" />
			<c:if test="${totalPage > 0}">
				<%-- 1블록을 제외한 모든 경우 --%>
				<c:if test="${startPage > pageBlock }">
					<c:url var="prevUrl" value="/viewListArticleContent.do">
						<c:param name="currentPage" value="${startPage - pageBlock }" />
					</c:url>
					<a href="${prevUrl }">[Prev]</a>
				</c:if>
				<%-- page 숫자 출력 부분 --%>
				<c:forEach var="i" begin="${startPage }" end="${endPage }">
					<c:if test="${i == currentPage }">
						<span>&nbsp;${i }&nbsp;</span>
					</c:if>
					<%-- 현재 페이지가 아닌 애들 출력 , 만약에 그 page번호를 클릭한다면 자기 자신을 cuurentPage로 해서 /listArticle.do로 넘겨준다 --%>
					<c:if test="${i != currentPage }">
						<c:url var="movePageUrl" value="/viewListArticleContent.do">
							<c:param name="currentPage" value="${i}" />
							<c:param name="boardNo" value="${param.boardNo }" />
						</c:url>
						<a href="${movePageUrl}">&nbsp;${i}&nbsp;</a>
					</c:if>
				</c:forEach>
				<%-- 다음 페이지로 넘긴다. --%>
				<c:if test="${endPage < totalPage }">
					<c:url var="nextUrl" value="/viewListArticleContent.do">
						<c:param name="currentPage" value="${endPage + 1 }" />
					</c:url>
					<a href="${nextUrl }">[Next]</a>
				</c:if>
			</c:if>
		</div>
		<div id="search" class="cartegory-search-style">
			<select id="keyfield">
				<option value="subject">제목</option>
				<option value="writer">작성자</option>
			</select> <input type="search" placeholder="검색어를 입력하세요" id="keyword">
			<button type="button" id="searchBtn">검색</button>

		</div>
	</div>
	<script>
		const getAjax = function(url, keyfield, keyword) {         		
	 		console.log(url, keyfield, keyword);
	 		return new Promise( (resolve, reject) => {
	     		$.ajax({
	     			url: url,
	     			method: 'GET',
	     			dataType: 'JSON',
	     			data: {
	     				keyfield: keyfield,
	     				keyword: keyword
	     			},
	     			async: true,
	     			success: function(data) {
	     				console.log("data_resolve 전 : ", keyfield);
	     				resolve(data);
	     				console.log("data_resolve 후 : ", keyword);
	     				
	     			},
	     			error: function (jqXhr, status, error) {
	     				alert(status + ':' + error + ':' + jqXhr.responseText);
	     			}
	     		});       
	 			
			});    
	 	}
		
		async function sendProcess(url, keyfield, keyword) {				
			try {
				const result = await getAjax(url, keyfield, keyword);
				console.log(result);
				var htmlStr ='';
				for (let i = 0; i < result.length; i++) {
					htmlStr += '<tr>';
					htmlStr += '<td>'+ result[i].articleNo +'</td>';
					htmlStr += '<td>'+ result[i].subject +'</a></td>';
					htmlStr += '<td>'+ result[i].nickname +'</td>';
					htmlStr += '<td>'+ result[i].writedate +'</td>';
					htmlStr += '<td>'+ result[i].viewcount +'</td>';
					htmlStr += '<td>'+ result[i].likecount  +'</td>';
				}
				console.log(htmlStr);
				$('#wetbody').html(htmlStr);
			}  catch(e) {
				console.log("error : ", e);
				alert("실패");
				
			}
			
		}
			
	     $(document).ready(function() {
      		$('#searchBtn').on('click', function() {
      			const keyfield = $('#keyfield option:selected').val();
      			const keyword = $('#keyword').val();
      			//console.log("keyfield : ",keyfield );
      			//console.log("keyword : ",keyword );
      			if (keyword.trim().length == 0) {
						alert("검색어를 정확히 입력하세요");
						return;
					}   			
      			
      			const url = "${pageContext.request.contextPath}/searchAjax.do?boardNo=${param.boardNo }";
      			
      			sendProcess(url, keyfield, keyword);        			
      			
      		});
      	});
		
	</script>
</body>
</html>