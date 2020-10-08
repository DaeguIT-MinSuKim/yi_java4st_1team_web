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
import hairrang_web.utils.Paging;

public class QnaListHandler implements Command {
	private QnaService service = new QnaService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qna/qnaList.jsp";
		HttpSession session  = request.getSession();
		Guest loginUser = (Guest) session.getAttribute("loginUser");
		
		//만약 로그인이 되어있지 안하면 url에 qnaList.do의 경로를 저장한채로 login.do로 넘기기
		if(loginUser == null) {
			return "login.do?url='qnaList.do'";
		}
		
		//session에 저장되어있는 회원정보를 통해서 회원이 가지고 있는 qnaList를 불러오는곳
		ArrayList<QnA> list = service.qnaListById(loginUser);
		request.setAttribute("qnaList", list);
		return url;
	}

}
