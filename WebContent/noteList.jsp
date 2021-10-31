<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<link href="./css/viewNoteList.css" rel="stylesheet" type="text/css">
</head>
<body>

	<div class="note-header-style">
		<span
			onclick="location.href='${pageContext.request.contextPath}/noteList.do?isRecieve=1'">받은쪽지함</span>
		<span
			onclick="location.href='${pageContext.request.contextPath}/noteList.do?isRecieve=0'">보낸쪽지함</span>
	</div>
	<table class="note-table-style">
		<thead>
			<tr class="note-table-tr-style">
				<th>번호</th>
				<c:if test="${ param.isRecieve == 1}">
					<th>보낸사람</th>
				</c:if>
				<c:if test="${ param.isRecieve == 0}">
					<th>받은사람</th>
				</c:if>
				<th>내용</th>
				<th>보낸날짜</th>
				<th>읽은날짜</th>
				<!-- <th>선택</th> -->
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty requestScope.NoteList}">
				<tr>
					<td colspan="4">받은 쪽지가 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${not empty requestScope.NoteList}">

				<c:forEach var="note" items="${requestScope.NoteList }"
					varStatus="loop">
					<c:url var="url" value="/noteDetailBoard.do">
						<c:param name="isRecieve" value="${ param.isRecieve }" />
						<c:param name="no" value="${pageScope.note.note_no}" />
					</c:url>
					<tr  class="note-table-tr-style">
						<%-- <td>${requestScope.totalPostCount - (param.currentPage -1) * requestScope.postSize - loop.index }</td>--%>
						<td>${fn:length(requestScope.NoteList) - pageScope.loop.count + 1 }</td>
						<!-- 번호 -->
						<td>${note.counterpart_nickname }</td>
						<td><a href="${pageScope.url}">${note.content}</a></td>
						<td>${note.sendDate }</td>
						<c:if test="${ note.read }">
							<td>${note.readDate }</td>
						</c:if>
						<c:if test="${ note.read == false }">
							<td>읽지않음</td>
						</c:if>

						<%-- <td><input type="checkbox" name="deleteNote" value="${ note.note_no }"></td> --%>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
	<!-- <button type = "button" id = "delete">삭제</button> -->

	<c:set var="pageBlock" value="${requestScope.pageBlock }" scope="page" />
	<c:set var="startPage" value="${requestScope.startPage }" scope="page" />
	<c:set var="endPage" value="${requestScope.endPage }" scope="page" />
	<c:set var="totalPage" value="${requestScope.totalPage }" scope="page" />
	<c:set var="currentPage" value="${param.currentPage }" scope="page" />

	<%-- <p>스타트 페이지 : ${ pageScope.startPage }</p>
	<p>엔드 페이지 : ${ pageScope.endPage }</p> --%>
	<c:if test="${startPage > pageBlock }">
		<c:url var="prevUrl" value="/noteList.do">
			<c:param name="isRecieve" value="${ param.isRecieve }" />
			<c:param name="currentPage" value="${startPage - pageBlock}"></c:param>
		</c:url>
		<a href="${ prevUrl}">[PREV]</a>
	</c:if>
	page
	<c:forEach var="i" begin="${startPage }" end="${endPage }">
		<c:if test="${ i == currentPage }">
			${ i }
		</c:if>
		<c:if test="${ i != currentPage }">
			<c:url var="url" value="/noteList.do">
				<c:param name="isRecieve" value="${ param.isRecieve }" />
				<c:param name="currentPage" value="${i}"></c:param>
			</c:url>
			<a href="${url}">${ i }</a>
		</c:if>
	</c:forEach>
	<c:if test="${endPage < totalPage }">
		<c:url var="nextUrl" value="/noteList.do">
			<c:param name="isRecieve" value="${ param.isRecieve }" />
			<c:param name="currentPage" value="${endPage + 1}"></c:param>
		</c:url>
		<a href="${nextUrl }">[NEXT]</a>
	</c:if>

	<script>
		/* $('#delete').on('click', function() {	
			let chk_arr = [];

			$("input[name=deleteNote]:checked").each(function() {
				var chk = $(this).val();
				chk_arr.push(chk);
				console.log(chk);
			}); 
		}); */
	</script>
</body>
</html>