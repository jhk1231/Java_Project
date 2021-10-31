package controller.article;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.ActionForward;
import controller.Command;
import model.board.BoardGradeDao;
import model.board.BoardGradeVo;
import model.board.BoardVo;
import model.category.CategoryService;
import model.category.CategoryVo;
import model.member.MemberVo;

public class WriteArticleFormCommand implements Command{
	
	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) 
			throws Exception {

		ArrayList<BoardVo> boardList = new ArrayList<BoardVo>();
		
		CategoryService categoryService = CategoryService.getInstance();
		ArrayList<CategoryVo> categoryList = categoryService.retrieveCategoryList();
		
		HttpSession session = request.getSession();
		MemberVo user = (MemberVo)session.getAttribute("user");
		// 모든 게시판의 쓰기 등급을 받아온다.
		HashMap<Integer, BoardGradeVo> grades = BoardGradeDao.getInstance().selectAllBoardGrade(1);
		
		for (CategoryVo cat : categoryList) {
			ArrayList<BoardVo> boards = cat.getBoardList();
				for(BoardVo bo: boards) {
					if( grades.containsKey(bo.getBoardNo() )){
						if( grades.get(bo.getBoardNo()).getWriteGrade() >= user.getGradeNo()) {
							boardList.add(bo);
							System.out.println(bo.getBoardName());
						}
					}
				}
		}
		
		
		//request.setAttribute("grades", grades);
		
		//리스트 출력페이지로 
		//request.setAttribute("categoryList", categoryList);
		request.setAttribute("boardList", boardList);
		
		
		request.setAttribute("content", "viewWriteArticleContent.jsp");
		
		// 글쓰기 요청이 오면 게시글 작성 폼으로 이동
		ActionForward forward = new ActionForward("/homeIndex.jsp", false);
		return forward;
	}

}
