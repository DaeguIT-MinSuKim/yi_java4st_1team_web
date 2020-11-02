package hairrang_web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.dto.Admin;

@WebFilter("/admin/*")
public class AdminLoginCheckFilter implements Filter {

    public AdminLoginCheckFilter() {
    }

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest hRequest = (HttpServletRequest) request;
		HttpServletResponse hResponse = (HttpServletResponse) response;
		
		String url = hRequest.getRequestURI().substring(hRequest.getContextPath().length());
		
		if (hRequest.getRequestURI().contains(".do")) {
			if(!url.equals("/admin/login.do") && !url.equals("/admin/logout.do")) {
				HttpSession session = hRequest.getSession(false);
				boolean isLogin = false;
				
				// 1. session이 존재하는가?
				if(session != null) {
					// 2. 로그인 된 상태인가?
					Admin loginAdmin = ((Admin) session.getAttribute("loginAdmin"));
					if (loginAdmin != null) {
						isLogin = true;
					} 
				}
				System.out.println("1");
				if (isLogin == false) {
					hResponse.sendRedirect("login.do");
					System.out.println("2");
					return;
				}
			}
		}
		
		if(url.equals("/admin/login.do") || url.equals("/admin/logout.do")) {
			if(hRequest.getMethod().equalsIgnoreCase("POST")) {
			}
		}
		System.out.println("3");
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
