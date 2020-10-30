package hairrang_web.controller.handler.admin.event;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import hairrang_web.controller.Command;
import hairrang_web.dto.Event;
import hairrang_web.service.EventService;

public class AdminEventAddHandler implements Command {
	private EventService service = new EventService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("get");
			return "event/event_add_form.jsp";
		} else {
			System.out.println("post");
			HttpSession session = request.getSession();

			
			//파일업로드
			int sizeLimit = 5 * 1024 * 1024;
			String savePath = "event/images";
			ServletContext context = session.getServletContext();
			String uploadFilePath = context.getRealPath(savePath);

			MultipartRequest multi = new MultipartRequest(request, // 1. 요청 객체
					uploadFilePath, // 2. 업로드될 파일이 저장될 파일 경로명
					sizeLimit, // 3. 업로드될 파일의 최대 크기(5Mb)
					"UTF-8", // 4. 인코딩 타입 지정
					new DefaultFileRenamePolicy() // 5. 덮어쓰기를 방지 위한 부분
			); // 이 시점을 기해 파일은 이미 저장이 되었다
			
			
			
			String name = multi.getParameter("name");
			String content = multi.getParameter("content");
			String saleRate = multi.getParameter("saleRate");
			LocalDate start = LocalDate.parse(multi.getParameter("start"));
			LocalDate end = LocalDate.parse(multi.getParameter("end"));
			String file = multi.getFilesystemName("file");
		
			String fileRename = "admin/event/images/" + file; 
			Event e = new Event(name, Double.parseDouble(saleRate)/100, start, end, fileRename, content, null);
			int res = service.insertEvent(e);
			System.out.println(res);
			
			response.sendRedirect("eventList.do");
		}
		return null;

	}

}
