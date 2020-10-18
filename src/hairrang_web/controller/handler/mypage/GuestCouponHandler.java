package hairrang_web.controller.handler.mypage;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import hairrang_web.controller.Command;
import hairrang_web.dto.Coupon;
import hairrang_web.dto.Guest;
import hairrang_web.service.CouponService;
import hairrang_web.utils.Paging;

public class GuestCouponHandler implements Command {
	private CouponService service = new CouponService();
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		HttpSession session = request.getSession();
		Guest loginUser = (Guest) session.getAttribute("loginUser");
		
		//페이징
		String nowPage = request.getParameter("nowPage");
		String cntPerPage = request.getParameter("cntPerPage");

		// 현재페이지랑 한페이지당 제한 문의 갯수 확인용
//				System.out.println(nowPage);
//				System.out.println(cntPerPage);

		// 만약 처음 접속했을때 초기세팅해주는 곳
		int total = service.countCouponById(loginUser.getGuestId());
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

		// 이후 페이지 클래스로 정리하는곳
		Paging paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
		ArrayList<Coupon> list = service.pagingCouponById(paging, loginUser.getGuestId());

		System.out.println(paging);

		request.setAttribute("cnt", cntPerPage);
		request.setAttribute("total", total);
		request.setAttribute("paging", paging);
		
		request.setAttribute("list", list);
		
		return "mypage/guest_coupon.jsp";
	}

}
