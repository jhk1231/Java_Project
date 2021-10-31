<%-- 게시글 수정 --%>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.util.*, model.article.ArticleVo" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>    

<%
	// post방식이라 인코딩
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Content</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
<link href="./css/viewMainContent.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="content">
		<!-- Content 내용 여기에 추가 -->
		<table class="bbs" weidth="800" height="600" border="2" bgcolor="D8D8D8">
			<thead></thead>
			<tbody>
				<form action="${pageContext.request.contextPath }/modifyArticle" method="POST" enctype="multipart/form-data">
					<input type="hidden" name="articleNo" value="${param.articleNo }">
					<input type="hidden" name="boardNo" value="${param.boardNo }">
						<tr>
							<td>
							<div class="selectBoard">
								<select id="boardSelect" name="boardSelect">
									<option value="0">게시판선택</option>
									<option value="1">영장류</option>
									<option value="2">파충류</option>
									<option value="3">류</option>
								</select>
							</div>
						</td>
						<td colspan="2">
							<input type="submit" value="등록">
						</td>
					</tr>
					<br>
					<tr colspan="3">
						<td>
							<textarea id="subject" name="subject" cols="100" rows="5">${sessionScope.article.subject }</textarea>
						</td>
					</tr>
					<tr height="60">
						<td>
							<button type="button" class="btn_image" id="movieBtn"><img src="./video.png"></button>
						</td>
						<td>
							<button type="button" class="btn_image" id="imgBtn"><img src="./camera.jpg"></button>
						</td>
						<td>
							<input type="file" class="form-control" name="fileList" id="file" multiple style="font-size: 13px;">
						</td>
					</tr>
					<tr  colspan="3">
						<td>
							<form>
								<textarea id="content" name="content" cols="100" rows="10">${sessionScope.article.content }</textarea>
							</form>
						</td>
					</tr>
				</form>			
			</tbody>
		</table>
		<c:if test="${not empty sessionScope.articles.fileList }">
			<th>파일명</th><th>파일크기</th>
			<c:forEach var="file" items="${sessionScope.articles.fileList }">
				<td>${file.originalFileName }</td>
				<td>${file.fileSize } bytes</td>
			</c:forEach>
		</c:if>	
	</div>
</body>
</html>