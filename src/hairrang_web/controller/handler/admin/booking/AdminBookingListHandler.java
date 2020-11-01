package hairrang_web.controller.handler.admin.booking;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Booking;
import hairrang_web.dto.Designer;
import hairrang_web.service.BookingService;
import hairrang_web.service.DesignerService;
import hairrang_web.utils.Paging;

public class AdminBookingListHandler implements Command {
	private BookingService bService;
	private DesignerService dService;
	
	public AdminBookingListHandler() {
		bService = new BookingService();
		dService = new DesignerService();
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
			String designer = request.getParameter("designer");
			
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
			
			int total = bService.getTotalCountBySearch(paging, where, query, sorter, designer);
			request.setAttribute("total", total);
			
			paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			request.setAttribute("nowPage", Integer.parseInt(nowPage));
			request.setAttribute("cntPerPage", Integer.parseInt(cntPerPage));
			request.setAttribute("paging", paging);
			System.out.println(paging);
			
			ArrayList<Booking> list = bService.getBookingListBySearch(paging, where, query, sorter, designer);
			request.setAttribute("list", list);
			request.setAttribute("sorter", sorter);
			
			ArrayList<Designer> dList = dService.getDesignerList();
			request.setAttribute("dList", dList);
			
		} else {
			System.out.println(getClass().getSimpleName() + ">> POST");
			
		}

		return url;
	}
	
}
