
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3> Error : </h3>
	<c:forEach var = "stack" items="${requestScope.exception.stackTrace}">
	${stack}<br>
	</c:forEach>
</body>
</html>