package hairrang_web.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebFilter("/login.do")
public class BeforeLoginPageFilter implements Filter {

	public BeforeLoginPageFilter() {
	}

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest hRequest = (HttpServletRequest) request;
		/*
		String prevURI = hRequest.getHeader("referer");
		prevURI = prevURI.substring(prevURI.indexOf(hRequest.getContextPath()) + hRequest.getContextPath().length());
		System.out.println("referer: " + prevURI);
		
		// 비로그인 상태에서 접근 불가한 uri의 경우 login.do로 redirection 됨.
		// 그 반대의 경우 -> 직접 login 페이지로 들어온 경우 redirectURI 쿠키를 지워준다.
		if(!prevURI.equals("/login.do")) {
		//			System.out.println("(4. 직접 로그인페이지에 들어옴 -> 세션 지움)");
		//			hRequest.getSession().removeAttribute("redirectURI");
		
			
			removeCookie((HttpServletResponse) response);
			
			for(Cookie c : hRequest.getCookies()) {
				System.out.println(c.getName() + " : " + c.getValue());
			}
			
		}
		*/
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

	private void removeCookie(HttpServletResponse response) {
		Cookie cookie = new Cookie("redirectURI", null);
		cookie.setMaxAge(0);
		response.addCookie(cookie);
	}
}
