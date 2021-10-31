package controller.article;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.ActionForward;
import controller.Command;
import model.article.ArticleService;
import model.article.ArticleVo;
import model.category.CategoryService;
import model.category.CategoryVo;

public class SearchAjaxCommand implements Command {

	private static final int PAGE_BLOCK = 2;
	private static final int POST_PER_PAGE = 3;

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		System.out.println("여기 도착");
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");

		System.out.println("Command : " + keyfield);

		HttpSession session = request.getSession();

		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		System.out.println("Command : " + boardNo);
		session.removeAttribute("boardNo");
		int currentPage = 0;

		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (Exception e) {
			currentPage = 1;
		}

		int startRow = (currentPage - 1) * POST_PER_PAGE;

		ArrayList<ArticleVo> searchArticle = ArticleService.getInstance().retrieveSearchArticle(boardNo, startRow, POST_PER_PAGE, keyfield,
				keyword);
		
		for(ArticleVo article : searchArticle) {
			System.out.println("command article 제목 : " + article.getSubject());
		}

		int currentBlock = currentPage % PAGE_BLOCK == 0 ? currentPage / PAGE_BLOCK : currentPage / PAGE_BLOCK + 1;

		int startPage = 1 + (currentBlock - 1) * PAGE_BLOCK;
		int endPage = startPage + (PAGE_BLOCK - 1);

		int searchTotalarticle = ArticleService.getInstance().retrieveTotalSearchArticle(boardNo, keyfield, keyword);

		int totalPage = searchTotalarticle % POST_PER_PAGE == 0 ? searchTotalarticle / POST_PER_PAGE
				: searchTotalarticle / POST_PER_PAGE + 1;

		if (endPage > totalPage) {
			endPage = totalPage;
		}

		request.setAttribute("searchArticle", searchArticle);
		request.setAttribute("pageBlock", PAGE_BLOCK);
		request.setAttribute("startPage", startPage);
		request.setAttribute("endPage", endPage);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("totalPostCount", searchTotalarticle);
		request.setAttribute("postSize", POST_PER_PAGE);

		request.setAttribute("content", "/viewListArticleContent.jsp?currentPage=" + currentPage);

		System.out.println("Command : " + searchArticle + ",  " + PAGE_BLOCK + ",   " + startPage + ",   " + endPage
				+ ",   " + totalPage + ",   " + searchTotalarticle + ",   " + POST_PER_PAGE + ",   " + currentPage);
		
		CategoryService categoryService = CategoryService.getInstance();
		ArrayList<CategoryVo> categoryList = categoryService.retrieveCategoryList();

		// 리스트 출력페이지로 request.setAttribute("categoryList", categoryList);

		request.setAttribute("side", "/viewFrameSidebar.jsp");

		System.out.println("searchCommand 싱행");

		return new ActionForward("/viewSearchArticleList.jsp", false);

	}

}