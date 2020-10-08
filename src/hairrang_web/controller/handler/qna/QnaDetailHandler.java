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
		
		//리스트에 저정되어있는 no를 통해서 db에서 불러줍니다.
		int qnaNo = Integer.parseInt(request.getParameter("no"));
		QnA qna = service.selectQnaByNo(qnaNo);
		request.setAttribute("qna", qna);
		return url;
	}

}
