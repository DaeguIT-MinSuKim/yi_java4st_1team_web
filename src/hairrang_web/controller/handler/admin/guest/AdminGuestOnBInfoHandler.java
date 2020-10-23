package hairrang_web.controller.handler.admin.guest;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Booking;
import hairrang_web.dto.BookingHairs;
import hairrang_web.dto.Guest;
import hairrang_web.service.BookingService;
import hairrang_web.service.GuestService;
import hairrang_web.utils.Paging;

public class AdminGuestOnBInfoHandler implements Command {
	private GuestService gService = new GuestService();
	private BookingService bService = new BookingService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("get");
			
			String id = request.getParameter("id");
			
			//현재페이지랑 한페이지당 제한 문의 갯수 넘겨주는 곳
			String nowPage = request.getParameter("nowPage");
			String cntPerPage = request.getParameter("cntPerPage");

			//현재페이지랑 한페이지당 제한 문의 갯수 확인용
			System.out.println(nowPage);
			System.out.println(cntPerPage);

		
			//만약 처음 접속했을때 초기세팅해주는 곳 
			int total = bService.countBookingById(id);
			if (nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "5";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if (cntPerPage == null) {
				cntPerPage = "5";
			}
			System.out.println("현재 페이지 ===>" + nowPage);
			System.out.println("한 페이지당 나오는 게시물수 ===>" + cntPerPage);
			System.out.println("총게시물 갯수 ===>" + total);
			
			
			//이후 페이지 클래스로 정리하는곳
			Paging paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			
			ArrayList<Booking> bookingList = bService.pagingBookingListById(paging, id);
			ArrayList<Integer> prices = new ArrayList<>();
			
			for(Booking book : bookingList) {
				int sum = 0;
				//System.out.println("hairList 있습니까? : " + book.getHairList());
				for(BookingHairs bh : book.getHairList()) {
					sum += bh.getHair().getHairPrice() * bh.getQuantity();
				}
				prices.add(sum);
			}
			
			
			Guest guest = gService.selectGuestById(new Guest(id));
			
			System.out.println(guest);
			request.setAttribute("guest", guest);
			request.setAttribute("booking", bookingList);
			request.setAttribute("pp", prices);
			request.setAttribute("cnt", cntPerPage);
			request.setAttribute("total", total);
			request.setAttribute("paging", paging);
			
			
		}else {
			System.out.println("post");
		}
		return "guest/guest_onb_info.jsp";
	}


}
