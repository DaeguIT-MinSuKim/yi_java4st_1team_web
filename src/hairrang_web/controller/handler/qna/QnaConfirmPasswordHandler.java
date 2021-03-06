package hairrang_web.controller.handler.qna;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.JOptionPane;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.dto.QnA;
import hairrang_web.service.QnaService;

public class QnaConfirmPasswordHandler implements Command {
	private QnaService service = new QnaService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qna/qnaConfirmPassword.jsp";

		int qnaNo = Integer.parseInt(request.getParameter("no"));
		QnA qna = service.selectQnaByNo(qnaNo);
		request.setAttribute("qnaNo", qnaNo);

		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("QnaDetailFormHandler >> GET");
			
			// 공개글이거나 자기 글이어면 바로 Detail로 쏘면 되고
			// 아니면 qnaConfirmPassword.jsp 에서 비밀번호 입력받아야 함.

			HttpSession session = request.getSession();
			Guest loginUser = (Guest) session.getAttribute("loginUser");
			

			String secret = request.getParameter("secret");
			System.out.println(secret);

			//로그인을 했고 로그인 아디이랑 게시물 아이디가 맞거나 또는 비밀글이 아닐때
			// 1. 비밀글인가? 확인받기
			// 1-1. 비밀글이다!
			// 		2-1. 로그인돼있으면 로그인 유저랑 글 유저가 같은지 검사 ->  qnaConfirmPassword.jsp
			// 			3-1. 같다 : qnaDetail.jsp
			//			3-2. 다르다 : 접근 불가 꺼져 -> list
			//		2-2. 로그인 안 돼있다. 글이 회원이 쓴 글인지, 비회원이 쓴 글인지 검사
			//			3-1. 회원이 썼다 : 접근 불가 꺼져 -> list로 백백
			//			3-2. 비회원이 썼다 : 비번 검사 qnaConfirmPassword.jsp
			// 1-2. 비밀글이 아니다. -> qnaDetail.jsp
			
			//
			if (secret.equalsIgnoreCase("n")) {
				System.out.println("비밀글이 아닐때");
				return "qnaDetail.do";
				
			}else {
				// 로그인 된 상태
				if(loginUser != null) {
					// 글 주인이냐?
					System.out.println(loginUser);
					System.out.println(qna);
					if((loginUser.getGuestId()).equals(qna.getGuestId().getGuestId())) {
						request.setAttribute("confirmRes", "y");
						System.out.println("비밀글이고 로그인이 되어있고 로그인인되어있는 회원과 글회원이 맞을때");
						return "qnaDetail.do";
					} else {
						// list
						System.out.println("비밀글이고 로그인이 되어있고 로그인인되어있는 회원과 글회원이 맞지않을때");
						response.setContentType("text/html; charset=UTF-8");
						PrintWriter writer = response.getWriter();
						writer.println("<script>alert('다른회원의 비회원 글입니다.'); location.href='qnaHome.do';</script>");
						writer.close();
//						response.sendRedirect("qnaHome.do");
						return null;
					}
				} else {
					// 비회원인 상태
					System.out.println(qna);
					if(qna.getGuestId().getGuestId() != null) {
						// 회원이 쓴 글에 접근
						// 빠꾸
						System.out.println("비밀글이고 비회원이고 게시글의 회원의 아이디가 있을때");
						response.setContentType("text/html; charset=UTF-8");
						PrintWriter writer = response.getWriter();
						writer.println("<script>alert('회원의 비회원 글입니다.'); location.href='qnaHome.do';</script>");
						writer.close();
						response.sendRedirect("qnaHome.do");
						return null;
					} else {
						// 비번 검사 받아
						//비회원은 빠구
						System.out.println("비밀글이고 비회원이고 게시글의 회원의 아이디가 없을때");
						return null;
					}
				}
			}
			/*else if (secret == null || loginUser.equals(qna.getGuestId())) {
				url = "qndDetail.do";
				return url;
			}*/
		} else {
			System.out.println("QnaDetailFormHandler >> POST");

			// QnaConfirmPassword.jsp 에서 비밀번호 입력 받은 후,
			// 파라미터로 넘어온 글 비밀번호가 찐 비번이랑 맞냐? 확인하는 기능.
			// 맞으면 Detail로 틀리면 다시 qnaConfirmPassword.jsp
			String pwd = request.getParameter("pwd");
			if(qna.getQnaPassword().equals(pwd)) {
				request.setAttribute("confirmRes", "y");
				url = "qnaDetail.do";
				return url;
			}else {
				JOptionPane.showMessageDialog(null, "비밀번호가 맞지 않습니다. 다시 입력해주세요");
				url="qna/qnaConfirmPassword.jsp";
				return url;
			}
		}
	}

}
