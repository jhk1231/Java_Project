package controller.article;

import java.io.IOException;
import java.util.Collection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import model.article.ArticleFileVo;
import model.article.ArticleService;
import model.article.ArticleVo;
import utill.FileUploadUtils;


/*
 * fileSizeThreshold: (int) 파일업로드 시에 메모리에 저장되는 임시 파일의 크기
 * maxFileSize: (long) 업로드 파일의 최대크기
 * maxRequestSize: (long) request시 파일의 최대 크기
 * location: (String) 파일 임시저장 폴더
 */
@MultipartConfig(fileSizeThreshold = 1024, location="C:/temp", maxFileSize= -1L, maxRequestSize=-1L)
@WebServlet("/modifyArticle")
public class ModifyArticleServlet extends HttpServlet {
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("수정 서블렛 진입");
		request.setCharacterEncoding("UTF-8");
		
		try {
			
			// 게시글 정보를 받아온다.
			HttpSession session = request.getSession();
			ArticleVo article = (ArticleVo) session.getAttribute("article");
			
			// Vo객체 안에 있는 ArrayList<file>을 비워준다.
			article.getFileList().clear();
			
			Collection<Part> parts = request.getParts();
			
			// 게시글 정보 저장
			article.setArticleNo(Integer.parseInt(request.getParameter("articleNo")));
			
			for (Part part : parts) {
				if (!part.getHeader("content-disposition").contains("filename=")) {

					String name = part.getName();
					// 첨부파일이 아닌경우.
					switch (name) {
					case "boardSelect":
						article.setBoardNo(Integer.parseInt(request.getParameter(name)));
					case "subject":
						article.setSubject(request.getParameter(name));
						break;
					case "content":
						article.setContent(request.getParameter(name));
						break;
					}
				} else {
					// 첨부 파일인 경우
					// != 0 이라면 파일이 존재한다는 의미
					if (part.getSize() != 0) {
						// originalFileName, systemFileName, fileSize가 담긴 FileVo객체 반환
						ArticleFileVo file = FileUploadUtils.upload(part, request);
						// 반환된 객체를 articleVo에 추가
						article.addArticleFile(file);
					}
				}
			}
			// 수정 작업.
			ArticleService articleService = ArticleService.getInstance();
			// 수정 메서드에 Vo객체를 전달
			articleService.modifyArticle(article);
			// 세션에 저장되어 있던 게시글 정보 제거
			session.removeAttribute("article");
			
			int boardNo = Integer.parseInt(request.getParameter("boardNo"));
			int articleNo = article.getArticleNo();
			
			
			response.sendRedirect(request.getContextPath() + "/viewDetailArticleContent.do?articleNo="+ articleNo + "&boardNo=" + boardNo);
			
			
		} catch (Exception e) {
			request.setAttribute("excetion", e);
			request.setAttribute("requestURI", request.getRequestURI());
			RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
			dispatcher.forward(request, response);
		} 
		
	}
	
}
