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
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		String url = "/admin/booking/booking_list.jsp";
		
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println(getClass().getSimpleName() + ">> GET");
			
			System.out.println("> 파라미터 확인");
			
			Paging paging = null;
			String condition = null;
			
			String nowPage = request.getParameter("nowPage");
			String cntPerPage = request.getParameter("cntPerPage");
			String keyword = request.getParameter("keyword");
			
			if (keyword != null) {
				condition = request.getParameter("condition");
				request.setAttribute("keyword", keyword);
				request.setAttribute("condition", condition);
			}
			
			int total = service.getTotalCountByCondition(paging, condition, keyword);
			request.setAttribute("total", total);
			
			if(nowPage == null) {
				nowPage = "1";
			}
			if(cntPerPage == null) {
				cntPerPage ="10";
			}
			
			paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			request.setAttribute("nowPage", Integer.parseInt(nowPage));
			request.setAttribute("cntPerPage", Integer.parseInt(cntPerPage));
			
			System.out.println(nowPage);
			System.out.println(cntPerPage);
			System.out.println(keyword);
			System.out.println(paging);
			
			ArrayList<Booking> list = service.getBookingListByCondition(paging, condition, keyword);
			request.setAttribute("list", list);
			
		} else {
			System.out.println(getClass().getSimpleName() + ">> POST");
			
		}

		return url;
	}
	
}
