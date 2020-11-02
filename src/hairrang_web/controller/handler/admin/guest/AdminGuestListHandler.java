package hairrang_web.controller.handler.admin.guest;

import java.io.IOException;
import java.util.ArrayList;

import javax.management.Query;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

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
			
			Paging paging = new Paging();
			
			String nowPage = request.getParameter("nowPage");
			String cntPerPage = request.getParameter("cntPerPage");
			String del = request.getParameter("del");
			String where = request.getParameter("where");
			String query = request.getParameter("query");
			System.out.println("where" + where);
			System.out.println("q" + query);
			
			if (where != null && query != null) {
				if(!where.trim().equals("") && !query.trim().equals("") ) {
					
					request.setAttribute("where", where);
					request.setAttribute("query", query);
				}
			} else {
				where = null;
				query = null;
			}
			
			if(del != null) {
				if(del.equals("")) {
					del = null;
				}
			}
			
			if(nowPage == null) {
				nowPage = "1";
			}
			if(cntPerPage == null) {
				cntPerPage ="10";
			}
			
			paging.setNowPage(Integer.parseInt(nowPage));
			paging.setCntPerPage(Integer.parseInt(cntPerPage));
			
			int total = service.countBookingByConditionForPaging(paging, del, where, query);
			request.setAttribute("total", total);
			
			paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			request.setAttribute("nowPage", Integer.parseInt(nowPage));
			request.setAttribute("cntPerPage", Integer.parseInt(cntPerPage));
			request.setAttribute("paging", paging);
			System.out.println(paging);
			
			ArrayList<Guest> list = service.selectGuestByCondition(paging, del, where, query);
			request.setAttribute("list", list);
			request.setAttribute("del", del);
			
			
		} else {
			System.out.println(getClass().getSimpleName() + ">> POST");
		
		}
		
		return url;
	}

}
