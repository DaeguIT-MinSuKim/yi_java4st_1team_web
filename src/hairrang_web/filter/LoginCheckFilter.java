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
import javax.servlet.http.Cookie;
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
		HttpServletRequest hRequest = (HttpServletRequest) request;
		HttpServletResponse hResponse = (HttpServletResponse) response;
		
		
		// 1. 로그인 체크가 필요하냐?
		if (isNeededLoginCheck(hRequest)) {
			HttpSession session = hRequest.getSession(false);
			System.out.println("1. 로그인 필요함");
			boolean isLogin = false;
			
			// 2. session이 존재하는가?
			if(session != null) {
				// 3. 로그인 된 상태인가?
				Guest loginUser = ((Guest) session.getAttribute("loginUser"));
				if (loginUser != null) {
					isLogin = true;
				} 
			
				if (isLogin == false) {
					// 로그인이 필요한 서비스에서 로그인이 되어 있지 않음 -> redirection할 경로 저장 후, login.do로 redirection
					
					// (1) cookie를 이용한 redirection -> BeforeLoginPageFilter에서 cookie 삭제가 어려움.
					/*
					Cookie cookie = new Cookie("redirectURI", getThisURI(hRequest));
					cookie.setMaxAge(60 * 15); // 15분 유지
					cookie.setPath("/"); // 모든 경로에서 cookie 접근 가능
					
					hResponse.addCookie(cookie);
					*/
					
					// (2) Session을 이용한 redirection
					
					System.out.println("2. redirectURI 세션에 설정함: " + getThisURI(hRequest));
					session.setAttribute("redirectURI", getThisURI(hRequest));
					System.out.println("3. login.do로 리디렉션");
					
					hResponse.sendRedirect("login.do");
					return;
				}
			}
		} else {
			// 다른 페이지 접근시 redirectURI 지워주기
			if (!getThisURI(hRequest).equals("login.do") && !getThisURI(hRequest).equals("logout.do")) {
				HttpSession session = hRequest.getSession(false);
				System.out.println("4. login.do / logout.do가 아님");
//				removeCookie(hResponse);
				if (session != null) {
					System.out.println("(4. redirectURI 지워줌)");
					session.removeAttribute("redirectURI");
				}
			}
		}
		
		chain.doFilter(request, response);
		
	}

	
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO 서버 최초 실행시 필터 초기화 작업. configFile을 읽어 list에 저장해둠.
		
		String configFile = fConfig.getInitParameter("configFile");
		
		try(InputStreamReader isr = new InputStreamReader(fConfig.getServletContext().getResourceAsStream(configFile));
				BufferedReader br = new BufferedReader(isr)) {
			
			String line = null;
			while((line = br.readLine()) != null) {
				filterList.add(line);
			}
			
			System.out.println(">>> Login이 필요한 uri 목록 <<<");
			filterList.stream().forEach(System.out::println);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private boolean isNeededLoginCheck(HttpServletRequest request) throws ServletException, IOException {
		// TODO 로그인 체크가 필요한 uri인지 확인. (init이 만들어둔 list에 해당 uri가 있는지 확인)
		return filterList.contains(getThisURI(request));
	}

	
	private String getThisURI(HttpServletRequest request) {
		// TODO 요청 받은 command 확인
		
		/*
		// 매개변수가 ServletRequest였을 때 형변환
		String command = ((HttpServletRequest) request).getRequestURI();
		String contextPath = ((HttpServletRequest) request).getContextPath();
		*/
		
		String command = request.getRequestURI();
		String contextPath = request.getContextPath();
		
		if(command.indexOf(contextPath) == 0 ) {
			command = command.substring(contextPath.length() + 1); // '/' 뗀 경로. (예: index.do)
		}
		
		return command;
	}
	
	private void removeCookie(HttpServletResponse response) {
		Cookie cookie = new Cookie("redirectURI", null);
		cookie.setMaxAge(0);
		response.addCookie(cookie);
	}
}
