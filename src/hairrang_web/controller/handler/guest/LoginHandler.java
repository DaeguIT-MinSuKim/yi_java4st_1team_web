package hairrang_web.controller.handler.guest;

import java.io.IOException;

import javax.servlet.ServletException;
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
			 System.out.println("get");
			 return "member/login.jsp";
			 
		}else {
			System.out.println("post");
			HttpSession session = request.getSession();
			String id = request.getParameter("id");
			String pwd = request.getParameter("pwd");
			Guest g = service.selectGuestById(new Guest(id));
			System.out.println(g);
			System.out.println(pwd);
			
			if(g!=null) {
				if(g.getGuestPwd().equals(pwd)) {
					session.removeAttribute("id");
					session.setAttribute("loginUser", g);
					response.sendRedirect("index.do");
				}else {
					return "member/login_fail.jsp";
				}
			}else {
				return "member/login_fail.jsp";
			}
		}
		return null;
	}

}
