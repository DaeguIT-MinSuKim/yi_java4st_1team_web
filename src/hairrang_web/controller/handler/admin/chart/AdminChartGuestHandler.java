package hairrang_web.controller.handler.admin.chart;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import hairrang_web.controller.Command;
import hairrang_web.service.ChartService;

public class AdminChartGuestHandler implements Command {
	ChartService service = new ChartService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "chart/guest_Chart.jsp";

		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("GET");

			JSONArray join = service.joinGuestByOneDay("all");
			JSONArray gender = service.gender("all");
			JSONArray out = service.GuestByOut("all");

			request.setAttribute("join", join);
			request.setAttribute("gender", gender);
			request.setAttribute("out", out);

			return url;
		} else {
			System.out.println("POST");

			String year = request.getParameter("year");

			JSONArray join = service.joinGuestByOneDay(year);
			JSONArray gender = service.gender(year);
			JSONArray out = service.GuestByOut(year);

			request.setAttribute("join", join);
			request.setAttribute("gender", gender);
			request.setAttribute("out", out);

			return url;
		}
	}

}
