package hairrang_web.controller.handler.qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.QnA;
import hairrang_web.service.QnaService;

public class QnaDetailHandler implements Command {
	private QnaService service = new QnaService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qna/qnaDetail.jsp";
		int qnaNo = Integer.parseInt(request.getParameter("no"));
		System.out.println("번호====================="+qnaNo);
		QnA qna = service.selectQnaByNo(qnaNo);
		System.out.println("찾았냐~~~~~~~~~~~~~~~~~"+qna);
		request.setAttribute("qna", qna);
		return url;
	}

}
