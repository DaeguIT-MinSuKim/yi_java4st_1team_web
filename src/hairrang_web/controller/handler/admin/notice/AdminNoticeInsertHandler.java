package hairrang_web.controller.handler.admin.notice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Notice;
import hairrang_web.service.NoticeService;

public class AdminNoticeInsertHandler implements Command {
	private NoticeService service = new NoticeService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "notice/notice_Insert.jsp";
		
		if(request.getMethod().equals("GET")) {
			System.out.println("GET");
			
			return url;
			
		}else {
			System.out.println("POST");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			Notice notice = new Notice(title, content);
			int res = service.insertNotice(notice);
			
//			안돼
//			response.sendRedirect("noticeList.do");
			return null;
			
		}
	}
}
