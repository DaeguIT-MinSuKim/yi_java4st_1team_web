package hairrang_web.controller.handler.admin.qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.QnA;
import hairrang_web.service.QnaService;

public class AdminQnaDetailHandler implements Command {
	QnaService service = new QnaService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qna/qna_Detail.jsp";
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("GET");
			int no = Integer.parseInt(request.getParameter("no"));
			QnA qna = service.selectQnaByNo(no);
			QnA qnaResult = service.selectResQnaByNo(new QnA(no));
			
			request.setAttribute("qna", qna);
			request.setAttribute("qnaResult", qnaResult);
			
			return url;
		}else {
			System.out.println("POST");
		}
		return null;
	}

}
