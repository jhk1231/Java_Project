package controller.article;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.ActionForward;
import controller.Command;
import model.article.ArticleService;
import model.article.ArticleVo;

public class ModifyArticleFormCommand implements Command {
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) 
			throws Exception {
		
		// 게시글 번호를 가져온다.
		System.out.println("모디파이 no: " + request.getParameter("articleNo"));
		int no = Integer.parseInt(request.getParameter("articleNo"));
		
		// 수정할 게시글 정보를 불러온다.
		ArticleService service = ArticleService.getInstance();
		ArticleVo article = service.retrieveArticle(no);
		
		HttpSession session = request.getSession();
		session.setAttribute("article", article);
		
		request.setAttribute("content", "viewModifyArticleContent.jsp");
		
		return new ActionForward("/homeIndex.jsp", false);
	}

}
