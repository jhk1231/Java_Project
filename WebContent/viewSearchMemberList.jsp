
<%@ page contentType="text/plain; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

[
	<c:forEach var="member" items="${requestScope.searchMembers}" varStatus="status">
		{
			"no" : ${member.no},
			"email" : "${member.email}",
			"grade" : "${member.grade}",
			"regDate" : "${member.regDate}",
			"visits" : ${member.visits},
			"ban" : "${member.ban}"
		}
	
	<c:if test="${fn:length(searchMembers) - status.index > 1}">
		,
	</c:if>
	</c:forEach>
]