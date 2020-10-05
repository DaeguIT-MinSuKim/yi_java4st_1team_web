package hairrang_web.controller.handler.qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.QnA;
import hairrang_web.service.QnaService;

public class QnaDeleteHandler implements Command {
	private QnaService service = new QnaService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qnaHome.do";
		int qnaNo = Integer.parseInt(request.getParameter("no"));
		int res = service.deleteQna(new QnA(qnaNo));
		System.out.println("delete"+res);
		return url;
	}

}
