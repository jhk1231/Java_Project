
<%@ page contentType="text/plain; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>



{
	"isSuccess" : "${requestScope.isSuccess}",

	<c:if test="${requestScope.isSuccess eq 1}">
		 "code" : "${requestScope.code}",
		 "memberNo" : ${requestScope.member.no}
	</c:if>
	<c:if test="${requestScope.isSuccess ne 1}">
		"failText" : "${requestScope.failText}"
	</c:if>

}