package hairrang_web.controller.handler.admin.notice;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.service.NoticeService;

public class AdminNoticeRestoreHandler implements Command {
	NoticeService service = new NoticeService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qnaList.do";
		int res = 0;
		
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("GET");
			
			//복원할 번호
			String no = request.getParameter("no");
			
			res = service.RestoreNotice(no);
			System.out.println(res);
			
			return url;
		}else {
			System.out.println("POSt");
			
			String[] array = request.getParameterValues("string[]");
			System.out.println(Arrays.toString(array));
			
			for(String no : array) {
				res = service.RestoreNotice(no);
				System.out.println(res);
			}
			return url;
		}
		
		
	}

}
