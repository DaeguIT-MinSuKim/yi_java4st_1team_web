package hairrang_web.controller.handler.mypage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dto.Booking;
import hairrang_web.dto.BookingHairs;
import hairrang_web.dto.Guest;
import hairrang_web.service.BookingService;
import hairrang_web.service.HairService;
import hairrang_web.utils.Paging;

public class GuestBookHandler implements Command {
	private BookingService bService = new BookingService();
	private HairService hService = new HairService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		

		if (request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println("get");
			// TODO Auto-generated method stub
			HttpSession session = request.getSession();
			Guest loginUser = (Guest) session.getAttribute("loginUser");
			
			//현재페이지랑 한페이지당 제한 문의 갯수 넘겨주는 곳
			String nowPage = request.getParameter("nowPage");
			String cntPerPage = request.getParameter("cntPerPage");

			//현재페이지랑 한페이지당 제한 문의 갯수 확인용
//			System.out.println(nowPage);
//			System.out.println(cntPerPage);

		
			//만약 처음 접속했을때 초기세팅해주는 곳 
			int total = bService.countBookingById(loginUser.getGuestId());
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
			
			//중복제외 번호리스트
			ArrayList<Integer> noList = bService.selectNoBooking(loginUser.getGuestId());
			ArrayList<Booking> bookingList = new ArrayList<Booking>();
			
			for(int bookNo:noList) {
				bookingList.add(bService.pagingBookingById(paging, loginUser.getGuestId(), bookNo));
			}
			
			
			//bookingList 1- hairlist 1,2...
			// 2- hairlist 1,2..
			ArrayList<BookingHairs> bookingHairs = bService.pagingBookingHairsByID(paging, loginUser.getGuestId());
			ArrayList<Integer> prices = new ArrayList<>();
			
			System.out.println(">> BookingHairs 출력");
			bookingHairs.stream().forEach(System.out::println);
			
			for(Booking book : bookingList) {
				int sum = 0;
				for(BookingHairs bh : book.getHairList()) {
					sum += bh.getHair().getHairPrice() * bh.getQuantity();
				}
				prices.add(sum);
			}
			
			/*for(BookingHairs hair : bookingHairs) {
				int sum = hair.getHair().getHairPrice() * hair.getQuantity();
				prices.add(sum);
			}*/
			
//			System.out.println("금액 계산");
//			prices.stream().forEach(System.out::println);
			
			request.setAttribute("pp", prices);
			request.setAttribute("cnt", cntPerPage);
			request.setAttribute("total", total);
			request.setAttribute("paging", paging);
			request.setAttribute("booking", bookingList);
			
		} else {
			System.out.println("post");
		}
		
		return "mypage/guest_book.jsp";
	}

}
