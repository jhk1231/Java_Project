//package controller.article;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import controller.ActionForward;
//import controller.Command;
//import model.article.ArticleService;
//import model.article.ArticleVo;
//
//public class ModifyArticleCommand implements Command{
//	
//	@Override
//	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) 
//			throws Exception {
//
//		// post방식이라 받아올 떄 인코딩을 해준다.
//		request.setCharacterEncoding("UTF-8");
//		
//		int no = Integer.parseInt(request.getParameter("articleNo"));
//		int boardNo = Integer.parseInt(request.getParameter("boardSelect"));
//		String subject = request.getParameter("subject");
//		String content = request.getParameter("content");
//		
//		System.out.println("모디파이 no값: "+ no);
//		
//		HttpSession session = request.getSession();
//		ArticleVo article = (ArticleVo)session.getAttribute("article");
//		article.setArticleNo(no);
//		article.setBoardNo(boardNo);
//		article.setSubject(subject);
//		article.setContent(content);
//		System.out.println("모디파이 아티클Vo: " + article);
//		
//		ArticleService service = ArticleService.getInstance();
//		service.modifyArticle(article);
//		
//		return new ActionForward("/viewListArticleContent.do", false);
//	}
//
//}
