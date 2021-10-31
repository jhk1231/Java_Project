<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>반려동물 카페</title>
<link href="/css/viewFrameMain.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="inner">
		<!-- header include -->
		<jsp:include page="viewFrameHeader.jsp" />
		<div class="main">
			<jsp:include page="viewFrameSidebar.jsp" />
			<jsp:include page="viewFrameContent.jsp" />
		</div>
		<jsp:include page="viewFrameFooter.jsp" />
	</div>
</body>
</html>