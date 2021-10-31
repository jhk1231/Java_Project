
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	
	.float {
	width : 300px
	
	
	}
	
	.btns, .list {
		float : left;
		width : 350px;
		padding-left: 50px;
	}
	
	.addBtn {
		width: 100px;
		margin-left: 270px;
	}
	
	.categoryInManager {
		width : 300px;
		background-color:silver;
		padding-left: 20px;
	}
	.boardInCategory {
		width : 300px;
		background-color:white;
		padding-left: 30px;
	}
	
	.modifyBtn {
		float: right;
		margin-right: 50px;
	}
	
	.writeBtn {
		float: right;
		margin-right: 50px;
	}



</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"></script>
<script type="text/javascript"></script>


	<%-- 1. 카테고리 이름 중복 검사 --%>
    <%-- 2. 카테고리 내 게시판 유무 검사 --%>
    <%-- 3. 게시판 이름 중복 검사 --%>
	<%-- 4. 게시판 내 게시글 유무 검사 --%>
    <script>
    $(document).ready(function() { //유효성체크 : jsp, jquery
    
    
        	//카테고리 추가
        	$('#addCategoryBtn').on("click", function() {
        		$('#rightModifyCategory').hide();
        		$('#rightWriteBoard').hide();
        		$('#rightModifyBoard').hide();
        		
        		$('#rightWriteCategory').appendTo('#rightBlank');
        		$('#rightWriteCategory').show(); 
        	});
        	
        	//카테고리 추가 공백 검사        	
        	$('#writeCategoryBtn').on("click", function() {
            	const categoryName = $('#categoryName').val();
                if (categoryName == "") {
                    alert("이름이 비어 있습니다.");
                    return false;
                } else {
                    $('#writeCategory').submit();
                }
            });
        	
        	//카테고리 수정
        	$('.category  a').on('click', function(e) {
        		e.preventDefault();
        		console.log($(this).attr('href'));
        		console.log($(this).attr('id'));
        		
        		$('#rightWriteCategory').hide(); 
        		$('#rightWriteBoard').hide();
        		$('#rightModifyBoard').hide();
        		
        		$('#removeCategoryBtn').attr("name", $(this).attr('id'));
        		$('#rightModifyCategory #categoryName').val($(this).attr('href'));
        		$('#rightModifyCategory #categoryNo').val($(this).attr('id'));
        		$('#rightModifyCategory').appendTo('#rightBlank');
        		$('#rightModifyCategory').show();
        	});
        	
        	//카테고리 수정 공백 검사
        	$('#modifyCategoryBtn').on("click", function() {
            	const categoryName = $('#categoryName').val();
            	console.log("categoryName " + categoryName);
                if (categoryName == "") {
                    alert("이름이 비어 있습니다.");
                    return false;
                } else {
                    $('#modifyCategory').submit();
                }
            });
        	
        	//카테고리 삭제
        	$('#removeCategoryBtn').on('click', function() {    
            	console.log("카테고리 삭제버튼 클릭1");
        		
        		const categoryNo = $(this).attr("name");
        		console.log(categoryNo);
        		requestProcessCategory('${pageContext.request.contextPath}/removeCategory.do', categoryNo);   
            });
        	
        	const getRemoveCategoryAjax = function(url, categoryNo) {
                // resolve, reject는 자바스크립트에서 지원하는 콜백 함수이다.
                return new Promise( (resolve, reject) => { 
                    $.ajax({        
                    	
                        url: url,
                        method: 'POST',
                        dataType: 'json',
                        async : false,
                        data: {
                        	categoryNo: categoryNo,	
                        },
                        
                        success: function(data) {  
                            resolve(data);
                        }, 
                        error: function(e) {          	
                            reject(e);
                        }
                    });
                });
            }   
            
            async function requestProcessCategory(url, categoryNo) {
            	alert("카테고리를 삭제하시겠습니까?");
            	try {
                    const result = await getRemoveCategoryAjax(url, categoryNo); 
                    console.log(result)            
                    
               		if (result.connectBoardResult == 1) { //게시글 있는 경우
               			alert("게시판이 있는 카테고리는 삭제가 불가능합니다.");
                	} else { //게시글 없는 경우
                		alert('카테고리가 삭제되었습니다.');
                		location.href = "${pageContext.request.contextPath}/listCategory.do";	
                	}
               		
               } catch (error) {
                    console.log("error : ", error);   
                }
            }
            

        	//게시판 추가
        	$('#addBoardBtn').on("click", function() {
        		$('#rightWriteCategory').hide();
        		$('#rightModifyCategory').hide();
        		$('#rightModifyBoard').hide();
        		
        		$('#rightWriteBoard').appendTo('#rightBlank');
        		$('#rightWriteBoard').show();       		     		
        	});
        	
        	//게시판 추가 공백 검사
        	$('#writeBoardBtn').on("click", function() {
            	const boardName = $('#boardName').val();
                const readGrade = $('#readGrade > option:selected').val();
                const writeGrade = $('#writeGrade > option:selected').val();
                if (boardName == "") {
                    alert("이름이 비어 있습니다.");
                    return false;
                } else {
                    $('#writeBoard').submit(); //다 통과되었으면 submit()
                }
            });
        	
        	//게시판 수정
        	$('.board  a').on('click', function(e) {
        		e.preventDefault();
        		console.log($(this).attr('href'));
        		console.log($(this).attr('id'));
        		
        		$('#removeBoardBtn').attr("name", $(this).attr('id'));
        		$('#rightWriteCategory').hide(); 
        		$('#rightModifyCategory').hide();
        		$('#rightWriteBoard').hide();
        		
        		//$('div').attr('id'); -> div 요소의 id 속성의 값을 가져옴
        		$('#rightModifyBoard #boardName').val($(this).attr('href'));
        		$('#rightModifyBoard #boardNo').val($(this).attr('id'));
        		$('#rightModifyBoard').appendTo('#rightBlank');
        		$('#rightModifyBoard').show();
        	});
        	
        	//게시판 수정 공백 검사
        	$('#modifyBoardBtn').on("click", function() {
            	const boardName = $('#boardName').val();
            	const readGrade = $('#readGrade').val();
            	const writeGrade = $('#writeGrade').val();
                if (boardName == "") {
                    alert("이름이 비어 있습니다.");
                    return false;
                } else {
                    $('#modifyBoard').submit();
                }
            });
        	
        	//게시판 삭제
        	//클릭이벤트 발생 시 브라우저에 입력된 값을 받아오는 것
            $('#removeBoardBtn').on('click', function() {    
            	console.log("게시판 삭제버튼 클릭");
        		
        		const boardNo = $(this).attr("name");
        		console.log(boardNo);
        		requestProcessBoard('${pageContext.request.contextPath}/removeBoard.do', boardNo);   
            });
        	
        	
        	const getRemoveBoardAjax = function(url, boardNo) {
                return new Promise( (resolve, reject) => {  
                    $.ajax({  
                    	
                        url: url,
                        method: 'POST',
                        dataType: 'json',
                        async    : false,
                        data: {
                        	boardNo: boardNo,
                        },
                        
                        success: function(data) {
                            resolve(data);
                        }, 
                        error: function(e) {         	
                            reject(e);
                        }
                    });
                });
            }   
            
            async function requestProcessBoard(url, boardNo) { 
            	alert("게시판을 삭제하시겠습니까?");
            	try {
                    const result = await getRemoveBoardAjax(url, boardNo); 
                    		
                    console.log(result)            
                    
               		if (result.connectArticleResult == 1) { //게시글 있는 경우
               			alert("게시글이 있는 게시판은 삭제가 불가능합니다.");
                	} else { //게시글 없는 경우
                		alert('게시판이 삭제되었습니다.');
                		location.href = "${pageContext.request.contextPath}/listCategory.do";	
                	}
               		
               } catch (error) {
                    console.log("error : ", error);   
                }
            }
            
        	
        });
    </script>
</head>


<body>
<%-- 카테고리 추가, 게시판 추가, 베스트 글 관리 버튼 --%>
<div class = "btns">
	<div>
		<button type="button" class="addBtn" id="addCategoryBtn">카테고리 추가</button>
	</div>
	
	
	<div>
		<button type="button" class="addBtn" id="addBoardBtn">게시판 추가</button>
	</div>
</div>


<%-- 카테고리+게시판 목록 조회 ------------------------------------------------------------------------------- --%>
<div class = "list" id = "list">
<table>
	<tbody id="ManagetCategoryAndBoardList">
		<c:if test="${empty requestScope.categoryList}">
			<tr><td>등록된 게시판이 없습니다.</td></tr>
		</c:if>
		<c:if test="${not empty requestScope.categoryList}">			
			<c:forEach var="category" items="${requestScope.categoryList}" varStatus="loop"> <%-- items의 이름이 category, Dao에서 만든 categoryList를 여기서 씀 --%>
		
				<c:url var="url" value="/modifyCategory.do"> <%-- 카테고리 수정.do --%>
				<c:param name="categoryNo" value="${pageScope.category.categoryNo}" /> <%-- 위의 url로 보낼 때 포함시킬 파라미터. Dao에서 이름 갖고 올 때 categoryNo 같이 가져오기 (while문 확인) --%>
				</c:url>
				 
				<tr class="category">
					<td class="categoryInManager"><a href="${pageScope.category.categoryName}" id="${pageScope.category.categoryNo}">${pageScope.category.categoryName}</a></td>	
				</tr>
				
				<c:forEach var="board" items="${pageScope.category.boardList }"> <%-- items의 category == 첫번째forEach의 var와 같은 것.  --%>
					
					<c:url var="url" value="/modifyBoard.do"> <%-- 게시판 수정.do --%>
					<c:param name="boardNo" value="${pageScope.board.boardNo}" /> <%-- 위의 url로 보낼 때 포함시킬 파라미터 --%>
					<c:param name="categoryNo" value="${pageScope.category.categoryNo}" /> <%-- 게시판 추가 할 때 사용 --%>
					</c:url>
					
					<tr class="board">
					<td class="boardInCategory"><a href="${pageScope.board.boardName}" id="${pageScope.board.boardNo}">${pageScope.board.boardName}</a></td>
					</tr>
				</c:forEach>
			</c:forEach>
		</c:if>		
	</tbody>
</table>
</div>

<%-- 작성/수정 페이지 : div를 변경하는 ajax를 사용 --%>
<%-- 0. 관리자 페이지 들어왔을 때, 카테고리/게시판 추가 수정 삭제 후 보여질 페이지. 수정페이지와 동일한 크기의 네모박스만 있고 내용은 없음 --------------- --%>
	<div class = "float" id = "rightBlank">
	</div>

	<%-- 1. 카테고리 작성 폼 ------------------------------------------------------------------------- --%>
	<div class = "float"  id = "rightWriteCategory" style="display:none;">
	<form action="${pageContext.request.contextPath}/writeCategory.do" method="POST" id="writeCategory">
		<div>
			<label for="categoryName">카테고리명</label>
			<input type="text" name = "categoryName" id="categoryName" placeholder="이름을 작성하세요.">
		</div>
		
		<div class="writeBtn">
			<button type="reset">취소</button>
			<button type="button" id="writeCategoryBtn">저장</button>
		</div>
	</form>
	</div>
	
	<%-- 2. 카테고리 수정 폼 ------------------------------------------------------------------------- --%>
	<div class = "float"  id = "rightModifyCategory"  style="display:none;">
	<form action="${pageContext.request.contextPath}/modifyCategory.do" method="POST" id="modifyCategory">
		<div>
			<label for="categoryName">카테고리명</label>
			<input type="text" name = "categoryName" id="categoryName" value="${sessionScope.category.categoryName }">
			<input type="hidden" name = "categoryNo" id="categoryNo" value="${sessionScope.category.categoryNo }">
		</div>		
		<div class="modifyBtn">	
			<button type="button" id="removeCategoryBtn" name="" >삭제</button>			
			<button type="reset">취소</button>
			<button type="button" id="modifyCategoryBtn">저장</button>
		</div>
	</form>
	</div>

 <%--varStatus="loop">  --%> 
	<%-- 3. 게시판 작성 폼 -------------------------------------------------------------------------  --%>
	<div class = "float"  id = "rightWriteBoard" style="display:none;">
	<form action="${pageContext.request.contextPath}/writeBoard.do" method="POST" id="writeBoard">
		
		<div>
		<c:if test="${not empty requestScope.categoryList}" >
			<label for="categoryNameForBoard">카테고리 선택</label>
			<select name="categoryNameForBoard" id="categoryNameForBoard">
			<c:forEach var="categoryListForBoard" items="${requestScope.categoryList}"> <%-- java의 forEach(int i: list) -> jsp의<c:forEach  var => i / items => list --%>
				<option value="${categoryListForBoard.categoryNo}">${categoryListForBoard.categoryName}</option> 
			</c:forEach>			
			</select>
		</c:if>
		</div>
		
		<div>
			<label for="boardName">게시판명</label>
			<input type="text" name = "boardName" id="boardName" placeholder="이름을 작성하세요.">
			<input type="hidden" name = "categoryNo" id="categoryNo" value="${sessionScope.category.categoryNo }">
			${sessionScope.category.categoryNo }
		</div>
		
		<div>
		<c:if test="${not empty requestScope.grades}" >
			<label for="readGrade">게시글 읽기 권한</label>
			<select name="readGrade" id="readGrade">
			<c:forEach var="gradeListForBoard" items="${requestScope.grades}"> 
				<option value="${gradeListForBoard.gradeNo}">${gradeListForBoard.name}</option> 
			</c:forEach>			
			</select>
		</c:if>
		</div>
		 
		<div>
		<c:if test="${not empty requestScope.grades}" >
			<label for="writeGrade">게시글 쓰기 권한</label>
			<select name="writeGrade" id="writeGrade">
			<c:forEach var="gradeListForBoard" items="${requestScope.grades}"> 
				<option value="${gradeListForBoard.gradeNo}">${gradeListForBoard.name}</option> 
			</c:forEach>			
			</select>
		</c:if>
		</div>
		
		<div class="writeBtn">
			<button type="reset">취소</button>
			<button type="button" id="writeBoardBtn">저장</button>
		</div>
	</form>
	</div>
	
	<%-- 4. 게시판 수정 폼  ------------------------------------------------------------------------- --%>
	<div class="float"  id="rightModifyBoard" style="display:none;">
	<form action="${pageContext.request.contextPath}/modifyBoard.do" method="POST" id="modifyBoard">
	
	
	<div>
		<c:if test="${not empty requestScope.categoryList}" >
			<label for="categoryNameForBoard">카테고리 선택</label>
			<select name="categoryNameForBoard" id="categoryNameForBoard">
			<c:forEach var="categoryListForBoard" items="${requestScope.categoryList}"> <%-- java의 forEach(int i: list) -> jsp의<c:forEach  var => i / items => list --%>
				<%-- 현재 설정된 카테고리 띄우기 : https://bluemint.tistory.com/16 --%>
				<option value="${categoryListForBoard.categoryNo}" 
					<c:if test="${sessionScope.board.categoryNo }">selected="seleted"</c:if>
				>${categoryListForBoard.categoryName}</option> 
			</c:forEach>			
			</select>
		</c:if>
	</div>
		
		
		
		
		
		<div>
			<label for="boardName">게시판명</label>
			<input type="text" name = "boardName" id="boardName" value="${sessionScope.board.boardName }"> <%-- boardName을 board에 잘넣었나 확인좀 --%>
			<input type="hidden" name = "boardNo" id="boardNo" value="${sessionScope.board.boardNo }">
			<!-- 
			<input type="hidden" name = "bordReadGrade" id="bordReadGrade" value="${sessionScope.board.bordReadGrade }">
			<input type="hidden" name = "boardWriteGrade" id="boardWriteGrade" value="${sessionScope.board.boardWriteGrade }">
			 -->
		</div>
		
		<div>
		<c:if test="${not empty requestScope.grades}" >
			<label for="readGrade">게시글 읽기 권한</label>
			<select name="readGrade" id="readGrade">
			<c:forEach var="gradeListForBoard" items="${requestScope.grades}"> 
				<option value="${gradeListForBoard.gradeNo}">${gradeListForBoard.name}</option> 
			</c:forEach>			
			</select>
		</c:if>
		</div>
		 
		<div>
		<c:if test="${not empty requestScope.grades}" >
			<label for="writeGrade">게시글 쓰기 권한</label>
			<select name="writeGrade" id="writeGrade">
			<c:forEach var="gradeListForBoard" items="${requestScope.grades}"> 
				<option value="${gradeListForBoard.gradeNo}">${gradeListForBoard.name}</option> 
			</c:forEach>			
			</select>
		</c:if>
		</div>
		
		<div class="modifyBtn">
			<button type="button" id="removeBoardBtn" name="">삭제</button>			
			<button type="reset">취소</button>
			<button type="button" id="modifyBoardBtn">저장</button>
		</div>
	</form>
	</div>
</body>
</html>