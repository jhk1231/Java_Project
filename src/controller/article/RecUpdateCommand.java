package controller.article;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.ActionForward;
import controller.Command;
import model.article.ArticleDao;

public class RecUpdateCommand implements Command{
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) 
			throws Exception {
		// DB에 값 조회 만약 있으면 -1 없으면 1
		int memberNo = Integer.parseInt(request.getParameter("memberNo"));
		int articleNo = Integer.parseInt(request.getParameter("articleNo"));
		System.out.println("update MemberNo: " + memberNo);
		System.out.println("articleNo: " + articleNo);
		
		
		ArticleDao articleDao = ArticleDao.getInstance();
		
		int likeNo = articleDao.selectLikeList(articleNo, memberNo);
		System.out.println("**********seslectLikeNo값*********" + likeNo);
		
		if (likeNo == 0) { // 추천한 적이 없을 떄
			articleDao.createLike(memberNo, articleNo);
		} else {
			// 추천을 눌렀을 경우 DB에서 삭제
			System.out.println("delete 접속");
			articleDao.deleteLike(likeNo);
		}
		
		// 작업이 끝난 뒤 값을 받아온다.
		int totalCount = articleDao.totalLikeCount(articleNo);
		articleDao.updateArticleLike(articleNo, totalCount);
		
		request.setAttribute("totalCount", totalCount);
		
		return new ActionForward("totalCountAjax.jsp", false);
	}

}
