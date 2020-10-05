package hairrang_web.controller.handler.qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.dto.QnA;
import hairrang_web.service.QnaService;

public class QnaWriteHandler implements Command {
	private QnaService service = new QnaService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qna/qnaWrite.jsp";
		HttpSession session = request.getSession();
		Guest loginUser = (Guest) session.getAttribute("loginUser");
		System.out.println(loginUser);

		if (loginUser == null) {
			// db에서 비회원정보를 가져온다
		}

		if (request.getMethod().equals("GET")) {
			System.out.println("GET");
			return url;
		} else {
			System.out.println("POST");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			QnA qna = new QnA(loginUser, title, content);
			service.insertQna(qna);
			return "qnaHome.do";
		}

	}
}
