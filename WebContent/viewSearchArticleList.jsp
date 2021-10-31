
<%@ page contentType="text/plain; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


[
	<c:forEach var="article" items="${requestScope.searchArticle}" varStatus="status">
		{
			"articleNo" : ${article.articleNo},
			"subject" : "${article.subject}",
			"nickname" : "${article.nickname}",
			"writedate" : "${article.writedate}",
			"viewcount" : ${article.viewcount},
			"likecount" : ${article.likecount} 

		}
		
		<c:if test="${fn:length(requestScope.searchArticle) - status.index > 1}">
			,
		</c:if>
	</c:forEach>
] 