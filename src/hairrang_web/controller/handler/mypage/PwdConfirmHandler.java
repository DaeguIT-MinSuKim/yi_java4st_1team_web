package hairrang_web.controller.handler.mypage;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.service.GuestService;
import oracle.net.aso.l;

public class PwdConfirmHandler implements Command {
	private GuestService service = new GuestService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {

		HttpSession session = request.getSession();
		Guest loginUser = (Guest) session.getAttribute("loginUser");

		String page = request.getHeader("referer"); // 이전페이지 주소가져옴
		String info_page = "http://localhost:8080/hairrang_web/infoUpdate.do";
		String pwd_page = "http://localhost:8080/hairrang_web/pwdUpdate.do";
		// pwdconfirm handler는 하나이고 이전 주소에 따라 다른 페이지 return

		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("get");
			return "mypage/pwd_confirm.jsp";
		} else {
			System.out.println("post");
			String pwd = request.getParameter("pwd").trim();

//			// 로그인 풀리거나 안하고 진입시
//			if (loginUser == null) {
//				request.setAttribute("message", -2);
//			} ->불가능처리완료

			Guest guest = service.selectGuestById(loginUser);

			if (guest.getGuestPwd().equals(pwd)) {
				if (page.equals(info_page)) {
					request.setAttribute("id", loginUser.getGuestId());
					request.setAttribute("name", loginUser.getGuestName());
					request.setAttribute("birth", loginUser.getGuestBirthday());
					request.setAttribute("gender", loginUser.getGuestGender());
					request.setAttribute("email", loginUser.getGuestEmail());
					request.setAttribute("phone", loginUser.getGuestPhone());
					request.setAttribute("infoYn", loginUser.getInfoYn());
					return "mypage/guest_info_form.jsp";
				} else if (page.equals(pwd_page)){
					request.setAttribute("id", loginUser.getGuestId());
					return "mypage/guest_pwd_form.jsp";
				}else {
					return "mypage/guest_delete_form.jsp";
				}
			} else {
				request.setAttribute("message", -1);
			}

			if (page.equals(info_page)) {
				return "mypage/guest_info_form.jsp";
			} else if (page.equals(pwd_page)){
				return "mypage/guest_pwd_form.jsp";
			}else {
				return "mypage/guest_delete_form.jsp";
			}

		}

	}

}
