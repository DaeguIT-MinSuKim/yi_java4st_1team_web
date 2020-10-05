package hairrang_web.controller.handler.qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.QnA;
import hairrang_web.service.QnaService;

public class QnaUpdateHandler implements Command {
	private QnaService service = new QnaService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qna/qnaList.do";
		int qnaNo = Integer.parseInt(request.getParameter("no"));
		String qnaContent = request.getParameter("qnaContent");
		QnA qna = new QnA();
		qna.setQnaNo(qnaNo);
		qna.setQnaContent(qnaContent);
		int res = service.updateQna(qna);
		System.out.println("뭐고"+res);
		return url;
	}

}
