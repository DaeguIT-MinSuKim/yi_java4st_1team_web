package hairrang_web.controller.handler.admin.coupon;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.Coupon;
import hairrang_web.dto.Event;
import hairrang_web.service.CouponService;
import hairrang_web.service.EventService;
import hairrang_web.utils.Paging;

public class AdminCouponListHandler implements Command {
	private CouponService service = new CouponService();
	private EventService eService = new EventService();
	
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		String url = "/admin/coupon/coupon_list.jsp";
		
		if(request.getMethod().equalsIgnoreCase("GET")) {
			System.out.println(getClass().getSimpleName() + ">> GET");
			
			String nowPage = request.getParameter("nowPage");
			String cntPerPage = request.getParameter("cntPerPage");
			Paging paging = new Paging();
			//현재페이지랑 한페이지당 제한 문의 갯수 확인용
			System.out.println(nowPage);
			System.out.println(cntPerPage);
			

			String no = request.getParameter("no");
			String status = request.getParameter("status");
			
			if (no != null && status != null) {
				if(!no.trim().equals("") && !status.trim().equals("") ) {
					request.setAttribute("no", no);
					request.setAttribute("status", status);
				}
			} else {
				no = null;
				status = null;
			}
			
			if(nowPage == null) {
				nowPage = "1";
			}
			if(cntPerPage == null) {
				cntPerPage ="10";
			}
			
			System.out.println("no: " + no);
			System.out.println("status: " + status);
			
			
			int total = service.countCoupon(paging, no, status);
			System.out.println("total: " + total);
			request.setAttribute("total", total);
			
			paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			System.out.println(paging);
			
			ArrayList<Coupon> list = service.pagingCouponByEventNo(paging, no, status);
			
			
			paging.setNowPage(Integer.parseInt(nowPage));
			paging.setCntPerPage(Integer.parseInt(cntPerPage));
			
			System.out.println(paging); 
			
//			System.out.println("지금현채 페이지 ===>"+nowPage);
//			System.out.println("한 페이지당 나오는 게시물수 ===>"+cntPerPage);
//			System.out.println("총게시물 갯수 ===>"+total);
			
			ArrayList<Event> eventList = eService.selectEventAll();
			System.out.println("이벤트리스트" + eventList);
			
			request.setAttribute("no", no);
			request.setAttribute("status", status);
			request.setAttribute("eventList", eventList);
			
			request.setAttribute("list", list);
			request.setAttribute("nowPage", Integer.parseInt(nowPage));
			request.setAttribute("cntPerPage", Integer.parseInt(cntPerPage));
			request.setAttribute("paging", paging);
			
			
			return url;
			
		} else {
			
			System.out.println(getClass().getSimpleName() + ">> POST");
			String status = request.getParameter("status");
			System.out.println(status);
			
		
		}
		return null;
	}

}
