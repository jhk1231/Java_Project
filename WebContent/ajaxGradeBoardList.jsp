<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.grade.GradeVo" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


[
<c:forEach var="map" items="${boards}" varStatus="status">
{
	"field" : "${map.key}"
	<c:forEach var="item" items="${map.key}">
		"board" : "${boards[item].value}"
	</c:forEach>
</c:forEach>
}
	<c:if test="${fn:length(boards) - status.index > 1}">
		,
	</c:if>
]