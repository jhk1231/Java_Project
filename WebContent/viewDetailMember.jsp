<%-- viewDetailMember.jsp --%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.member.MemberVo" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 상세 조회</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/reset-css@5.0.1/reset.min.css">
<link href="css/viewMainContent.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
	
	<style>
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
				height : 50px;
			}
			
			#drop {
				height : 30px;
				width :  70px;
				vertical-align : middle;
			}
			
			.btn {
				font-size : 14px;
				float : right;
			}
			
			.title {
				background-color : #cccccc;
				width : 450px;
			}
			
			.val {
				width : 750px;
			}
			
			.content-header {
			   width: 100%;
			   display: flex;
			   justify-content: space-between;
			}
			
			.content-header>h2 {
				margin-bottom: 30px;
			   border: 2px solid #666;
			   width: 10%;
			   flex-basis: auto;
			   padding: 10px;
			   text-align: center;
			   
			}
			.content-header>button {
				height: 30px;
			}
	</style>
</head>
<body>
<div class="content">
	<c:url var="listUrl" value="/viewMemberList.do"/>
	<div class="content-header"><h2>회원 정보 수정</h2><button onclick="history.back()" class="btn" id="back">Back</button></div>
	<br/>
	<br/>
	
	<!-- 표 -->
	<form action="modifyBan.do" method="POST">
	<table border = "1" id="member">
		<tr>
			<td class="title">ID</td>
			<td class="val">${member.email}</td>
			<td class="title">등급</td>
			<td class="val">${member.grade}</td>
		</tr>
		
		<tr>
			<td class="title">닉네임</td>
			<td class="val">${member.nickname}</td>
			<td class="title">게시글 수</td>
			<td class="val">${member.docs}</td>
		</tr>
		
		<tr>
			<td class="title">가입 날짜</td>
			<td class="val">${member.regDate}</td>
			<td class="title">댓글 수</td>
			<td class="val">${member.comms}</td>
		</tr>
		
		<tr>
			<td class="title">최근 방문 날짜</td>
			<td class="val">${member.lastDate}</td>
			<td class="title">방문 횟수</td>
			<td class="val">${member.visits}</td>
		</tr>
		
		<tr>
			<td class="title">탈퇴 여부</td>
			<td class="val">${member.isMember}</td>
			<td class="title">활동 중지</td>
			<td class="val">
				${member.ban}
				<select name="banSelect" id="drop">
					<option value="7d">7일</option>
					<option value="1d">1일</option>
					<option value="1m">1분</option>
				</select>
			</td>
		</tr>
	</table>
	<br/>
	<input type="hidden" name="no" value="${member.no}">
	<button type="submit" class="btn" id="saveBtn">저장</button>
	</form>
	<br/>
	<br/>
	<form action="outMemberByForce.do" method="POST"  onsubmit="return confirm('정말로 탈퇴하시겠습니까?');">
		<input type="hidden" name="no" value="${member.no}">
		<button type="submit" class="btn" id="outBtn">회원 탈퇴</button>	
	</form>
</div>
</body>
</html>