package hairrang_web.controller.handler.admin.order;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Orders;
import hairrang_web.service.OrdersService;

public class AdminOrderDetailHandler implements Command {

	private OrdersService oService;
	
	public AdminOrderDetailHandler() {
		oService = new OrdersService();
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		String url = "order/order_detail.jsp";
		
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println(getClass().getSimpleName() + ">> GET");
			
			if(request.getParameter("no") != null) {
				int no = Integer.parseInt(request.getParameter("no"));
				Orders order = oService.getOrderOneByOrdersNo(no);

				request.setAttribute("order", order);
			}
			
		} else {
			System.out.println(getClass().getSimpleName() + ">> POST");
			
		}
		
		return url;
	}

}
