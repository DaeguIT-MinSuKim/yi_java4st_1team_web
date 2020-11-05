package hairrang_web.controller.handler.admin.event;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Event;
import hairrang_web.dto.Guest;
import hairrang_web.service.EventService;
import hairrang_web.utils.Paging;

public class AdminEventListHandler implements Command {
	private EventService service = new EventService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {	
		String url = "/admin/event/event_list.jsp";
		
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println(getClass().getSimpleName() + ">> GET");
			//현재페이지랑 한페이지당 제한 문의 갯수 넘겨주는 곳
			String nowPage = request.getParameter("nowPage");
			String cntPerPage = request.getParameter("cntPerPage");
			String status = request.getParameter("status");
			
			Paging paging = new Paging();
			
			System.out.println("status: " + status);
			
			
			if(status != null) {
				if(!status.trim().equals("")) {
					request.setAttribute("status", status);
				}
			} else {
				status = null;
			}
			

			if(nowPage == null) {
				nowPage = "1";
			}
			if(cntPerPage == null) {
				cntPerPage ="10";
			}
			paging.setNowPage(Integer.parseInt(nowPage));
			paging.setCntPerPage(Integer.parseInt(cntPerPage));
			
			//현재페이지랑 한페이지당 제한 문의 갯수 확인용
			System.out.println("now" + nowPage);
			System.out.println("cnt" + cntPerPage);
			
			
			//만약 처음 접속했을때 초기세팅해주는 곳 
			int total = service.countEvent(paging, status);
			
			
			//이후 페이지 클래스로 정리하는곳
			paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			ArrayList<Event> list = service.PagingEventAll(paging, status);
			
			System.out.println(paging);
			///////////
			request.setAttribute("paging", paging);
			request.setAttribute("total", total);
			request.setAttribute("nowPage", Integer.parseInt(nowPage));
			request.setAttribute("cntPerPage", Integer.parseInt(cntPerPage));
			
			request.setAttribute("list", list);
			
			
			
		} else {
			System.out.println(getClass().getSimpleName() + ">> POST");
			
		}
		
		return url;
	}

}
