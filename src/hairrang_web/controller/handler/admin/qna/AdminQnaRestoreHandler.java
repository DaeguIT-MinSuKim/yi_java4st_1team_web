package hairrang_web.controller.handler.admin.qna;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.service.QnaService;

public class AdminQnaRestoreHandler implements Command {
	QnaService service = new QnaService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qnaList.do";
		
		int res = 0;
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("GET");
			String no = request.getParameter("no");
			System.out.println("복원할 번호 :"+no);
			res = service.updateRestoreQna(no);
			System.out.println(res);
			return url;
		}else {
			System.out.println("POST");
			
			String[] array = request.getParameterValues("string[]");
			System.out.println(Arrays.toString(array));
			
			for(String no : array) {
				res = service.updateRestoreQna(no);
				System.out.println(res);
			}
			return url;
		}
		
		
	}

}
