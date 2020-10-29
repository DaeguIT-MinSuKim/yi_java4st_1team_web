package hairrang_web.controller.handler.admin.event;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import hairrang_web.controller.Command;

public class AdminEventAddHandler implements Command {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("get");
			return "event/event_add_form.jsp";
		} else {
			System.out.println("post");

			String name = request.getParameter("name");
			String content = request.getParameter("content");
			String saleRate = request.getParameter("saleRate");
			String start = request.getParameter("start");
			String end = request.getParameter("end");
			String file = request.getParameter("file");
			System.out.println(file); //null이라고 떠야 정상

			
			//다운로드경로
			String savePath = "/event/images";

			//최대 업로드 파일 크기 5MB로 지정
			int uploadFileSizeLimit = 5 * 1024 * 1024;
			String entype = "UTF-8";

			ServletContext context = request.getServletContext();
			System.out.println("context :" + context);
			String uploadFilePath = context.getRealPath(savePath);

			MultipartRequest multi = new MultipartRequest(request, //request 객체
					uploadFilePath, //서버상의 실제 디렉토리
					uploadFileSizeLimit, //최대 업로드 파일 크기
					entype, //인코딩방법
					new DefaultFileRenamePolicy()); //동일한 이름이 존재하면 새로운 이름이 부여됨

			//업로드된 파일의 이름 얻기
			String fileName = multi.getFilesystemName("upload");
			String nowDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date()); //현재시간

			//업로드된 파일 얻기
			File findFile = new File(uploadFilePath + "/" + fileName);

			String realFileName = nowDate + "-" + fileName; //현재시간과 확장자 합치기
			System.out.println("realFileName : " + realFileName);
			String FilegetPath = uploadFilePath + "/" + realFileName;
			File newFile = new File(FilegetPath);

			findFile.renameTo(newFile);//파일명 변경
			
			response.sendRedirect("eventList.do");
		}
		return null;

	}

}
