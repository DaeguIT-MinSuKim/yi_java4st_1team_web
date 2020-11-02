package hairrang_web.controller.handler.admin.event;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Event;
import hairrang_web.service.CouponService;
import hairrang_web.service.EventService;

public class AdminEventDeleteHandler implements Command {
	private EventService service = new EventService();
	private CouponService cService = new CouponService();
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("delete > get");
			
			int no = Integer.parseInt(request.getParameter("no"));
			//System.out.println("이벤트no" + no);
			int res = service.deleteEvent(new Event(no));
			//이벤트 삭제시 발급된 쿠폰도 다 삭제
			
			
			//System.out.println("결과:" + res);
			
			response.sendRedirect("eventList.do");
		
		}else {
			System.out.println("post");
		}
		return null;
	}

}
