package hairrang_web.controller.handler.event;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Event;
import hairrang_web.service.EventService;

public class EventDetailHandler implements Command {
	EventService service = new EventService();
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "event/eventDetail.jsp";
		
		int eventNo = Integer.parseInt(request.getParameter("eno"));
		Event event = new Event(eventNo); 
		Event findEvent = service.selectEventByNo(event);
		ArrayList<Event> list = service.selectEventSide(findEvent);

		request.setAttribute("list", list);
		request.setAttribute("event", findEvent);
		return url;
	}

}
