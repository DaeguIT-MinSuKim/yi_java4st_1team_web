package hairrang_web.controller.handler.mypage;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.dto.QnA;
import hairrang_web.service.QnaService;

public class GuestQnaDetailHandler implements Command {
	private QnaService service = new QnaService();
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		HttpSession session = request.getSession();
		
		int qnaNo = Integer.parseInt(request.getParameter("no"));
		System.out.println("qnaNo");
		QnA qna = service.selectQnaByNo(qnaNo);
		QnA resQna = new QnA();
		if(qna.getQnaResYn().equals("y")) {
			resQna = service.selectResQnaByNo(qna);
		}
		
		Guest loginUser = (Guest) session.getAttribute("loginUser");
		
		System.out.println("qna 이름 :"+qna.getGuestId().getGuestId());
		try {
		System.out.println("loginUser 이름 :"+loginUser.getGuestId());
		}catch (Exception e) {
			loginUser = null;
		}
		request.setAttribute("loginUser", loginUser);
		request.setAttribute("qna", qna);
		request.setAttribute("resQna", resQna);
		
		return "mypage/guest_qna_detail.jsp";
	}

}
