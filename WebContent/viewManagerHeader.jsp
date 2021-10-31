<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Header</title>
<link href="css/viewManagerHeader.css" rel="stylesheet"
	type="text/css">
</head>
<body>
	<header>
		<div class="header-tab">
			<span>카페 관리</span>
		</div>
		<div class="header-table">
			<table>
				<tr>
					<td onclick="location.href='${pageContext.request.contextPath}/viewMemberList.do'">회원 관리</td>
					<td onclick="location.href='${pageContext.request.contextPath}/viewGradeList.do'">등급 관리</td>
					<td onclick="location.href='${pageContext.request.contextPath}/listCategory.do'">
					게시글 관리</td>
					<td>꾸미기</td>
					<td onclick="location.href='${pageContext.request.contextPath}/managerStatisticsDaily.do'">통계</td>
				</tr>
			</table>
		</div>

	</header>
</body>
</html>