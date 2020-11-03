package hairrang_web.controller.handler.mypage;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.dto.Orders;
import hairrang_web.service.OrdersService;

public class GuestOrderDetailHandler implements Command {
	private OrdersService service = new OrdersService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		HttpSession session = request.getSession();
		Guest loginUser = (Guest) session.getAttribute("loginUser");
		
		String ordersNo = request.getParameter("orderNo");
		
		Orders orders = service.getOrderOneByOrdersNo(Integer.parseInt(ordersNo));
		
		request.setAttribute("list", orders);
		return "mypage/guest_order_detail.jsp";
	}

}
