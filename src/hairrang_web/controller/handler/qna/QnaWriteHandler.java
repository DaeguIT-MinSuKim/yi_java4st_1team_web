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

		// 만약 get방식이면 qna작성 페이지로 이동하는곳
		if (request.getMethod().equals("GET")) {
			System.out.println("GET");

			// 만약 로그인이 되어있지 안하면 url에 qnaWrite.do의 경로를 저장한채로 login.do로 넘기기
			if (loginUser == null) {
				return "login.do?url='qnaWrite.do'";
			}

			return url;
		} else {
			//방식이 post방식일 경우 제목과 내용을 가지고와서 isnert하는 곳
			System.out.println("POST");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			QnA qna = new QnA(loginUser, title, content);
			service.insertQna(qna);
			return "qnaHome.do?nowPage=1&cntPerPage=5";
		}

	}
}
