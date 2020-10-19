package hairrang_web.controller.handler.qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.QnA;
import hairrang_web.service.QnaService;

public class QnaPasswordHandler implements Command {
	QnaService service = new QnaService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qna/qnaPassword.jsp";
		String type = request.getParameter("type");
		System.out.println("type"+type);
		int qnaNo = Integer.parseInt(request.getParameter("no"));
		QnA qna = service.selectResQnaByNo(new QnA(qnaNo));

		if(request.getMethod().equalsIgnoreCase("GET")) {
			request.setAttribute("qna", qna);
			return url;
		}else {
			if(type.equalsIgnoreCase("d")) {
				url="qnaDelete.do?no="+qnaNo;
			}else {
				url="qnaUpdate.do?no="+qnaNo;
			}
			String pwd = request.getParameter("password");
			if(qna.getQnaPassword().equalsIgnoreCase(pwd)) {
				
			}
			return url; 
		}
		
	}

}
