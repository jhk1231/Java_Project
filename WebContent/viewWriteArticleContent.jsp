<%-- 게시글 작성 --%>

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

</style>
</head>
<body>
	<div class="content">
		<!-- Content 내용 여기에 추가 -->
		<p class="pageName">게시글 작성</p>
		<table class="writeForm">
			<thead>
			</thead>
			<tbody>
				<div class="writeForm">
					<form action="${pageContext.request.contextPath }/uploadFile"
						method="POST" enctype="multipart/form-data">
						<input type="hidden" name="boardNo" value="${param.boardNo }"/>
						<tr>
							<td>
								<%-- 게시판 선택 --%>
								<div class="selectBoard">
									<select id="boardSelect" name="boardSelect">
										<option value="0">게시판선택</option>
										<c:forEach var="board" items="${requestScope.boardList}">
											<option value="${board.boardNo}">${board.boardName }</option>
										</c:forEach>
									</select>
								</div>
							</td>
							<td>
							<button type="submit" class="btn btn-sm btn-primary"
								id="wrtieBtn">등록</button>
							</td>						
						</tr>
						<br>
						<tr colspan="3">
							<td><textarea class="form-control" id="subject"
									name="subject" cols="100" rows="5" placeholder="제목을 입력해 주세요"></textarea></td>
						</tr>
						<tr height="60">
							<td><input type="file" class="form-control" name="fileList"
								id="file" multiple style="font-size: 13px;">
							</td>
						</tr>
						<tr colspan="3">
							<td>
								<div class="wa-3">
									<label for="content"></label>
									<textarea class="form-control" id="content" name="content"
										cols="100" rows="10" placeholder="내용을 입력해 주세요"></textarea>
								</div>
							</td>
						</tr>
					</form>
				</div>
			</tbody>
		</table>
	</div>
</body>
</html>