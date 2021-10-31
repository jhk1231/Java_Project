<%-- memberList.jsp --%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.member.MemberVo" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 목록 조회</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
<link href="css/viewMainContent.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
	<style>
			
			.head {
				background-color : #cccccc;
			}
			
			.lpage {
				font-size : 22px;
			}
			
			#member {
				width: 1250px;
			    border-collapse: collapse;
			    margin: 20px auto;   
			    font-size: 26px;     	
			}
			
			#member, tr, th, td{
				border : 1px solid black;
				text-align : center;
				vertical-align: middle;
			}
			
			#member th, td {
				height : 50px
			}
			
			a:hover {
				color : red;
			}
			
			a:active {
				color : green;
			}
			
			#paging {
				margin : 10px auto;
				text-align : center;
			}
			
			#search {
				height : 20px;
			 	text-align : center;
			}
	</style>
	
	<script>
	
	
	
	$(document).ready(function() {		
	
		
		$('#searchBtn').on('click', function() {
			const keyfield = $('#keyfield option:selected').val();
			const keyword = $('#keyword').val();
			
			if(keyword.trim() == "") {
				alert("검색어를 정확히 입력해주세요");
				return;
			}
			
			const url = "${pageContext.request.contextPath}/searchMember.do";
			sendProcess(url, keyfield, keyword);
			
		});
		
		// function 부분
		const getAjax = function(url, keyfield, keyword) {
			return new Promise((resolve, reject) => { /* resolve : 비동기 작업 완료 시, reject : 비동기 작업 거절 시  */
				// 처음 수행 시 pending 상태
				// 작업 수행 후 완료 시 fulfilled 상태, resolve 실행
				// 에러가 나면 rejected 상태, reject 실행
				
				$.ajax({
					url : url,
					method : "POST",
					dataType : "json",
					data : {
						keyfield : keyfield,
						keyword : keyword
					},
					async : true,
					success : function(data) {
						resolve(data);						
					},
					error : function(e)  {
						reject(e);
					}
				});
			});
		}

		
	// 비동기 작업 처리 함수
	async function sendProcess(url, keyfield, keyword) {				
		try {
			console.log(keyfield, keyword);
			const result = await getAjax(url, keyfield, keyword);
			console.log(result);
			$('.content   table  tbody').html('');
			var htmlStr = [];
			for (let i = 0; i < result.length; i++) {
				htmlStr.push('<tr id="'+ result[i].no +'">');
				htmlStr.push('<td>'+ result[i].no +'</td>');
				htmlStr.push('<td>'+ result[i].email +'</td>');
				htmlStr.push('<td>'+ result[i].grade +'</td>');
				htmlStr.push('<td>'+ result[i].regDate +'</td>');
				htmlStr.push('<td>'+ result[i].visits +'</td>');
				htmlStr.push('<td>'+ result[i].ban +'</td>');
				htmlStr.push('</tr>');
			}
			$('.content   table  tbody').html(htmlStr.join(""));
			
		}  catch(e) {
			console.trace();
			console.log("error : ", e);
		}
		
	}
		
	$('#member tbody').on('click', 'tr td:nth-child(2)', function() {
		//alert('call');
		const no = $(this).parent('tr').attr("id");
		console.log('no',  no);
		location.href = '${pageContext.request.contextPath}/viewDetailMember.do?no=' + no; 
	});

	});
	</script>
</head>


<body>
<div class="content">
<!-- 표 -->
	<table id="member">
		<thead class="head">
			<tr>
				<th>No</th>
				<th>ID</th>
				<th>등급</th>
				<th>가입 날짜</th>
				<th>방문 횟수</th>
				<th>비고</th>
			</tr>
		</thead>
		
		<tbody class="body">
			<c:forEach var="member" items="${members}" varStatus="loop">
				<c:url var="URL" value="/viewDetailMember.do">
					<c:param name="no" value="${member.no}"/>
				</c:url>
				<tr id="${member.no}">
					<td>${member.no}</td>
					<td><a href="${URL}" class="detail">${member.email}</a></td>
					<td>${member.grade}</td>
					<td>${member.regDate}</td>
					<td>${member.visits}</td>
					<td>${member.ban}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- 페이징 처리 -->
	<div id="paging">
		<c:set var="pageBlock" value="${pageBlock}" scope="page"/>
		<c:set var="startPage" value="${startPage}" scope="page"/>
		<c:set var="endPage" value="${endPage}" scope="page"/>
		<c:set var="currentPage" value="${currentPage}" scope="page"/>
		<c:set var="totalPage" value="${totalPage}" scope="page"/>
		
		<!-- 이전 페이지 블록 -->
		<c:if test="${startPage > pageBlock}">
			<c:url var="prevUrl" value="/viewMemberList.do">
				<c:param name="currentPage" value="${startPage - pageBlock}"/>
			</c:url>
			<a href="${prevUrl}" class="lpage">이전</a>
		</c:if>
		
		<!-- 현재 페이지 블록 -->
		<c:forEach var="i" begin="${startPage}" end="${endPage}">
			<c:if test="${i == currentPage}">
				&nbsp;${i}&nbsp;
			</c:if>
			
			<c:if test="${i != currentPage}">
				<c:url var="url" value="/viewMemberList.do">
					<c:param name="currentPage" value="${i}"/>
				</c:url>
				<a href="${url}" class="lpage">&nbsp;${i}&nbsp;</a>
			</c:if>
		</c:forEach>
		
		<!-- 다음 페이지 블록 -->
		<c:if test="${endPage < totalPage}">
			<c:url var="nextUrl" value="/viewMemberList.do">
				<c:param name="currentPage" value="${endPage + 1}"/>
			</c:url>
			<a href="${nextUrl}" class="lpage">[Next]</a>
		</c:if>
	</div>
	
	<!-- 검색창 -->
	<div id="search">
		<select id="keyfield">
			<option value="email">ID</option>
			<option value="grade_no">등급</option>
		</select>
		<input type="text" id="keyword">
		<button type="button" id="searchBtn">검색</button>
	</div>
</div>
</body>
</html>