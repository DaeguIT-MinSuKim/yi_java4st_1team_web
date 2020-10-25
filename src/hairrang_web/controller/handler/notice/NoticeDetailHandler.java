package hairrang_web.controller.handler.notice;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Notice;
import hairrang_web.service.NoticeService;

public class NoticeDetailHandler implements Command {
	private NoticeService service = new NoticeService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url ="notice/noticeDetail.jsp";
		int noticeNo = Integer.parseInt(request.getParameter("no"));
		Notice notice = service.selectNoticeByNo(noticeNo);
		
		ArrayList<Notice> list = service.selectNoticeSide(notice);
		
		request.setAttribute("list", list);
		request.setAttribute("notice", notice);
		return url;
	}

}
