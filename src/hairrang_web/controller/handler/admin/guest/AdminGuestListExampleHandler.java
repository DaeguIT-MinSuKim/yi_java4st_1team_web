package hairrang_web.controller.handler.admin.guest;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import hairrang_web.controller.Command;
import hairrang_web.dto.Guest;
import hairrang_web.dto.TimeTable;
import hairrang_web.service.GuestService;
import hairrang_web.utils.Paging;

public class AdminGuestListExampleHandler implements Command {
	private GuestService service = new GuestService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		String url = "/admin/guest/guest_list.jsp";

		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");

		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "10";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "10";
		}

		int total = 0;
		Paging paging = null;
		ArrayList<Guest> list = null;

		String opt = request.getParameter("opt"); //0 아이디, 1이름, 2폰번호
		String value = request.getParameter("value");
		
		if(value != null) {
			value = value.trim();
		}

		if (value == null || value == "" || opt.equals("0") || opt == null) {
			// 검색 조건이 없는 경우 -> all list
			total = service.countGuest();
			paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			list = service.pagingGuestByAll(paging);
		} else if (opt.equals("1")) { // 아이디로 검색
			total = service.countIdSearch(value);
			paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			list = service.searchGuestById(paging, value);
		} else if (opt.equals("2")) {// 이름으로 검색
			total = service.countNameSearch(value);
			paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			list = service.searchGuestByName(paging, value);
		} else if (opt.equals("3")) { // 폰번호 검색
			total = service.countPhoneSearch(value);
			paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			list = service.searchGuestByPhone(paging, value);
		}


		System.out.println("현재 페이지 =>" + nowPage);
		System.out.println("페이지당 게시물 수 =>" + cntPerPage);
		System.out.println("총 게시물 갯수 =>" + total);

		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println(getClass().getSimpleName() + " >> GET");
			// 페이지 새로고침 되도 무방한 곳

			String id = request.getParameter("id");

			request.setAttribute("total", total);
			request.setAttribute("id", id);

			request.setAttribute("paging", paging);
			request.setAttribute("cnt", cntPerPage);
			request.setAttribute("list", list);

			return url;

		} else {
			System.out.println(getClass().getSimpleName() + " >> POST");
			// ajax로 JSON 형식으로 데이터 내보내기.

			Gson gson = new Gson();
			String resultGuest = gson.toJson(list, new TypeToken<ArrayList<Guest>>() {}.getType());
			System.out.println(resultGuest);
			
			String resultPaging = gson.toJson(paging, new TypeToken<Paging>() {}.getType());
			System.out.println(resultPaging);
			
			String resultAll = "{\"guestList\":" + resultGuest + ", \"paging\":" + resultPaging + "}";
			System.out.println(resultAll);
			
			response.setCharacterEncoding("UTF-8");
			response.setContentType("Application/json");
			response.setStatus(HttpServletResponse.SC_ACCEPTED);

			PrintWriter pw = response.getWriter();
			pw.print(resultAll);
			pw.flush();

			return null;
		}
		
	}

}
