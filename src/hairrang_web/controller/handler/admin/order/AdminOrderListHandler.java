package hairrang_web.controller.handler.admin.order;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Designer;
import hairrang_web.dto.Orders;
import hairrang_web.service.BookingService;
import hairrang_web.service.DesignerService;
import hairrang_web.service.OrdersService;
import hairrang_web.utils.Paging;

public class AdminOrderListHandler implements Command {
	
	private OrdersService oService;
	private DesignerService dService;
			
	public AdminOrderListHandler() {
		oService = new OrdersService();
		dService = new DesignerService();
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		String url = "/admin/order/order_list.jsp";
		
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println(getClass().getSimpleName() + ">> GET");
			
			Paging paging = new Paging();
			
			String nowPage = request.getParameter("nowPage");
			String cntPerPage = request.getParameter("cntPerPage");
			String where = request.getParameter("where");
			String query = request.getParameter("query");
			String designer = request.getParameter("designer");
			String membership = request.getParameter("membership");
			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			
			if (where != null && query != null) {
				if(!where.trim().equals("") && !query.trim().equals("") ) {
					request.setAttribute("where", where);
					request.setAttribute("query", query);
				}
			} else {
				where = null;
				query = null;
			}
			
			if(nowPage == null) {
				nowPage = "1";
			}
			if(cntPerPage == null) {
				cntPerPage ="10";
			}
			
			int total = oService.getTotalCountBySearch(paging, where, query, designer, membership, startDate, endDate);
			request.setAttribute("total", total);
			
			paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			request.setAttribute("nowPage", Integer.parseInt(nowPage));
			request.setAttribute("cntPerPage", Integer.parseInt(cntPerPage));
			request.setAttribute("paging", paging);
			
			ArrayList<Orders> list = oService.getOrdersListBySearch(paging, where, query, designer, membership, startDate, endDate);
			request.setAttribute("list", list);
			request.setAttribute("sorter", designer);
			
			ArrayList<Designer> dList = dService.getDesignerList();
			request.setAttribute("dList", dList);
			
		} else {
			System.out.println(getClass().getSimpleName() + ">> POST");
			
		}
		
		return url;
	}

}
