package hairrang_web.controller.handler.admin.booking;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Booking;
import hairrang_web.service.BookingService;
import hairrang_web.utils.Paging;

public class AdminBookingListHandler implements Command {
	BookingService service;
	
	public AdminBookingListHandler() {
		service = new BookingService();
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		
		String url = "/admin/booking/booking_list.jsp";
		
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println(getClass().getSimpleName() + ">> GET");
			
			System.out.println("> 파라미터 확인");
			
			Paging paging = new Paging();
			
			String nowPage = request.getParameter("nowPage");
			String cntPerPage = request.getParameter("cntPerPage");
			String where = request.getParameter("where");
			String query = request.getParameter("query");
			String sorter = request.getParameter("sorter");
			
			System.out.println(nowPage);
			System.out.println(cntPerPage);
			System.out.println(query);
			System.out.println(where);
			System.out.println(sorter);
			
			if (where != null && query != null) {
				if(!where.trim().equals("") && !query.trim().equals("") ) {
					request.setAttribute("where", where);
					request.setAttribute("query", query);
				}
			} else {
				where = null;
				query = null;
			}
			
			if(sorter != null) {
				if(sorter.equals("")) {
					sorter = null;
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
			
			int total = service.getTotalCountBySearch(paging, where, query, sorter);
			request.setAttribute("total", total);
			
			paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			request.setAttribute("nowPage", Integer.parseInt(nowPage));
			request.setAttribute("cntPerPage", Integer.parseInt(cntPerPage));
			
			
			ArrayList<Booking> list = service.getBookingListBySearch(paging, where, query, sorter);
			request.setAttribute("list", list);
			request.setAttribute("sorter", sorter);
			
		} else {
			System.out.println(getClass().getSimpleName() + ">> POST");
			
		}

		return url;
	}
	
}
