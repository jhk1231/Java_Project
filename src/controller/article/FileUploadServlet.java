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
import model.member.MemberVo;
import utill.FileUploadUtils;


/*
 * fileSizeThreshold: (int) 파일업로드 시에 메모리에 저장되는 임시 파일의 크기
 * maxFileSize: (long) 업로드 파일의 최대크기
 * maxRequestSize: (long) request시 파일의 최대 크기
 * location: (String) 파일 임시저장 폴더
 */
@MultipartConfig(fileSizeThreshold = 1024, maxFileSize = -1L, maxRequestSize = -1L, location = "C:/temp")
@WebServlet(urlPatterns= {"/uploadFile"})
public class FileUploadServlet extends HttpServlet {
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		MemberVo member = (MemberVo) session.getAttribute("user");
		System.out.println("memberNo: " + member.getNo());
		
		try {
			
			System.out.println("fileServlet 진입");
			// post방식이라 Encoding을 해준다.
			request.setCharacterEncoding("UTF-8");
			
			// 첨부된 파일들을 part객체를 받아줄 Collection 객체 생성
			Collection<Part> parts = request.getParts();
			
			ArticleVo article = new ArticleVo();
			// 회원 정보 저장
			article.setMemberNo(member.getNo());
			article.setNickname(member.getNickname());
			
			// 게시글 내용 저장
			for (Part part : parts) {
//				System.out.println(part.getHeader("content-disposition"));
//				System.out.println(part.getName());
				if(!part.getHeader("Content-Disposition").contains("filename=")) {
					// 만약 파트 객체의 Content-Disposiotion 헤더에 filename=을 포함하고 있지 않다면
					// form data이니 받아준다 (subject, content 등)
					
					String name = part.getName();
					// 게시글 작성을 위해 값을 저장하는 부분
					
					// 회원 정보는 로그인시 세션에 저장된 정보를 사용
					
					if (name.equals("boardSelect")) {
						System.out.println("boardselect!!!!");
						article.setBoardNo(Integer.parseInt(request.getParameter(name)));
					} else if (name.equals("subject")) {
						System.out.println("subject: " +name);
						article.setSubject(request.getParameter(name));
					} else if (name.equals("content")) {
						System.out.println("content!!!!");
						article.setContent(request.getParameter(name));
					}
				} else { // filename=이 있다면
					
					// 만약 part객체가 있다면.
					if(part.getSize() != 0) {
						// file은 ArticlefileVo객체 반환
						ArticleFileVo file = FileUploadUtils.upload(part, request);
						// ArticleVo의  ArrayList<ArticleFileVo> 객체에 file을 add
						article.addArticleFile(file);
					}
				}
				
				
			}
			System.out.println(article.getContent());
			System.out.println("파일업로드 article: " + article);
			ArticleService articleService = ArticleService.getInstance();
			articleService.registerArticle(article);
			
			int boardNo = article.getBoardNo();
			
			response.sendRedirect(request.getContextPath() + "/viewListArticleContent.do?boardNo="  + boardNo);
			
		}catch (Exception e) {
			request.setAttribute("exception", e);
			request.setAttribute("requestURI", request.getRequestURI());
			RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
			dispatcher.forward(request, response);
			
			
			e.printStackTrace();
		}
		
	}
	

}
