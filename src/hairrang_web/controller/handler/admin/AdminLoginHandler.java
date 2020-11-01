package hairrang_web.controller.handler.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dto.Admin;
import hairrang_web.service.AdminService;

public class AdminLoginHandler implements Command {

	private AdminService aService;
	
	public AdminLoginHandler() {
		aService = new AdminService();
	}
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println(getClass().getSimpleName() + ">> GET");
			
			String url = "/admin/admin_login.jsp";
			return url;
		} else {
			System.out.println(getClass().getSimpleName() + ">> POST");
			
			String id = request.getParameter("adminId");
			String pwd = request.getParameter("adminPwd");
			
			if(aService.checkPwd(id, pwd) == 1) {
				Admin loginAdmin = aService.getAdminInfoById(new Admin(id));
				HttpSession session = request.getSession();
				session.setAttribute("loginAdmin", loginAdmin);
				
				response.setCharacterEncoding("UTF-8");
				response.setStatus(HttpServletResponse.SC_ACCEPTED);
				
				response.sendRedirect("main.do");
			} else {
				response.setCharacterEncoding("UTF-8");
				response.setStatus(HttpServletResponse.SC_ACCEPTED);
				
				PrintWriter pw = response.getWriter();
				pw.println("<script>alert('잘못된 로그인 정보입니다.');</script>");
				pw.flush();
				response.sendRedirect("login.do");
			}
			return null;
		}
	}
}
