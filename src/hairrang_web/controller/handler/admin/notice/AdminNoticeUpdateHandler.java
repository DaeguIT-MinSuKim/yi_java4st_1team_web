package hairrang_web.controller.handler.admin.notice;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Notice;
import hairrang_web.service.NoticeService;

public class AdminNoticeUpdateHandler implements Command {
	private NoticeService service = new NoticeService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "notice/notice_Update.jsp";
		
		if(request.getMethod().equals("GET")) {
			System.out.println("GET");
			int noticeNo = Integer.parseInt(request.getParameter("no"));
			Notice notice = service.selectNoticeByNo(noticeNo);
			System.out.println(notice);
			
			request.setAttribute("notice", notice);
			
			return url;
		}else {
			System.out.println("POST");
			
			int noticeNo = Integer.parseInt(request.getParameter("no"));
			String noticeTitle = request.getParameter("title");
			String noticeContent = request.getParameter("content");
			
			Notice notice = new Notice(noticeNo, noticeTitle, noticeContent);
			int res = service.updateNotice(notice);
			
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=utf-8");
			response.setStatus(HttpServletResponse.SC_ACCEPTED);

			PrintWriter pw = response.getWriter();
			pw.print(res);
			pw.flush();
			
			//안돼
//			response.sendRedirect("noticeList.do");
			return null;
		}
	}

}
