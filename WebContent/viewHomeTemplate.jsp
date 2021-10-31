
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<c:set var = "side" value = "${requestScope.side }"/> 
<c:set var = "content" value = "${requestScope.content }"/> 


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>반려동물 카페</title>
<link href="css/viewFrameMain.css" rel="stylesheet"
	type="text/css">
</head>
<body>
	<div class="inner">
		<!-- header include -->
		<jsp:include page="/viewFrameHeader.jsp" />
		<div class="main">
			<jsp:include page="${side}" flush="false" />
			<jsp:include page="${content}" flush="false" />
		</div>
		<jsp:include page="/viewFrameFooter.jsp" />
	</div>
</body>
</html>
