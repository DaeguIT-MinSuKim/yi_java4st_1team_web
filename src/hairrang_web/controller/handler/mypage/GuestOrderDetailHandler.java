package hairrang_web.controller.handler.mypage;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dto.Booking;
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
		if(ordersNo == null) {
			response.setContentType("text/html; charset=UTF-8;");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('잘못된 접근입니다');location.href='guestOrder.do';</script>");
			out.flush();
			return null;
		} else {
			int resCheck = service.checkUser(new Orders(Integer.parseInt(ordersNo)), loginUser);
			if(resCheck == 1) {
				Orders orders = service.getOrderOneByOrdersNo(Integer.parseInt(ordersNo));
				request.setAttribute("list", orders);
			} else {
				response.setContentType("text/html; charset=UTF-8;");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('잘못된 접근입니다');location.href='guestOrder.do';</script>");
				out.flush();
				return null;
			}
		}
		
		return "mypage/guest_order_detail.jsp";
	}

}
