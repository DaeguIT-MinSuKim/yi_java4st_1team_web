package hairrang_web.controller.handler.admin.order;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Orders;
import hairrang_web.service.OrdersService;

public class AdminOrderListHandler implements Command {
	
	private OrdersService oService;
			
	public AdminOrderListHandler() {
		oService = new OrdersService();
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		String url = "/admin/order/order_list.jsp";
		
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println(getClass().getSimpleName() + ">> GET");
			
			ArrayList<Orders> list = oService.getOrdersListAll();
			
			request.setAttribute("list", list);
			
		} else {
			System.out.println(getClass().getSimpleName() + ">> POST");
			
		}
		
		return url;
	}

}
