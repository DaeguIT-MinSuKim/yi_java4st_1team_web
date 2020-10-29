package hairrang_web.controller.handler.admin.qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.QnA;
import hairrang_web.service.QnaService;

public class AdminQnaDeleteHandler implements Command {
	private QnaService service = new QnaService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qnaList.do";
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("GET");
			int no = Integer.parseInt(request.getParameter("no"));
			int res = service.deleteQna(new QnA(no));
			System.out.println(res);
			
			response.sendRedirect(url);
			return null;
			
		}else {
			System.out.println("POST");
		}
		return null;
	}

}
