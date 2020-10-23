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
		/*	String type = request.getParameter("type");
			System.out.println("type"+type);
			int qnaNo = Integer.parseInt(request.getParameter("no"));
			System.out.println("qnaNo"+qnaNo);
			QnA qna = service.selectResQnaByNo(new QnA(qnaNo));
			System.out.println(request.getHeader("referer").toString());
			
		
			if(request.getMethod().equalsIgnoreCase("GET")) {
				request.setAttribute("type", type);
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
				return url; */
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("GET");
			String no = request.getParameter("no");
			request.setAttribute("no", no);
			return url;
		}else {
			System.out.println("POST");
			int no = Integer.parseInt(request.getParameter("no"));
			String password = request.getParameter("password");
			QnA qna = new QnA();
			qna.setQnaNo(no);
			System.out.println("비밀번호 페이지에서 가져온no"+no);
			qna.setQnaPassword(password);
			System.out.println("비밀번호 페이지에서 가져온password"+password);
			QnA findQna = service.passwordQna(qna);
			if(findQna != null) {
				System.out.println("비밀번호랑 맞은 qna찾음");
				return "qnaDelete.do?no="+no;
			}else {
				System.out.println("비밀번호랑 맞은 qna 못찾음");
				response.sendRedirect("qnaHome.do");
				return null;
			}
		}
	}

}
