package hairrang_web.controller.handler.qna;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dao.GuestDao;
import hairrang_web.dao.impl.GuestDaoImpl;
import hairrang_web.dto.Guest;
import hairrang_web.dto.QnA;
import hairrang_web.service.QnaService;

public class QnaHomeHandler implements Command {
	private QnaService serviece = new QnaService();
	
	//임시로 로그인했다고 가정
	private GuestDao dao = GuestDaoImpl.getInstance();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qna/qnaHome.jsp";
		ArrayList<QnA> noticeList = serviece.noticeList();
		ArrayList<QnA> qnaList = serviece.qnaList();
				
		System.out.println("notice >"+noticeList);
		System.out.println("qna >"+qnaList);
		
		//임시로 로그인했다고 가정
		Guest loginUser = dao.selectGuestById(new Guest("test"));
		System.out.println(loginUser);
		HttpSession session = request.getSession();
		session.setAttribute("loginUser", loginUser);
		
		
		request.setAttribute("qnaList", qnaList);
		request.setAttribute("noticeList", noticeList);
		return url;
	}

}
