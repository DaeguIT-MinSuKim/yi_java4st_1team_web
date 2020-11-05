package hairrang_web.controller.handler.admin.chart;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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
			SimpleDateFormat format1 = new SimpleDateFormat("yyyy");

			Date date = new Date();
			String day = format1.format(date);
			String month = null;
			
//			JSONArray join = service.joinGuestByOneDay(day,day);
//			JSONArray gender = service.gender("all");
			JSONArray out = service.guestIncrease(day, month);

//			request.setAttribute("join", join);
//			request.setAttribute("gender", gender);
			request.setAttribute("out", out);

			return url;
		} else {
			System.out.println("POST");

			String year = request.getParameter("year");
			System.out.println("첫번째"+year);
			String month = request.getParameter("month");
			
			if(year == null) {
				SimpleDateFormat format1 = new SimpleDateFormat("yyyy");

				Date date = new Date();
				year = format1.format(date);
			}
			
			if (month.equals("")) {
				month = null;
			}
			System.out.println("두번째"+year);
			JSONArray out = service.guestIncrease(year, month);
			
			request.setAttribute("month", month);
			request.setAttribute("year", year);
			request.setAttribute("out", out);

			return url;
		}
	}

}
