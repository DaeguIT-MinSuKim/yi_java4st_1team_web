package hairrang_web.controller.handler.admin.guest;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;

public class AdminGuestAddHandler implements Command {

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		return "guest/guest_add_form.jsp";
	}

}
