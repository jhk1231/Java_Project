package controller.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.ActionForward;
import controller.Command;
import model.board.BoardGradeVo;
import model.board.BoardService;
import model.board.BoardVo;
import model.category.CategoryService;
import model.category.CategoryVo;

public class ModifyBordCommand implements Command {

	@Override
	public ActionForward execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		req.setCharacterEncoding("utf-8");
		
		int categoryNo = Integer.parseInt(req.getParameter("categoryNameForBoard"));
		int boardNo = Integer.parseInt(req.getParameter("boardNo"));
		String boardName = req.getParameter("boardName");
		int readGrade = Integer.parseInt(req.getParameter("readGrade"));
		int writeGrade = Integer.parseInt(req.getParameter("writeGrade"));
		
		BoardService boardService = BoardService.getInstance();
		boardService.modifyBoard(new BoardVo(boardNo, boardName, categoryNo), new BoardGradeVo(readGrade, writeGrade));		
		
		return new ActionForward("/listCategoryManager.do", false);
		
	}
	

}
