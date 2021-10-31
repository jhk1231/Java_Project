<%@ page contentType="text/plain; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>



[
	<c:forEach var="reply" items="${requestScope.replyList }" varStatus="status">
		{
			"replyNo": ${reply.replyNo },
			"articleNo": "${reply.articleNo }",
			"memberNo": "${reply.memberNo }",
			"nickname" : "${reply.nickname}",
			"writedate": "${reply.writedate }",
			"content": "${reply.content }"
		}
			
		<c:if test="${fn:length(requestScope.replyList) - status.index > 1}"> 
				,
		</c:if>
	</c:forEach>
]

