package hairrang_web.controller.handler.admin.notice;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import hairrang_web.controller.Command;
import hairrang_web.dto.Notice;
import hairrang_web.service.NoticeService;

public class AdminNoticeInsertHandler implements Command {
	private NoticeService service = new NoticeService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "notice/notice_Insert.jsp";

		if (request.getMethod().equals("GET")) {
			System.out.println("GET");

			return url;

		} else {
			System.out.println("POST");

			// 다운로드경로
			String savePath = "notice/setload";

			// 최대 업로드 파일 크기 5MB로 지정
			int uploadFileSizeLimit = 5 * 1024 * 1024;
			String entype = "UTF-8";

			ServletContext context = request.getServletContext();
			System.out.println("context :" + context);
			String uploadFilePath = context.getRealPath(savePath);
			System.out.println("서버상으 실제 디렉토리 :");
			System.out.println(uploadFilePath);

			File isDir = new File(uploadFilePath);
			if(!isDir.isDirectory()){
			    //디렉토리 생성 메서드
				isDir.mkdirs();
			    System.out.println("created directory successfully!");
			}
			
			try {
				MultipartRequest multi = new MultipartRequest(request, // request 객체
						uploadFilePath, // 서버상의 실제 디렉토리
						uploadFileSizeLimit, // 최대 업로드 파일 크기
						entype, // 인코딩방법
						new DefaultFileRenamePolicy()); // 동일한 이름이 존재하면 새로운 이름이 부여됨

				// 업로드된 파일의 이름 얻기
				String fileName = multi.getFilesystemName("setload");
				System.out.println("fileName : "+fileName);
				String nowDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date()); // 현재시간

				// 업로드된 파일 얻기
				File findFile = new File(uploadFilePath + "/" + fileName);

				
				String realFileName = null;
				if(fileName != null) {
					realFileName = nowDate + "-" + fileName; //현재시간과 확장자 합치기
				}
				System.out.println("realFileName : " + realFileName);
				String FilegetPath = uploadFilePath + "/" + realFileName;
				File newFile = new File(FilegetPath);

				findFile.renameTo(newFile);// 파일명 변경

				// 제목 내용 파일경로 db에 insert하는곳

				String title = multi.getParameter("title");
				String content = multi.getParameter("content");

				Notice notice = new Notice(title, content);
				notice.setNoticeFile(realFileName);

				int res = service.insertNotice(notice);
				
				
//				response.setContentType("text/html; charset=UTF-8"); // 한글설정
//				request.setCharacterEncoding("utf-8"); // 한글설정
//				PrintWriter writer = response.getWriter();
//
//				writer.println("<script type='text/javascript'>");
//				writer.println("function window::onload(){alert('등록이 완료되었습니다.');" // alert() 호출
//						+ "submitReload();}"); // 다른 자바스크립트 메서드 호출
//				writer.println("</script>");
//				writer.flush();
				
				response.sendRedirect("noticeList.do");
				
//				return "noticeList.do";

			} catch (Exception e) {
				e.printStackTrace();

			}
			return null;
		}
	}
}
