package hairrang_web.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(
		urlPatterns = {"*.do"},
		loadOnStartup = 1,
		initParams = {
				@WebInitParam(name="configFile",
						value="/WEB-INF/commandHandler.properties")
		})
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private Map<String, Command> handlerMap = new HashMap<>();
	
	public void init(ServletConfig config) throws ServletException {
		// TODO 명령어를 분석하는 맵을 생성
		
		String configFile = config.getInitParameter("configFile");
		try(InputStream is = config.getServletContext().getResourceAsStream(configFile)) {
			Properties props = new Properties();
			props.load(is);
			
			for(Entry<Object, Object> entry : props.entrySet()) {
				Class<?> cls = Class.forName((String) entry.getValue());
				Command command = (Command) cls.newInstance();
				handlerMap.put((String)entry.getKey(), command);
			}
			
			
			// 확인용
			for(Entry<String, Command> e : handlerMap.entrySet()) {
				System.out.println(e.getKey() + " : " + e.getValue());
			}
			
			
		} catch (IOException | ClassNotFoundException | InstantiationException | IllegalAccessException e) {
			e.printStackTrace();
		}
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		process(request, response);
	}

	private void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String command = request.getRequestURI();
		String contextPath = request.getContextPath();
		
//		System.out.println("command > " + command + "\t contextPath > " + contextPath);
		System.out.println(command.substring(contextPath.length()));
		
		if(command.indexOf(contextPath) == 0 ) {
			command = command.substring(contextPath.length());
		}
		
		Command commandHandler = handlerMap.get(command);
//		System.out.println(commandHandler);
		
		String viewPage = commandHandler.process(request, response);
		System.out.println("viewPage > " + viewPage + "\n");
		
		if (viewPage != null) {
			request.getRequestDispatcher(viewPage).forward(request, response);
		}
	}

}
