package hairrang_web.controller.handler.admin.chart;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import hairrang_web.controller.Command;
import hairrang_web.service.ChartService;

public class AdminChartQnaHandler implements Command {
	ChartService service = new ChartService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "chart/qna_Chart.jsp";

		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("GET");

			JSONArray qna = service.selectOnlyQnA("all");
			JSONArray res = service.QnAByRes("all");
			JSONArray secret = service.QnABySecret("all");
			
			
			request.setAttribute("qna", qna);
			request.setAttribute("res", res);
			request.setAttribute("secret", secret);

			return url;
		} else {
			System.out.println("POST");
			
			String year = request.getParameter("year");
			System.out.println("=================="+year);
			
			JSONArray qna = service.selectOnlyQnA(year);
			JSONArray res = service.QnAByRes(year);
			JSONArray secret = service.QnABySecret(year);
			
			request.setAttribute("qna", qna);
			request.setAttribute("res", res);
			request.setAttribute("secret", secret);
			
			return url;
		}
	}

}
