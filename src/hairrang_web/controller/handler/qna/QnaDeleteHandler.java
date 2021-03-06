package hairrang_web.controller.handler.qna;

import java.io.IOException;
import java.io.PrintWriter;

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
		System.out.println("QnaDeleteHandler");
		String url = "qnaHome.do";
		
		//qnaNo를 가져와서 서비스를 통해서 db의 qna를 삭제해줍니다
		int qnaNo = Integer.parseInt(request.getParameter("no"));
		int res = service.deleteQna(new QnA(qnaNo));
		System.out.println("delete"+res);
		
		
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");
		response.setStatus(HttpServletResponse.SC_ACCEPTED);

		PrintWriter pw = response.getWriter();
		pw.print(res);
		pw.flush();
		
		return null;
	}

}
