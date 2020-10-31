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
			System.out.println("cntPerPage==>"+cntPerPage);
			String stay = request.getParameter("stay");
			
			//stay 확인용
			System.out.println("stay ==>"+stay);
			if(stay == null) {
				stay ="all";
			}
			

			//인스터스
			int total = 0;
			Paging paging = new Paging();
			List<Notice> list = new ArrayList<Notice>();

			//검색
			String keyword = request.getParameter("keyword");
			System.out.println("키워드 ==> "+keyword);
			String condition = request.getParameter("condition");
			System.out.println("condition ==> "+condition);

			
			
			if (condition != null && keyword != null) {
				if(!condition.trim().equals("") && !keyword.trim().equals("")) {
					request.setAttribute("keyword", keyword);
					request.setAttribute("condition", condition);
				}
			}

			// 현재페이지랑 한페이지당 제한 문의 갯수 확인용 및 상태
			System.out.println("stay : " + stay);
			System.out.println(nowPage);
			System.out.println(cntPerPage);
			
			total = service.countPagingNoticeSearch(paging, condition, keyword, stay);

			// 만약 처음 접속했을때 초기세팅해주는 곳
			if (nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if (cntPerPage == null) {
				cntPerPage = "10";
			}
			
			paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));

			System.out.println("지금현채 페이지 ===>" + nowPage);
			System.out.println("한 페이지당 나오는 게시물수 ===>" + cntPerPage);
			System.out.println("총게시물 갯수 ===>" + total);

			list = service.selectPagingNoticeSearch(paging, condition, keyword, stay);

			// 이후 페이지 클래스로 정리하는곳
			request.setAttribute("cnt", cntPerPage);
			request.setAttribute("stay", stay);
			request.setAttribute("paging", paging);
			request.setAttribute("total", total);
			// QnA페이징해서 해당페이지 qna를 list화해서 보내주는곳
			request.setAttribute("viewAll", list);

			return url;

		} else {
			System.out.println(getClass().getSimpleName() + ">> POST");

			return null;

		}

	}

}