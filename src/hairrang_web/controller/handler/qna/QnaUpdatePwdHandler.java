package hairrang_web.controller.handler.qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.QnA;
import hairrang_web.service.QnaService;

public class QnaUpdatePwdHandler implements Command {
	QnaService service = new QnaService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qna/qnaUpdatePwd.jsp";
		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("GET");
			QnA qna = (QnA) request.getAttribute("qna");
			request.setAttribute("qna", qna);
			return url;
		} else {
			System.out.println("POST");
			QnA qna = (QnA) request.getAttribute("qna");
			String password = request.getParameter("password");
			qna.setQnaPassword(password);
			QnA findQna = service.passwordQna(qna);
			if (findQna != null) {
				System.out.println("비밀번호랑 맞은 qna찾음");
				return "qnaUpdate.do?qna=" + qna;
			} else {
				System.out.println("비밀번호랑 맞은 qna 못찾음");
				response.sendRedirect("qnaHome.do");
				return null;
			}
		}
	}
}
