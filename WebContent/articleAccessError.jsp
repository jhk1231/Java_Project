<%@ page import="java.util.*, model.article.ArticleVo"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Content</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
<link href="./css/viewMainContent.css" rel="stylesheet" type="text/css">
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

.content {
width : 100%;
height : 100%;
}

.--center {
	margin : 0 auto;
}

.forcenter {
	display:inline-block;
	text-align:center;
	width:50%;
	height : 20px;
}
</style>
<body>
	<div class="content">
		<!-- Content 내용 여기에 추가 -->
		<div class = "--center">
		<h1 class = "logo forcenter">PETOPIA</h1><br><br><br>
		<h1 class = "forcenter">해당 게시판 열람이 불가능한 등급입니다.</h1>
		</div>
		
		
	</div>
</body>
</html>