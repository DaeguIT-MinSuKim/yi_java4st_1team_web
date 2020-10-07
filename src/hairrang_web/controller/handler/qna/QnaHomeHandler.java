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
import hairrang_web.utils.Paging;

public class QnaHomeHandler implements Command {
	private QnaService service = new QnaService();
	
	//임시로 로그인했다고 가정
	private GuestDao dao = GuestDaoImpl.getInstance();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qna/qnaHome.jsp";
		ArrayList<QnA> noticeList = service.noticeList();
		ArrayList<QnA> qnaList = service.qnaList();
				
		System.out.println("notice >"+noticeList);
		System.out.println("qna >"+qnaList);
		
		//임시로 로그인했다고 가정
		Guest loginUser = dao.selectGuestById(new Guest("test"));
		System.out.println(loginUser);
		HttpSession session = request.getSession();
		session.setAttribute("loginUser", loginUser);
		
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		int total = service.coutnQna();
		if(nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		}else if(nowPage == null) {
			nowPage = "1";
		}else if(cntPerPage == null) {
			cntPerPage ="5";
		}
		System.out.println("지금현채 페이지 ====>"+nowPage);
		System.out.println("한 페이지당 나오는 게시물수 ---->"+cntPerPage);
		System.out.println("총게시물 갯수------>"+total);
		
		Paging paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
		request.setAttribute("paging", paging);
		request.setAttribute("viewAll", service.selectPagingQnA(paging));
		System.out.println("페이징된 문의글들------------->"+service.selectPagingQnA(paging));
		
		
		
		request.setAttribute("qnaList", qnaList);
		request.setAttribute("noticeList", noticeList);
		return url;
	}

}
