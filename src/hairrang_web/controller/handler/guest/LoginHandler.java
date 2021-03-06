package hairrang_web.controller.handler.guest;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.service.GuestService;

public class LoginHandler implements Command{
	private GuestService service = new GuestService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("LoginHandler >> get");

			return "member/login.jsp";
			
		} else {
			System.out.println("LoginHandler >> post");
			
			HttpSession session = request.getSession();
			String id = request.getParameter("id");
			String pwd = request.getParameter("pwd");
			
			Guest g = service.selectGuestById(new Guest(id));
			System.out.println("로그인 시도할 회원 정보: " + g);
			System.out.println("입력한 비밀번호: " + pwd);
			
			// 아이디가 존재하는 경우, 비밀번호와 일치하는지 확인 후 redirect
			if(g!=null) {
				if(g.getGuestPwd().equals(pwd) && !g.getDelYn().equals("y")) {
					session.removeAttribute("id");
					session.setAttribute("loginUser", g);
					
					// (1) session이용
					String redirectURI = (String) session.getAttribute("redirectURI");
					
					// (2) cookie이용
					/*
					String redirectURI = null;
					Cookie[] cookies = request.getCookies();
					for(Cookie c : cookies) {
						if (c.getName().equals("redirectURI")) {
							redirectURI = c.getValue();
							System.out.println(redirectURI);
						}
					}
					*/
					System.out.println("로그인 성공 후 리다이렉트할 주소: " + redirectURI);
					
					if(redirectURI != null) {
						session.removeAttribute("redirectURI");
						response.sendRedirect(redirectURI);
					} else {
						response.sendRedirect("index.do");
					}
				} else { // 비밀번호 불일치
					return "member/login_fail.jsp";
				}
			}else { // 아이디 없음
				return "member/login_fail.jsp";
			}
		}
		return null;
	}

}
