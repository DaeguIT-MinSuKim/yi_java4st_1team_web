package hairrang_web.controller.handler.admin.order;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Designer;
import hairrang_web.dto.Orders;
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
			
			System.out.println("> 파라미터 확인");
			
			Paging paging = new Paging();
			
			String nowPage = request.getParameter("nowPage");
			String cntPerPage = request.getParameter("cntPerPage");
			String where = request.getParameter("where");
			String query = request.getParameter("query");
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
			
			if(designer != null) {
				if(designer.equals("")) {
					designer = null;
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
			
			int total = oService.getTotalCountBySearch(paging, where, query, designer);
			request.setAttribute("total", total);
			
			paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			request.setAttribute("nowPage", Integer.parseInt(nowPage));
			request.setAttribute("cntPerPage", Integer.parseInt(cntPerPage));
			request.setAttribute("paging", paging);
			System.out.println(paging);
			
			ArrayList<Designer> dList = dService.getDesignerList();
			request.setAttribute("dList", dList);
			
			ArrayList<Orders> list = oService.getOrdersListBySearch(paging, where, query, designer);
			request.setAttribute("list", list);
			request.setAttribute("sorter", designer);
			
		} else {
			System.out.println(getClass().getSimpleName() + ">> POST");
			
		}
		
		return url;
	}

}
