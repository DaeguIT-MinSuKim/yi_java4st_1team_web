package hairrang_web.controller.handler.booking;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map.Entry;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import hairrang_web.controller.Command;
import hairrang_web.dto.Designer;
import hairrang_web.dto.Guest;
import hairrang_web.dto.Hair;
import hairrang_web.dto.HairKind;
import hairrang_web.service.BookingService;
import hairrang_web.service.DesignerService;
import hairrang_web.service.HairService;

public class BookingRegisterFormHandler implements Command {

	private BookingService bService;
	private HairService hService;
	private DesignerService dService;
	
	public BookingRegisterFormHandler() {
		bService = new BookingService();
		hService = new HairService();
		dService = new DesignerService();
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("BookingRegisterFormHandler >> GET");

			// 세션으로부터 아이디 얻어오기 (회원만 접근 가능)
			// 로그인 체크 필터로 구현함
			
			HttpSession session = request.getSession();
			Guest loginUser = (Guest) session.getAttribute("loginUser");
			
			List<HairKind> hairList = hService.getHairListAll();
			List<Designer> deList = dService.getDesignerList();
			
			request.setAttribute("hairList", hairList);
			request.setAttribute("deList", deList);
			
			return "booking/booking_register.jsp";
		} else {
			System.out.println("BookingRegisterFormHandler >> POST");
			
			// 파라미터 값 확인
			for (Entry<String, String[]> map : request.getParameterMap().entrySet() ) {
					System.out.println(map.getKey() + " : " + map.getValue());
			}
			
			String kindNo = null;
		
			// 헤어 대분류를 선택했을 때 헤어 소분류값 ajax로 셀렉 박스 리스트 넘기기
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
				
			} else {
				// 페이지 로딩시 헤어 대분류 ajax로 셀렉 박스 리스트 넘기기
				System.out.println("hairkindbox 읽기");
				List<HairKind> hairKindList = hService.getHairListAll();
				System.out.println(hairKindList);
				
				Gson gson = new Gson();
				String result = gson.toJson(hairKindList, new TypeToken<List<HairKind>>(){}.getType());
				System.out.println(result);
				
				response.setCharacterEncoding("UTF-8");
				response.setContentType("Application/json");
				response.setStatus(HttpServletResponse.SC_ACCEPTED);
				
				PrintWriter pw = response.getWriter();
				pw.print(result);
				pw.flush();
			}
			
			return null;
		}
	}
}
