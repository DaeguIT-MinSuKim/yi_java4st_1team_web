package hairrang_web.controller.handler.qna;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.dto.QnA;
import hairrang_web.service.QnaService;

public class QnaWriteHandler implements Command {
	private QnaService service = new QnaService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qna/qnaWrite.jsp";
		HttpSession session = request.getSession();
		Guest loginUser = new Guest("null");
		loginUser = (Guest) session.getAttribute("loginUser");
		QnA qna = new QnA();

		// 만약 get방식이면 qna작성 페이지로 이동하는곳
		if (request.getMethod().equals("GET")) {
			System.out.println("GET");

			ServletContext context = request.getServletContext();
			System.out.println(context);

			/*
			// 만약 로그인이 되어있지 안하면 url에 qnaWrite.do의 경로를 저장한채로 login.do로 넘기기
			if (loginUser == null) {
				return "login.do?url='qnaWrite.do'";
			}
			*/

			return url;
		} else {
			// 방식이 post방식일 경우 제목과 내용을 가지고와서 isnert하는 곳
			System.out.println("POST");
			PrintWriter out = response.getWriter();

			//다운로드경로
			String savePath = "qna/upload";

			//최대 업로드 파일 크기 5MB로 지정
			int uploadFileSizeLimit = 5 * 1024 * 1024;
			String entype = "UTF-8";

			ServletContext context = request.getServletContext();
			System.out.println("context :" + context);
			String uploadFilePath = context.getRealPath(savePath);
			System.out.println("서버상의 실제 디렉토리 :");
			System.out.println(uploadFilePath);

			File isDir = new File(uploadFilePath);
			if (!isDir.isDirectory()) {
				//디렉토리 생성 메서드
				isDir.mkdirs();
				System.out.println("created directory successfully!");
			}

			try {
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

				//제목 내용 파일경로 db에 insert하는곳
				String title = multi.getParameter("title");
				String content = multi.getParameter("content");
				String secretPwd = multi.getParameter("secretPwd");
				String secretChecked = multi.getParameter("secret");
				System.out.println("비밀번호 체크: " + secretChecked);
				if (secretChecked != null) {
					secretChecked = "y";
				} else {
					secretChecked = "n";
				}

				System.out.println("loginUser" + loginUser);
				System.out.println("secretPwd" + secretPwd);
				qna.setGuestId(loginUser);
				qna.setQnaTitle(title);
				qna.setQnaContent(content);
				qna.setQnaFile(realFileName);
				if (secretChecked.contentEquals("y")) {
					qna.setQnaPassword(secretPwd);
				}
				qna.setQnaSecret(secretChecked);
				System.out.println("insert 하기전");
				service.insertQna(qna);

			} catch (Exception e) {
				e.printStackTrace();

			}
			/*?nowPage=1&cntPerPage=5*/
			response.sendRedirect("qnaHome.do");
			return null;
		}

	}

}
