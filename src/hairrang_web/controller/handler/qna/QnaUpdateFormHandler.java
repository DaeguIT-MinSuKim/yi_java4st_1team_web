package hairrang_web.controller.handler.qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;

public class QnaUpdateFormHandler implements Command {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qna/qnaUpdateForm.jsp";
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String no = request.getParameter("no");
		
		System.out.println("QnaUpdateFormHandler");
		System.out.println("no"+no);
		System.out.println("title"+title);
		System.out.println("content"+content);
		
		
		request.setAttribute("no", no);
		request.setAttribute("title", title);
		request.setAttribute("content", content);
		return url;
	}

}
