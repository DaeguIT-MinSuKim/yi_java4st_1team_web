package hairrang_web.controller.handler.qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.QnA;

public class QnaUpdateFormHandler implements Command {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qna/qnaUpdateForm.jsp";

		/*		QnA qna = (QnA) request.getAttribute("qna");
				System.out.println("디테일에서 가져온 qna"+qna);
				request.setAttribute("qna", qna);*/
		int no = Integer.parseInt(request.getParameter("no"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		QnA qna = new QnA(no, title, content);
		request.setAttribute("qna", qna);
		
		return url;
	}

}
