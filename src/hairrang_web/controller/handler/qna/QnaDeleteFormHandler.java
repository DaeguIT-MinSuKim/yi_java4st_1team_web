package hairrang_web.controller.handler.qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;

public class QnaDeleteFormHandler implements Command {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qna/qnaDeleteForm.jsp";
		String no = request.getParameter("no");
		request.setAttribute("no", no);
		return url;
	}

}
