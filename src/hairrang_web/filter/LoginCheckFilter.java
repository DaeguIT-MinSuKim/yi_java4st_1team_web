package hairrang_web.filter;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.dto.Guest;

@WebFilter(
		urlPatterns = {"*.do"},
		initParams = {
				@WebInitParam(name="configFile",
						value="/WEB-INF/loginCheckHandler.txt")
		})
public class LoginCheckFilter implements Filter {

	private List<String> filterList = new ArrayList<>();

	public LoginCheckFilter() {
    }

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		// 1. 로그인 체크가 필요하냐?
		if (isNeededLoginCheck((HttpServletRequest) request, (HttpServletResponse)response)) {
			HttpSession session = ((HttpServletRequest) request).getSession();
			boolean isLogin = false;
			
			// 2. 로그인 된 상태인가?
			Guest loginUser = ((Guest) session.getAttribute("loginUser"));
			if (loginUser != null) {
				isLogin = true;
			} 
		
			if (isLogin == false) {
				// 로그인이 필요한 서비스에서 로그인이 되어 있지 않음 -> redirection할 경로 세션에 저장 후, login.do로 redirection
				
				System.out.println("thisUri" + getThisURI(request, response));
				session.setAttribute("redirectURI", getThisURI(request, response));
				
				((HttpServletResponse) response).sendRedirect("login.do");
				return;
			}
		}
		
		chain.doFilter(request, response);
		
	}

	public void init(FilterConfig fConfig) throws ServletException {
		String configFile = fConfig.getInitParameter("configFile");
		try(InputStreamReader isr = new InputStreamReader(fConfig.getServletContext().getResourceAsStream(configFile));
				BufferedReader br = new BufferedReader(isr)) {
			
			String line = null;
			while((line = br.readLine()) != null) {
				filterList.add(line);
			}
			
			filterList.stream().forEach(System.out::println);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private boolean isNeededLoginCheck(ServletRequest request, ServletResponse response) throws ServletException, IOException {
		return filterList.contains(getThisURI(request, response));
	}
	
	private String getThisURI(ServletRequest request, ServletResponse response) {
		String command = ((HttpServletRequest) request).getRequestURI();
		String contextPath = ((HttpServletRequest) request).getContextPath();
		
		if(command.indexOf(contextPath) == 0 ) {
			command = command.substring(contextPath.length() + 1); // '/' 뗀 경로. (예: index.do)
		}
		
		return command;
	}
}
