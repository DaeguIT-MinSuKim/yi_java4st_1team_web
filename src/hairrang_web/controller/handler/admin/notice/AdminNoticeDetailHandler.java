package hairrang_web.controller.handler.admin.notice;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Notice;
import hairrang_web.service.NoticeService;

public class AdminNoticeDetailHandler implements Command {
	private NoticeService service = new NoticeService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "notice/notice_Detail.jsp";
		int noticeNo = Integer.parseInt(request.getParameter("no"));
		Notice notice = service.selectNoticeByNo(noticeNo);
		System.out.println("공지사항 파일 : "+notice.getNoticeFile());
		System.out.println("공지사항 : "+notice);
		

		request.setAttribute("notice", notice);
		return url;
	}

}
