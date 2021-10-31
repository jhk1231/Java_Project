<%-- 게시글 목록 보기 --%>


<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*, model.article.ArticleVo"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Content</title>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
<link href="./css/viewMainContent.css" rel="stylesheet" type="text/css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous">
</script>
<body>

	<div class="content">
		<!-- Content 내용 여기에 추가 -->
		<h1>${param.boardName }</h1>
		<table class="bbs" weidth="800" height="600" border="2"
			bgcolor="D8D8D8">
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
				<tr height="80">
					<th>No</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>좋아요</th>
				</tr>
			</thead>
			<tbody>
				<%-- 만약에 request영역에 바인딩된 자료가 비어 있는 경우 --%>
				<c:if test="${empty requestScope.searchArticle }">
					<tr>
						<td colspan="6">등록된 게시글이 없습니다.</td>
					</tr>
				</c:if>

				<c:if test="${not empty requestScope.searchArticle }">
					<c:forEach var="article" items="${requestScope.searchArticle }"
						varStatus="loop">
						<%-- 상세 조회 --%>
						<c:url var="detailArticleUrl" value="/viewDetailArticleContent.do">
							<c:param name="articleNo" value="${pageScope.article.articleNo }" />
							<c:param name="boardNo" value="${param.boardNo }" />
						</c:url>
						<tr>
							<td>${pageScope.article.articleNo }</td>
							<td><a href="${detailArticleUrl}">${pageScope.article.subject }</a></td>
							<td>${pageScope.article.nickname }</td>
							<td>${pageScope.article.writedate }</td>
							<td>${pageScope.article.viewcount }</td>
							<td>${pageScope.article.likecount }</td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>

		<%-- ***Pagging**** --%>
		<div id="pagging">
			<c:set var="pageBlock" value="${requestScope.pageBlock }"
				scope="page" />
			<c:set var="startPage" value="${requestScope.startPage }"
				scope="page" />
			<c:set var="endPage" value="${requestScope.endPage }" scope="page" />
			<c:set var="totalPage" value="${requestScope.totalPage }"
				scope="page" />
			<c:set var="currentPage" value="${param.currentPage }" scope="page" />

			<%-- 1블록을 제외한 모든 경우 --%>
			<c:if test="${startPage > pageBlock }">
				<c:url var="prevUrl" value="/viewListSearchArticleContent.do">
					<c:param name="currentPage" value="${startPage - pageBlock }" />
				</c:url>
				<a href="${prevUrl }">[Prev]</a>
			</c:if>
			<%-- page 숫자 출력 부분 --%>
			<c:forEach var="i" begin="${startPage }" end="${endPage }">
				<c:if test="${i == currentPage }">
					&nbsp;${i }&nbsp;
				</c:if>
				<%-- 현재 페이지가 아닌 애들 출력 , 만약에 그 page번호를 클릭한다면 자기 자신을 cuurentPage로 해서 /listArticle.do로 넘겨준다 --%>
				<c:if test="${i != currentPage }">
					<c:url var="movePageUrl" value="/viewListSearchArticleContent.do">
						<c:param name="currentPage" value="${i}" />
					</c:url>
					<a href="${movePageUrl}">&nbsp;${i}&nbsp;</a>
				</c:if>
			</c:forEach>
			<%-- 다음 페이지로 넘긴다. --%>
			<c:if test="${endPage < totalPage }">
				<c:url var="nextUrl" value="/viewListSearchArticleContent.do">
					<c:param name="currentPage" value="${endPage + 1 }" />
				</c:url>
				<a href="${nextUrl }">[Next]</a>
			</c:if>
		</div>
		<div id="search">
			<select id="keyfield" style="height: 30px;">
				<option value="subject">제목</option>
				<option value="writer">작성자</option>
			</select> <input type="search" placeholder="검색어를 입력하세요" size="30" id="keyword"
				style="height: 30px;">
			<button type="button" id="searchBtn" style="height: 30px;">검색</button>
		</div>
	</div>
	<script>
		const getAjax = function(url, keyfield, keyword) {         		
	 		
	 		return new Promise( (resolve, reject) => {
	     		$.ajax({
	     			url: url,
	     			method: 'GET',
	     			dataType: 'json',
	     			data: {
	     				keyfield: keyfield,
	     				keyword: keyword
	     			},
	     			async: true,
	     			success: function(data) {
	     				//console.log('data : ', data);
	     				resolve(data);
	     			},
	     			error: function(e) {
	     				//console.log('error : ', e);
	     				reject(e);
	     			}             			
	     		});       
	 			
			});    
	 	}       	
		     
		async function sendProcess(url, keyfield, keyword) {
			 var result = await getAjax(url, keyfield, keyword);
			 console.log(result);         		
		}
			
	     $(document).ready(function() {
      		$('#searchBtn').on('click', function() {
      			const keyfield = $('#keyfield option:selected').val();
      			const keyword = $('#keyword').val();
      			if (keyword.trim().length == 0) {
						alert("검색어를 정확히 입력하세요");
						return;
					}   			
      			
      			const url = 'searchAjax.do'
      			sendProcess(url, keyfield, keyword);        			
      			
      		});
      	});
		
	</script>
</body>
</html>