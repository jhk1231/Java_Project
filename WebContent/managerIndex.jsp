<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:forward page="/viewManagerTemplate.jsp">
	<jsp:param name="viewheader" value="${requestScope.viewheader }" />
	<jsp:param name="content" value="${requestScope.content }" />
</jsp:forward>
