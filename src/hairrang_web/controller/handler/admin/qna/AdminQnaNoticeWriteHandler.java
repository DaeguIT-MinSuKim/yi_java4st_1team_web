package hairrang_web.controller.handler.admin.qna;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import hairrang_web.controller.Command;
import hairrang_web.dto.Admin;
import hairrang_web.dto.Notice;
import hairrang_web.dto.QnA;
import hairrang_web.service.QnaService;

public class AdminQnaNoticeWriteHandler implements Command {
	private QnaService service = new QnaService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qna/qna_NoticeWrite.jsp";

		if (request.getMethod().equalsIgnoreCase("GET")) {
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

			try {
				MultipartRequest multi = new MultipartRequest(request, // request 객체
						uploadFilePath, // 서버상의 실제 디렉토리
						uploadFileSizeLimit, // 최대 업로드 파일 크기
						entype, // 인코딩방법
						new DefaultFileRenamePolicy()); // 동일한 이름이 존재하면 새로운 이름이 부여됨

				// 업로드된 파일의 이름 얻기
				String fileName = multi.getFilesystemName("setload");
				System.out.println("fileName : " + fileName);
				String nowDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date()); // 현재시간

				// 업로드된 파일 얻기
				File findFile = new File(uploadFilePath + "/" + fileName);

				String realFileName = nowDate + "-" + fileName; // 현재시간과 확장자 합치기
				System.out.println("realFileName : " + realFileName);
				String FilegetPath = uploadFilePath + "/" + realFileName;
				File newFile = new File(FilegetPath);

				findFile.renameTo(newFile);// 파일명 변경

				// 제목 내용 파일경로 db에 insert하는곳

				//지금 세션에 admin저장이 안되어있어서 임시저장
				Admin admin = new Admin("testadmin", "1234", "testadmin");

				HttpSession session = request.getSession();
				session.setAttribute("loginAdmin", admin);

				//							admin = session.getAttribute("loginAdmin");

				String title = multi.getParameter("title");
				String content = multi.getParameter("content");

				QnA qna = new QnA(admin, title, content, realFileName);

				int res = service.insertQnaNotice(qna);
				System.out.println(res);

				response.sendRedirect("qnaList.do");

			} catch (Exception e) {
				e.printStackTrace();

			}
		}
		return null;
	}

}
