package controller.article;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.ActionForward;
import controller.Command;
import model.article.ArticleDao;

public class RecCountCommand implements Command {
	

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) 
			throws Exception {
		
		int articleNo = Integer.parseInt(request.getParameter("articleNo"));
		
		ArticleDao articleDao = ArticleDao.getInstance();
		
		// 작업이 끝난 뒤 값을 받아온다.
		int totalCount = articleDao.totalLikeCount(articleNo);
		
		// articleDB도 최신화에도 적용
		articleDao.updateArticleLike(articleNo, totalCount);
		
		request.setAttribute("totalCount", totalCount);
		
		return new ActionForward("totalCountAjax.jsp", false);
	}

}
