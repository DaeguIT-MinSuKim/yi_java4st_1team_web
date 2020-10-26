package hairrang_web.controller.handler.admin.notice;

import java.io.IOException;
import java.util.Arrays;
import java.util.Map.Entry;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Notice;
import hairrang_web.service.NoticeService;
public class AdminNoticeDeleteHandler implements Command {
	private NoticeService serivce = new NoticeService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if(request.getMethod().equals("GET")) {
			System.out.println("GET");
			
			for (Entry<String, String[]> map : request.getParameterMap().entrySet() ) {
				System.out.println(map.getKey() + " : " + map.getValue());
			}
			
			int noticeNo = Integer.parseInt(request.getParameter("no"));
			int res = serivce.delelteNotice(new Notice(noticeNo));
			
			System.out.println(res);
			
			response.sendRedirect("noticeList.do");
			return null;
		}else {
			System.out.println("POST");
			
			String[] array = request.getParameterValues("string[]");
			System.out.println(Arrays.toString(array));
			
			for(String no : array) {
				int noticeNo = Integer.parseInt(no);
				int res = serivce.delelteNotice(new Notice(noticeNo));
				System.out.println(res);
			}
			
			//안돼
//			response.sendRedirect("noticeList.do");
			return null;
		}
		
	}

}
