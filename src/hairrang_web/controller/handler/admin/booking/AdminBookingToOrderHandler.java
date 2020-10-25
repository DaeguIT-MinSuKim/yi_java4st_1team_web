package hairrang_web.controller.handler.admin.booking;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import hairrang_web.controller.Command;
import hairrang_web.dto.Booking;
import hairrang_web.dto.Designer;
import hairrang_web.dto.Hair;
import hairrang_web.dto.HairKind;
import hairrang_web.service.BookingService;
import hairrang_web.service.DesignerService;
import hairrang_web.service.HairService;

public class AdminBookingToOrderHandler implements Command {

	private BookingService bService;
	private DesignerService dService;
	private HairService hService;
	
	public AdminBookingToOrderHandler() {
		bService = new BookingService();
		dService = new DesignerService();
		hService = new HairService();
	}

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)	throws IOException, ServletException {
		
		String url = "/admin/booking/booking_to_order.jsp";
		
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println(getClass().getSimpleName() + ">> GET");
			
			int no = Integer.parseInt(request.getParameter("no"));
			Booking booking = bService.getBookingByBookingNo(new Booking(no));
			ArrayList<Designer> deList = dService.getDesignerList();
			ArrayList<HairKind> hairKindList = hService.getHairListAll();
			ArrayList<Booking> todayBookingList = bService.getTodayBookingList();
			
			request.setAttribute("booking", booking);
			request.setAttribute("deList", deList);
			request.setAttribute("hairKindList", hairKindList);
			request.setAttribute("todayBookingList", todayBookingList);
			
		} else {
			System.out.println(getClass().getSimpleName() + ">> POST");
			
			String kindNo = null;
			String bookNo = null;
			
			if((kindNo = request.getParameter("kindNo")) != null) {
				System.out.println("hairbox 읽기");
				HairKind hairKind = hService.getHairKindInfo(Integer.parseInt(kindNo));
				System.out.println(hairKind);
				
				Gson gson = new Gson();
				String result = gson.toJson(hairKind.getHairList(), new TypeToken<List<Hair>>(){}.getType());
				System.out.println(result);
				
				response.setCharacterEncoding("UTF-8");
				response.setContentType("Application/json");
				response.setStatus(HttpServletResponse.SC_ACCEPTED);
				
				PrintWriter pw = response.getWriter();
				pw.print(result);
				pw.flush();
				
				return null;
			} else if ((bookNo = request.getParameter("bookNo")) != null) {
				System.out.println("bookNo 데이터 가져오기");
				System.out.println(bookNo);
				Booking booking = bService.getBookingByBookingNo(new Booking(Integer.parseInt(bookNo)));
				
				Gson gson = new Gson();
				String result = gson.toJson(booking, new TypeToken<Booking>() {}.getType());
				System.out.println(result);
				
				response.setCharacterEncoding("UTF-8");
				response.setContentType("Application/json");
				response.setStatus(HttpServletResponse.SC_ACCEPTED);
				
				PrintWriter pw = response.getWriter();
				pw.print(result);
				pw.flush();
				
				return null;
			}
		}

		return url;
		
	}

}
