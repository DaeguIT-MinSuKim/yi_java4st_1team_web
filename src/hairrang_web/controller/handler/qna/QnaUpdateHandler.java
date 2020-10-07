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
		String url = "qnaList.do";
		int qnaNo = Integer.parseInt(request.getParameter("no"));
		
		System.out.println("번호머냐"+qnaNo);
		
		if (request.getMethod().equals("GET")) {
			QnA qna = service.selectQnaByNo(qnaNo);
			request.setAttribute("qna", qna);
			return "qna/qnaUpdate.jsp";
			
		} else {
			
			System.out.println("POST");
			QnA qna = new QnA();
			qna.setQnaNo(qnaNo);
			String content = request.getParameter("content");
			qna.setQnaContent(content);
			int res = service.updateQna(qna);
			
			System.out.println("뭐고" + res);

			response.sendRedirect(url);
			return null;
		}
	}

}
