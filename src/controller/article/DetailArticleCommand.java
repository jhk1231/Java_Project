package controller.article;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.ActionForward;
import controller.Command;
import model.article.ArticleDao;
import model.article.ArticleService;
import model.article.ArticleVo;
import model.article.ReplyDao;
import model.article.ReplyVo;

public class DetailArticleCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		int articleNo = Integer.parseInt(request.getParameter("articleNo"));
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		System.out.println("boardNo:" + boardNo);

		ArticleDao articleDao = ArticleDao.getInstance();
		// 게시글 조회수 증가.
		articleDao.upViewcount(articleNo);

		ArticleService service = ArticleService.getInstance();

		ArticleVo articles = service.retrieveArticle(articleNo);

		request.setAttribute("articles", articles);

		// 댓글 정보 불러와서 저장.
		List<ReplyVo> replyList = ReplyDao.getInstance().selectReplyList(articleNo);

		request.setAttribute("replyList", replyList);

		// 템플릿에 추가하기 위해 바인딩
		request.setAttribute("content", "/viewDetailArticleContent.jsp");

		return new ActionForward("/side.do", false);
	}

}
