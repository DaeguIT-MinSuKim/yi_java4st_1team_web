package hairrang_web.controller.handler.mypage;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dto.Booking;
import hairrang_web.dto.BookingHairs;
import hairrang_web.dto.Guest;
import hairrang_web.service.BookingService;
import hairrang_web.utils.Paging;

public class GuestBookStatus1 implements Command {
	private BookingService service = new BookingService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		HttpSession session = request.getSession();
		Guest loginUser = (Guest) session.getAttribute("loginUser");
		
		//현재페이지랑 한페이지당 제한 문의 갯수 넘겨주는 곳
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");

		//현재페이지랑 한페이지당 제한 문의 갯수 확인용
//		System.out.println(nowPage);
//		System.out.println(cntPerPage);

	
		//만약 처음 접속했을때 초기세팅해주는 곳 
		int total = service.countStatus1(loginUser.getGuestId());
		
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
		
//		///예약상태별 필터링
		
		ArrayList<Integer> status1NoList = service.selectNoStatus1(loginUser.getGuestId()); //이거는 나옴
		System.out.println("번호" + status1NoList);
		ArrayList<Booking> status1List = new ArrayList<Booking>();
		
		if(status1NoList == null) {
			request.setAttribute("message", -1);
			return "mypage/book_status1.jsp";
		}
		
		for(int status1:status1NoList) {
			status1List.add(service.selectBookStatus1(paging, loginUser.getGuestId(), status1));
		}
		System.out.println(status1List);
		ArrayList<Integer> prices = new ArrayList<>();
		
		for(Booking book : status1List) {
			int sum = 0;
			for(BookingHairs bh : book.getHairList()) {
				sum += bh.getHair().getHairPrice() * bh.getQuantity();
			}
			prices.add(sum);
		}
	
	
		request.setAttribute("list", status1List);
		request.setAttribute("pp", prices);
		request.setAttribute("cnt", cntPerPage);
		request.setAttribute("total", total);
		request.setAttribute("paging", paging);

		return "mypage/book_status1.jsp";
	}

}
