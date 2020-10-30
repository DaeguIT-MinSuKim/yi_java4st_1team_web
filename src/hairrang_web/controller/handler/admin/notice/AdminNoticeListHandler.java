package hairrang_web.controller.handler.admin.notice;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Notice;
import hairrang_web.service.NoticeService;
import hairrang_web.utils.Paging;

public class AdminNoticeListHandler implements Command {
	private NoticeService service = new NoticeService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		String url = "/admin/notice/notice_list.jsp";

		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println(getClass().getSimpleName() + ">> GET");

			// 현재페이지랑 한페이지당 제한 문의 갯수 넘겨주는 곳
			String nowPage = request.getParameter("nowPage");
			String cntPerPage = request.getParameter("cntPerPage");
			String status = request.getParameter("status");
			System.out.println("stutus : " + status);

			// 현재페이지랑 한페이지당 제한 문의 갯수 확인용
			System.out.println(nowPage);
			System.out.println(cntPerPage);

			//인스터스
			int total = 0;
			Paging paging = new Paging();
			List<Notice> list = new ArrayList<Notice>();

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
			if (status == null) {
				status = "all";
			}
			if (status.equals("all") || status == null) {

				total = service.countNotice();
				paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
				list = service.selectPagingNotice(paging);

			} else if (status.equals("del")) {
				total = service.countDelNotice();
				paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
				list = service.selectPagingDelNotice(paging);
			}

			System.out.println("지금현채 페이지 ===>" + nowPage);
			System.out.println("한 페이지당 나오는 게시물수 ===>" + cntPerPage);
			System.out.println("총게시물 갯수 ===>" + total);

			// 이후 페이지 클래스로 정리하는곳
			request.setAttribute("status", status);
			request.setAttribute("paging", paging);
			request.setAttribute("total", total);
			// QnA페이징해서 해당페이지 qna를 list화해서 보내주는곳
			request.setAttribute("viewAll", list);

			return url;

		} else {
			System.out.println(getClass().getSimpleName() + ">> POST");

			// 현재페이지랑 한페이지당 제한 문의 갯수 넘겨주는 곳
			String nowPage = request.getParameter("nowPage");
			String cntPerPage = request.getParameter("cntPerPage");
			String status = request.getParameter("status");
			System.out.println("stutus : " + status);

			// 현재페이지랑 한페이지당 제한 문의 갯수 확인용
			System.out.println(nowPage);
			System.out.println(cntPerPage);

			//인스터스
			int total = 0;
			Paging paging = new Paging();
			List<Notice> list = new ArrayList<Notice>();

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
			if (status == null) {
				status = "all";
			}
			if (status.equals("all") || status == null) {

				total = service.countNotice();
				paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
				list = service.selectPagingNotice(paging);

			} else if (status.equals("del")) {
				total = service.countDelNotice();
				paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
				list = service.selectPagingDelNotice(paging);
			}

			System.out.println("지금현채 페이지 ===>" + nowPage);
			System.out.println("한 페이지당 나오는 게시물수 ===>" + cntPerPage);
			System.out.println("총게시물 갯수 ===>" + total);
			
			//검색 정리하는곳
			String opt = request.getParameter("opt"); // 0 제목 1내용
			String value = request.getParameter("value");
			
			//제목으로 검색
			if(opt.equals(0)) {
				list = service.selectPagingNoticeByTitle(paging, value);
				// 이후 페이지 클래스로 정리하는곳
				request.setAttribute("status", status);
				request.setAttribute("paging", paging);
				request.setAttribute("total", total);
				// QnA페이징해서 해당페이지 qna를 list화해서 보내주는곳
				request.setAttribute("viewAll", list);

			}
			//내용으로 검색
			else if(opt.equals(1)) {
			}
			
			
			

			// 이후 페이지 클래스로 정리하는곳
			request.setAttribute("status", status);
			request.setAttribute("paging", paging);
			request.setAttribute("total", total);
			// QnA페이징해서 해당페이지 qna를 list화해서 보내주는곳
			request.setAttribute("viewAll", list);

			return url;

		}

	}

}
