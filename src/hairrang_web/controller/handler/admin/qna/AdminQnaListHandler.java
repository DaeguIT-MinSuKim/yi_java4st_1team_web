package hairrang_web.controller.handler.admin.qna;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.QnA;
import hairrang_web.service.QnaService;
import hairrang_web.utils.Paging;

public class AdminQnaListHandler implements Command {
	private QnaService service = new QnaService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		String url = "/admin/qna/qna_list.jsp";

		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println(getClass().getSimpleName() + ">> GET");

		} else {
			System.out.println(getClass().getSimpleName() + ">> POST");

		}

		// 현재페이지랑 한페이지당 제한 문의 갯수 넘겨주는 곳
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");
		String stay = request.getParameter("stay");
		System.out.println("stay : " +stay);

		// 현재페이지랑 한페이지당 제한 문의 갯수 확인용
		System.out.println(nowPage);
		System.out.println(cntPerPage);

		//인스터스
		int total = 0;
		Paging paging = new Paging();
		List<QnA> list = new ArrayList<QnA>();

		// 만약 처음 접속했을때 초기세팅해주는 곳
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "10";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "10";
		}

		// 어떤페이지 볼지 확인하는곳
		if (stay == null) {
			stay = "all";
		}
		//전체
		if (stay.equalsIgnoreCase("all") || stay == null) {
			total = service.countQna();
			paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			list = service.selectPagingQnA(paging);
		}
		//답변 문의
		else if (stay.equalsIgnoreCase("resy")) {
			total = service.countResYQnA();
			paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			list = service.selectPagingResYQnA(paging);
		}
		//미답변 문의
		else if (stay.equalsIgnoreCase("resn")) {
			total = service.countResNQnA();
			paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			list = service.selectPagingResNQnA(paging);
		}
		//삭제된 문의
		else if (stay.equalsIgnoreCase("delq")) {
			total = service.countDelYQnA();
			System.out.println("삭제된 문의"+total);
			paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			list = service.selectPagingDelYQnA(paging);
			System.out.println("삭제된 문의 글");
			list.stream().forEach(System.out::println);
		}
		//삭제된 문의공지
		else if (stay.equalsIgnoreCase("deln")) {
			total = service.countDelYQnANotice();
			System.out.println("삭제된 문의공지"+total);
			paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			list = service.selectPagingDelYQnANotice(paging);
			System.out.println("삭제된 공지 글");
			list.stream().forEach(System.out::println);
		}

		System.out.println("지금현채 페이지 ===>" + nowPage);
		System.out.println("한 페이지당 나오는 게시물수 ===>" + cntPerPage);
		System.out.println("총게시물 갯수 ===>" + total);

		request.setAttribute("cnt", cntPerPage);
		request.setAttribute("total", total);
		request.setAttribute("stay", stay);
		request.setAttribute("paging", paging);

		// QnA페이징해서 해당페이지 qna를 list화해서 보내주는곳
		request.setAttribute("viewAll", list);
		
		return url;
	}

}
