package controller.article;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utill.FileUploadUtils;

@WebServlet("/fileDownload")
public class FileDownloadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String originalFileName = request.getParameter("originalFileName");
		String systemFileName = request.getParameter("systemFileName");

		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		try {
			File file = new File(FileUploadUtils.UPLOAD_PATH + "/" + systemFileName);
			System.out.println("file: " + file);
			if (file.exists()) {
				System.out.println("if문 진입");
				response.setHeader("Content-Type", "application/octet-stream");
				response.setHeader("Content-Transfer-Encoding", "binary");
				originalFileName = new String(originalFileName.getBytes("utf-8"), "ISO_8859_1");
				response.setHeader("Content-Disposition", "attachment; filename=\"" + originalFileName + "\"");
				int len = (int) file.length();
				response.setContentLength(len);

				String filePath = FileUploadUtils.UPLOAD_PATH + "/" + systemFileName;
				bis = new BufferedInputStream(new FileInputStream(filePath));
				bos = new BufferedOutputStream(response.getOutputStream());
				byte[] buf = new byte[1024];
				int readByte = 0;
				while ((readByte = bis.read(buf)) != -1) {
					bos.write(buf, 0, readByte);
				}

			} else {
				throw new Exception("");
			}

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("exception", e);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
			dispatcher.forward(request, response);
		} finally {
			try {
				if (bis != null)
					bis.close();
				if (bos != null)
					bos.close();
			} catch (Exception e2) {
				request.setAttribute("exception", e2);
				RequestDispatcher dispatcher = request.getRequestDispatcher("/error.jsp");
				dispatcher.forward(request, response);
			}

		}

	}

}
