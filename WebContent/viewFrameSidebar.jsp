<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>    
	
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>애완동물 카페</title>
<link href="./css/viewFrameSidebar.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="sidebar">
		<article class="sidebar-profile">
			<section class="sidebar-profile-firstSection">
				<div class="firstSection-inner">
					<!-- 프로필 수정 화면으로 이동 -->
					<input type="image" src="./img/profile.jpg" alt="Profile">
					
					<div class="firstSection-inner-profileInfo">
						<div>
						
							<a href="#">${sessionScope.user.nickname }</a> <a href="${pageContext.request.contextPath}/viewMemberList.do">${sessionScope.user.grade }</a>
						</div>
						<div class="span-right">
							<div class="div-span-flex">
								<span class="span-block">방문횟수 : </span> <span>${sessionScope.user.visits } 회</span>
							</div>
							<div class="div-span-flex">
								<span class="span-block">작성 글 : </span> <span>${sessionScope.user.docs } 개</span>
							</div>
							<div class="div-span-flex">
								<span class="span-block">작성 댓글 : </span> <span>${sessionScope.user.comms } 개</span>
							</div>

						</div>
					</div>
				</div>
				<div class="lastSection-inner">
					<a href="${pageContext.request.contextPath}/resetPassword.jsp"> <span>비밀번호 변경</span>
					</a> <a href="${pageContext.request.contextPath}/logout.do"> <span>로그아웃</span>
					</a>
				</div>
			</section>
		</article>
		<article class="sidebar-btn">
			<section>
				<span onclick="location.href='${pageContext.request.contextPath}/out.jsp'">회원탈퇴</span>
				<span onclick="location.href='${pageContext.request.contextPath}/noteList.do?isRecieve=1'">쪽지함</span>
			</section>
			<section>
				<span onclick="location.href='${pageContext.request.contextPath}/viewWriteArticleForm.do'">카페 글쓰기</span> 
				<span onclick="location.href='${pageContext.request.contextPath}/viewListArticleContent.do'">전체 글 보기</span>
			</section>
		</article>
		<article class="sidebar-list">
		
		
	
		<table class="sidebar-category-table">
		<tbody>
			<%-- sideListCategory --%>
	
		<c:if test="${empty requestScope.categoryList}">
			<tr><td>등록된 게시판이 없습니다.</td></tr>
		</c:if>
		<c:if test="${not empty requestScope.categoryList}">			
			<c:forEach var="category" items="${requestScope.categoryList}" varStatus="loop">
				<tr id=category>
					<td>${pageScope.category.categoryName}</td>	
				</tr>
				
				<c:if test="${not empty pageScope.category.boardList}">
				<c:forEach var="board" items="${pageScope.category.boardList }">
					<c:url var="url" value="/viewListArticleContent.do"> <%-- 게시판별 게시글 목록 조회.do --%>
						<c:param name="boardNo" value="${pageScope.board.boardNo}" />
						<c:param name="boardName" value="${pageScope.board.boardName }"/>
					</c:url>
					
					<tr id=board>
						<td>ㄴ<a href="${pageScope.url}">${pageScope.board.boardName}</a></td>
					</tr>
					
				</c:forEach>
				</c:if>
			</c:forEach>
		</c:if>	
	</tbody>
	</table>
			
		</article>
	</div>
</body>
</html>