package hairrang_web.controller.handler.admin.order;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.google.gson.JsonSyntaxException;

import hairrang_web.controller.Command;
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
			
			// 파라미터 값 확인
//			for (Entry<String, String[]> map : request.getParameterMap().entrySet() ) {
//					System.out.println(map.getKey() + " : " + map.getValue());
//			}
			
			
			int bookNo = 0;
			Orders newOrders = null;
			Gson gson = new Gson();
			
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(new InputStreamReader(request.getInputStream(), "UTF-8"));
			
			bookNo = element.getAsJsonObject().get("bookNo").getAsInt();
			newOrders = gson.fromJson(element.getAsJsonObject().get("order"), Orders.class);
			
			System.out.println("<<JSON 변환 후>>");
			System.out.println("bookNo=" + bookNo);
			System.out.println(newOrders);

			
			int ordersNo = -1;
			  
			// 사용자가 html, script를 수정해 접근할 수도 있으므로 DB단에서 한번 더 검증
			ordersNo = oService.insertOrders(newOrders, bookNo);
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
