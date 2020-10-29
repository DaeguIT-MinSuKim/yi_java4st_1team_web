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

public class AdminGuestBookingInfoHandler implements Command {
	private GuestService gService = new GuestService();
	private BookingService bService = new BookingService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("get");
			
			String id = request.getParameter("id");
			//detail에서 주문전환할때 booking no
			String no = request.getParameter("no");
			
//예약리스트////////////////////////////////////////////////////////////////////////////
			

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
				cntPerPage = "10";
			} else if (nowPage == null) {
				nowPage = "1";
			} else if (cntPerPage == null) {
				cntPerPage = "10";
			}
			System.out.println("현재 페이지 ===>" + nowPage);
			System.out.println("한 페이지당 나오는 게시물수 ===>" + cntPerPage);
			System.out.println("총게시물 갯수 ===>" + total);
			
			
			//이후 페이지 클래스로 정리하는곳
			Paging paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			ArrayList<Booking> bookingList = bService.pagingBookingListById(paging, id);
			
			/*
			//중복제외 번호리스트
			ArrayList<Integer> noList = service.selectNoBooking(loginUser.getGuestId());
			System.out.println("noList.size() : " + noList.size());
			ArrayList<Booking> bookingList = new ArrayList<Booking>();
			*/
			
			//리스트없을때
			if(bookingList == null) {
				request.setAttribute("message", -1);
				return "guest/guest_booking_info.jsp";
			}
			
			
			/*for(int bookNo:noList) {
				bookingList.add(service.pagingBookingById(paging, loginUser.getGuestId(), bookNo));
			}*/
//			System.out.println("페이징 결과 한 페이이지에 몇 개? : " + bookingList.size());
			
			//bookingList 1- hairlist 1,2...
			// 2- hairlist 1,2..
			ArrayList<Integer> prices = new ArrayList<>();
			System.out.println("booking" + bookingList);
			for(Booking book : bookingList) {
				int sum = 0;
				
				for(BookingHairs bh : book.getHairList()) {
					sum += bh.getHair().getHairPrice() * bh.getQuantity();
				}
				prices.add(sum);
			}
			
			request.setAttribute("id", id);
			request.setAttribute("pp", prices);
			request.setAttribute("cnt", cntPerPage);
			request.setAttribute("total", total);
			request.setAttribute("paging", paging);
			request.setAttribute("booking", bookingList);
			request.setAttribute("no", no);

			
		}else {
			System.out.println("post");
		}
		return "guest/guest_booking_info.jsp";
	}


}
