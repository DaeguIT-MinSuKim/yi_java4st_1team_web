package hairrang_web.controller.handler.qna;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.dto.QnA;
import hairrang_web.service.QnaService;

public class QnaDetailHandler implements Command {
	private QnaService service = new QnaService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qna/qnaDetail.jsp";

		//리스트에 저정되어있는 no를 통해서 db에서 불러줍니다.
		int qnaNo = Integer.parseInt(request.getParameter("no"));
		QnA qna = service.selectQnaByNo(qnaNo);
		QnA resQna = new QnA();
		if (qna.getQnaResYn().equals("y")) {
			resQna = service.selectResQnaByNo(qna);
		}
		HttpSession session = request.getSession();
		Guest loginUser = (Guest) session.getAttribute("loginUser");

		System.out.println("qna 이름 :" + qna.getGuestId().getGuestId());
		try {
			System.out.println("loginUser 이름 :" + loginUser.getGuestId());
		} catch (Exception e) {
			loginUser = null;
		}

		String secret = request.getParameter("secret");
		request.setAttribute("loginUser", loginUser);
		request.setAttribute("qna", qna);
		request.setAttribute("resQna", resQna);

		if (secret.equalsIgnoreCase("n")) {
			System.out.println("비밀글이 아닐때");
			return "qna/qnaDetail.jsp";

		} else {
			// 로그인 된 상태
			if (loginUser != null) {
				// 글 주인이냐?
				System.out.println(loginUser);
				System.out.println(qna);
				if ((loginUser.getGuestId()).equals(qna.getGuestId().getGuestId())) {
					request.setAttribute("confirmRes", "y");
					System.out.println("비밀글이고 로그인이 되어있고 로그인인되어있는 회원과 글회원이 맞을때");
					return "qna/qnaDetail.jsp";
				} else {
					// list
					System.out.println("비밀글이고 로그인이 되어있고 로그인인되어있는 회원과 글회원이 맞지않을때");
					response.setContentType("text/html; charset=UTF-8");
					PrintWriter writer = response.getWriter();
					writer.println("<script>alert('다른회원의 비회원 글입니다.'); location.href='qnaHome.do';</script>");
					writer.close();
					//					response.sendRedirect("qnaHome.do");
					return null;
				}
			} else {
				// 비회원인 상태
				System.out.println(qna);
				if (qna.getGuestId().getGuestId() != null) {
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
	}

}
