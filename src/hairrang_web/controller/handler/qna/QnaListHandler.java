package hairrang_web.controller.handler.qna;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.dto.QnA;
import hairrang_web.service.QnaService;

public class QnaListHandler implements Command {
	private QnaService service = new QnaService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qna/qnaList.jsp";
		HttpSession session  = request.getSession();
		Guest loginUser = (Guest) session.getAttribute("loginUser");
		System.out.println("list에서 loginuset>>");
		if(loginUser == null) {
			System.out.println("로그인 하자");
			return "login.do?url='qnaList.do'";
		}
		ArrayList<QnA> list = service.qnaListById(loginUser);
		
		request.setAttribute("qnaList", list);
		
		return url;
	}

}
