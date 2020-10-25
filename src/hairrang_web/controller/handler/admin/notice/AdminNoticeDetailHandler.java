package hairrang_web.controller.handler.admin.notice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Notice;
import hairrang_web.service.NoticeService;
import sun.print.resources.serviceui;

public class AdminNoticeDetailHandler implements Command {
	private NoticeService service = new NoticeService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "/admin/notice/notice_Detail.jsp";
		int noticeNo = Integer.parseInt(request.getParameter("no"));
		Notice notice = service.selectNoticeByNo(noticeNo);
		
		request.setAttribute("notice", notice);
		return url;
	}

}
