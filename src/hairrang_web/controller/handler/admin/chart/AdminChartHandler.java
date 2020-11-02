package hairrang_web.controller.handler.admin.chart;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;

import hairrang_web.controller.Command;
import hairrang_web.service.ChartService;
import hairrang_web.service.QnaService;

public class AdminChartHandler implements Command {
	private ChartService service = new ChartService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "chart/chart_list.jsp";

		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("GET");

			JSONArray qnaArray  = service.selectOnlyQnA();
			System.out.println(qnaArray);
			
			request.setAttribute("qnaArray", qnaArray);
			
			return url;
		} else {
			System.out.println("POST");
			
			//response.setCharacterEncoding("UTF-8");
			//response.setStatus(HttpServletResponse.SC_ACCEPTED);

			
//			QnaModel qnaModel = new QnaModel();
//			System.out.println(qnaModel.findAll());
//			
//			Gson gson = new Gson();
//			response.setContentType("application/json");
//			PrintWriter out = response.getWriter();
//			out.println(gson.toJson(qnaModel.findAll()));
//			out.println(gson.toJson(map));
			
			return url;
		}
	}

}
