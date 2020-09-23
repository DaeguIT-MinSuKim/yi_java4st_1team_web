package hairrang_web.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.rowset.serial.SerialException;

public interface Command {
	String process(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException;
}
