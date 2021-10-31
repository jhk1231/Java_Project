package controller.article;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.ActionForward;
import controller.Command;
import model.article.ArticleService;

public class RemoveArticleCommand implements Command {
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) 
			throws Exception {
		
		System.out.println("지울 게시글 번호:" + request.getParameter("articleNo"));
		
		int no = Integer.parseInt(request.getParameter("articleNo"));
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		
		// 삭제 작업
		ArticleService service = ArticleService.getInstance();
		service.removeArticle(no);
		
		
		return new ActionForward("/viewListArticleContent.do?boardNo=" + boardNo, true);
		
	}

}
