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
		String status = request.getParameter("status");
		
		Paging paging = new Paging();
		if(status != null) {
			if(!status.trim().equals("")) {
				request.setAttribute("status", status);
			}
		}
		
		System.out.println("status:" + status);

		// 현재페이지랑 한페이지당 제한 문의 갯수 확인용
//				System.out.println(nowPage);
//				System.out.println(cntPerPage);

		// 만약 처음 접속했을때 초기세팅해주는 곳
		int total = service.countCouponById(loginUser.getGuestId(), status);
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "10";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "10";
		}
		
		paging.setNowPage(Integer.parseInt(nowPage));
		paging.setCntPerPage(Integer.parseInt(cntPerPage));
		

		// 이후 페이지 클래스로 정리하는곳
		paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
		ArrayList<Coupon> list = service.pagingCouponById(paging, loginUser.getGuestId(), status);

		System.out.println(paging);

		request.setAttribute("total", total);
		request.setAttribute("paging", paging);
		
		request.setAttribute("nowPage", Integer.parseInt(nowPage));
		request.setAttribute("cntPerPage", Integer.parseInt(cntPerPage));
		
		request.setAttribute("list", list);
		
		return "mypage/guest_coupon.jsp";
	}

}
