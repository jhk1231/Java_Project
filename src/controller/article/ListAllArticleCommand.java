package controller.article;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.ActionForward;
import controller.Command;
import model.article.ArticleService;
import model.article.ArticleVo;

public class ListAllArticleCommand implements Command{
			// 1page에 몇 개의 게시글을 보여줄지
			private static final int POST_PER_PAGE= 30;
			// page 1~n개의 그룹을 정할 개수
			// 만약 값이 3이라면
			// 1,2,3 next
			// prev 4,5,6 next
			private static final int PAGE_BLOCK=5;
			
			@Override
			public ActionForward execute(HttpServletRequest request, HttpServletResponse response) 
					throws Exception {

				// *1. 현재 페이지 번호를 구한다.
				// 현재 페이지 정보를 저장해 놓을 변수
				System.out.println("커맨드 호출");
				int currentPage = 0;
				
				try {
					// 현재 페이지에 대한 정보를 받아온다.
					// 만약, 이 때 페이지에 대한 정보가 없다면 catch문으로 이동
					currentPage = Integer.parseInt(request.getParameter("currentPage"));
				} catch(Exception e){
					// 현재 페이지를 1page로 설정
					currentPage = 1;
				}
				
				// *2. 현재 페이지에 보여줄 시작행을 구한다.
				// currentPage에 -1을 해주는 이유는 mysqlDB는 index가 0부터 시작이기 떄문이다.
				int startRow = (currentPage - 1) * POST_PER_PAGE + 1;
				

				
				// *3. DB에 접근하여 게시글 정보를 불러온다.
				ArrayList<ArticleVo> articles = ArticleService.getInstance().retrieveAllArticleList(startRow, POST_PER_PAGE);
				String boardName = "전체글 조회";
				
				request.setAttribute("articles", articles);
				// *4. request영역에 바인딩
				request.setAttribute("boardName", boardName);
				
				// *5. BLOCK 설정
				int currentBlock = currentPage % PAGE_BLOCK == 0 ? currentPage / PAGE_BLOCK : currentPage / PAGE_BLOCK + 1;
				
				// *6. 현재 페이지가 속한 페이지 블록의 시작페이지 번호와 끝 페이지 번호를 구한다.
				int startPage = 1 + (currentBlock - 1) * PAGE_BLOCK;
				int endPage = startPage + (PAGE_BLOCK - 1);
				
				// *7. 총 게시글 수를 구한다.
				int totalPostCount = ArticleService.getInstance().retrieveAllTotalPostCount();
				
				// *8. 총 페이지 수를 구한다.
				int  totalPage = totalPostCount % POST_PER_PAGE == 0 ? totalPostCount / POST_PER_PAGE :
																		totalPostCount / POST_PER_PAGE + 1;
				System.out.println("count" + totalPostCount);
			
				System.out.println("ennd" +endPage);
				System.out.println("total"+totalPage);
				// 마지막 페이지가 총 페이지 수의 값보다 큰경우 마지막 페이지 값은 총 페이지 값으로 설정된다.
				if (endPage > totalPage) {
					endPage = totalPage;
				}
				System.out.println("ennd" +endPage);
				System.out.println("total"+totalPage);
				
				// *9. request영역에 바인딩
				request.setAttribute("pageBlock", PAGE_BLOCK);
				request.setAttribute("startPage", startPage);
				request.setAttribute("endPage", endPage);
				request.setAttribute("totalPage", totalPage);
				request.setAttribute("totalPostCount", totalPostCount);
				request.setAttribute("postSize", POST_PER_PAGE);
				


				request.setAttribute("content", "/viewListArticleContent.jsp?currentPage=" + currentPage);
				return new ActionForward("/side.do", false);

		
		
	}
}
