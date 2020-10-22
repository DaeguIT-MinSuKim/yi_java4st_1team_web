package hairrang_web.controller.handler.admin.guest;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.service.GuestService;
import hairrang_web.utils.Paging;

public class AdminGuestListHandler implements Command {
	private GuestService service = new GuestService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		String url = "/admin/guest/guest_list.jsp";
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println(getClass().getSimpleName() + ">> GET");
			
			//현재페이지랑 한페이지당 제한 문의 갯수 넘겨주는 곳
			String nowPage = request.getParameter("nowPage");
			String cntPerPage = request.getParameter("cntPerPage");
			
			
			//현재페이지랑 한페이지당 제한 문의 갯수 확인용
			System.out.println(nowPage);
			System.out.println(cntPerPage);
			
			//만약 처음 접속했을때 초기세팅해주는 곳 
			int total = service.countGuest();
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			}else if(nowPage == null) {
				nowPage = "1";
			}else if(cntPerPage == null) {
				cntPerPage ="10";
			}
//			System.out.println("지금현채 페이지 ===>"+nowPage);
//			System.out.println("한 페이지당 나오는 게시물수 ===>"+cntPerPage);
//			System.out.println("총게시물 갯수 ===>"+total);
			
			//이후 페이지 클래스로 정리하는곳
			Paging paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			ArrayList<Guest> list = service.pagingGuestByAll(paging);
			///////////
			
			String id = request.getParameter("id");
			request.setAttribute("id", id);
			
			request.setAttribute("list", list);
			request.setAttribute("paging", paging);
			request.setAttribute("total", total);
			request.setAttribute("cnt", cntPerPage);
		
			
		} else {
			
			System.out.println(getClass().getSimpleName() + ">> POST");
			
			//현재페이지랑 한페이지당 제한 문의 갯수 넘겨주는 곳
			String nowPage = request.getParameter("nowPage");
			String cntPerPage = request.getParameter("cntPerPage");
			
			//현재페이지랑 한페이지당 제한 문의 갯수 확인용
			System.out.println(nowPage);
			System.out.println(cntPerPage);
			
			//만약 처음 접속했을때 초기세팅해주는 곳 
			int total = service.countGuest();
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			}else if(nowPage == null) {
				nowPage = "1";
			}else if(cntPerPage == null) {
				cntPerPage ="10";
			}
			
			//이후 페이지 클래스로 정리하는곳
			String opt = request.getParameter("opt"); //0 아이디, 1이름
			String value = request.getParameter("value");
						
			if(opt.equals("0")) { //아이디로검색
				total = service.countIdSearch(value);
				Paging paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
				
				ArrayList<Guest> idSearchlist = service.searchGuestById(paging, value);
				request.setAttribute("list", idSearchlist);
				request.setAttribute("cnt", cntPerPage);
				request.setAttribute("total", total);
				request.setAttribute("paging", paging);
				
			}else {//이름으로 검색
				total = service.countNameSearch(value);
				Paging paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
				ArrayList<Guest> nameSearchList = service.searchGuestByName(paging, value);
				
				request.setAttribute("list", nameSearchList);
				request.setAttribute("cnt", cntPerPage);
				request.setAttribute("total", total);
				request.setAttribute("paging", paging);
			}
			
			
			System.out.println("지금현채 페이지 ===>"+nowPage);
			System.out.println("한 페이지당 나오는 게시물수 ===>"+cntPerPage);
			System.out.println("총게시물 갯수 ===>"+total);
		
		}
		
		return url;
	}

}
