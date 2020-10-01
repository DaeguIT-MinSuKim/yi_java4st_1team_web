package hairrang_web.controller.handler.qna;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.QnA;
import hairrang_web.service.QnaService;

public class QnaListHandler implements Command {
	private QnaService serviece = new QnaService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qna/qnaList.jsp";
		 
		ArrayList<QnA> qnaList = serviece.qnaList();
		request.setAttribute("qnaList", qnaList);
		return url;
	}

}
