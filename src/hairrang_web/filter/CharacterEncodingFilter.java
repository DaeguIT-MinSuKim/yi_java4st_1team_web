package hairrang_web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;

@WebFilter(urlPatterns = { "/*" }, initParams = { @WebInitParam(name = "encoding", value = "utf-8") })
public class CharacterEncodingFilter implements Filter {

	private String enc;

	public CharacterEncodingFilter() {
	}

	public void destroy() {
		System.out.println("destroy()");
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
//		System.out.println("CharacterEncodingFilter - doFilter()");
		request.setCharacterEncoding(enc);
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
		System.out.println("init(FilterConfig fConfig)");

		enc = fConfig.getInitParameter("encoding");
		if (enc == null) {
			enc = "UTF-8";
		}
	}

}
