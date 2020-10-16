package hairrang_web.controller.handler.qna;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.QnA;
import hairrang_web.service.QnaService;
import hairrang_web.utils.Paging;

public class QnaHomeHandler implements Command {
	private QnaService service = new QnaService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		System.out.println("현재 접속중인 handler ==> QnaHomeHandler");
		String url = "qna/qnaHome.jsp";
		
		//현재페이지랑 한페이지당 제한 문의 갯수 넘겨주는 곳
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		
		//현재페이지랑 한페이지당 제한 문의 갯수 확인용
		System.out.println(nowPage);
		System.out.println(cntPerPage);
		
		//만약 처음 접속했을때 초기세팅해주는 곳 
		int total = service.coutnQna();
		if(nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "5";
		}else if(nowPage == null) {
			nowPage = "1";
		}else if(cntPerPage == null) {
			cntPerPage ="5";
		}
		System.out.println("지금현채 페이지 ===>"+nowPage);
		System.out.println("한 페이지당 나오는 게시물수 ===>"+cntPerPage);
		System.out.println("총게시물 갯수 ===>"+total);
		
		//이후 페이지 클래스로 정리하는곳
		Paging paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
		
		request.setAttribute("paging", paging);
		//QnA페이징해서 해당페이지 qna를 list화해서 보내주는곳
		request.setAttribute("viewAll", service.selectPagingQnA(paging));
		return url;
	}

}
