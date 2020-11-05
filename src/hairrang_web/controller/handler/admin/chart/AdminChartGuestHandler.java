package hairrang_web.controller.handler.admin.chart;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
			SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");
			
			Date date = new Date();
			String day = format1.format(date);
			
			JSONArray join = service.joinGuestByOneDay(day,day);
			JSONArray gender = service.gender("all");
			JSONArray out = service.guestIncrease(day,day);

			request.setAttribute("join", join);
			request.setAttribute("gender", gender);
			request.setAttribute("out", out);

			return url;
		} else {
			System.out.println("POST");

			String startDate = request.getParameter("startDate");
			String endDate = request.getParameter("endDate");
			System.out.println("==============================================");
			System.out.println("시작날짜"+startDate);
			System.out.println("끝날짜"+endDate);
			
			JSONArray join = service.joinGuestByOneDay(startDate, endDate);
			JSONArray gender = service.gender("all");
			JSONArray out = service.guestIncrease(startDate, endDate);

			request.setAttribute("join", join);
			request.setAttribute("gender", gender);
			request.setAttribute("out", out);

			return url;
		}
	}

}
