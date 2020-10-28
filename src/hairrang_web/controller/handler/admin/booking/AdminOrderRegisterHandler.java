package hairrang_web.controller.handler.admin.booking;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.dto.Orders;
import hairrang_web.service.OrdersService;

public class AdminOrderRegisterHandler implements Command {

	private OrdersService oService;
	
	public AdminOrderRegisterHandler() {
		oService = new OrdersService();
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println(getClass().getSimpleName() + ">> GET");
			
			// get방식으로 접근 불가능(직접 주소창에 입력해 접근한 경우).
			// 주문페이지를 이용해달라는 메시지 띄우는 처리 필요.
			
		} else {
			System.out.println(getClass().getSimpleName() + ">> POST");
			
			Gson gson = new Gson();
			
			Orders newOrders = gson.fromJson(new InputStreamReader(request.getInputStream(), "UTF-8"), Orders.class);
			System.out.println("<json 변환 후 newOrders>\n" + newOrders);
			
			int ordersNo = -1;
			
			// 사용자가 html, script를 수정해 접근할 수도 있으므로 DB단에서 한번 더 검증
			ordersNo = oService.insertOrders(newOrders);
			System.out.println("넣었음");
			
			response.setCharacterEncoding("UTF-8");
			response.setStatus(HttpServletResponse.SC_ACCEPTED);
			
			PrintWriter pw = response.getWriter();
			pw.print(ordersNo); // db에러 0, 성공적으로 insert 됐으면 nextNo 반환
			pw.flush();
			
		}
		
		return null;
	}

}
