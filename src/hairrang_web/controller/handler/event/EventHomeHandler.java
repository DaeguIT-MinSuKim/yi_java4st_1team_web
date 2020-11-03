package hairrang_web.controller.handler.event;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Event;
import hairrang_web.service.EventService;

public class EventHomeHandler implements Command {
	EventService service = new EventService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "event/eventHome.jsp";
		
		//디비에서 이벤트 정보 받아오기
		ArrayList<Event> list = service.selectEventAllForBoard();
		request.setAttribute("list", list);
		return url;
	}

}
