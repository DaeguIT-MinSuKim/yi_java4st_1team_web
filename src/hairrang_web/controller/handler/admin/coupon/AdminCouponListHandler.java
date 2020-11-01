package hairrang_web.controller.handler.admin.coupon;

import java.io.IOException;
import java.util.ArrayList;

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
			
			
			//현재페이지랑 한페이지당 제한 문의 갯수 확인용
			System.out.println(nowPage);
			System.out.println(cntPerPage);
			
			//만약 처음 접속했을때 초기세팅해주는 곳 
			int total = service.countCoupon();
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			}else if(nowPage == null) {
				nowPage = "1";
			}else if(cntPerPage == null) {
				cntPerPage ="10";
			}
			System.out.println("지금현채 페이지 ===>"+nowPage);
			System.out.println("한 페이지당 나오는 게시물수 ===>"+cntPerPage);
			System.out.println("총게시물 갯수 ===>"+total);
			
			
			//이후 페이지 클래스로 정리하는곳
			Paging paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			//System.out.println(paging);
			ArrayList<Coupon> list = service.pagingCouponByAll(paging);
			///////////
			
			
			ArrayList<Event> eventList = eService.selectEventAll();
			
			request.setAttribute("eventList", eventList);
			//request.setAttribute("id", id);
			request.setAttribute("list", list);
			request.setAttribute("paging", paging);
			request.setAttribute("total", total);
			request.setAttribute("cnt", cntPerPage);
			
		} else {
			
			System.out.println(getClass().getSimpleName() + ">> POST");
			
			//String sorter = request.getParameter("sorter");
			//System.out.println(sorter);
			
			int sorter = Integer.parseInt(request.getParameter("sorter"));
			System.out.println("no=>" + sorter);
			
			String nowPage = request.getParameter("nowPage");
			String cntPerPage = request.getParameter("cntPerPage");
			
			
			//현재페이지랑 한페이지당 제한 문의 갯수 확인용
			System.out.println(nowPage);
			System.out.println(cntPerPage);
			
			//만약 처음 접속했을때 초기세팅해주는 곳 
			int total = service.countCoupon(sorter);
			
			if(nowPage == null && cntPerPage == null) {
				nowPage = "1";
				cntPerPage = "10";
			}else if(nowPage == null) {
				nowPage = "1";
			}else if(cntPerPage == null) {
				cntPerPage ="10";
			}
			System.out.println("지금현채 페이지 ===>"+nowPage);
			System.out.println("한 페이지당 나오는 게시물수 ===>"+cntPerPage);
			System.out.println("총게시물 갯수 ===>"+total);
			
			
			//이후 페이지 클래스로 정리하는곳
			Paging paging = new Paging(Integer.parseInt(nowPage), total, Integer.parseInt(cntPerPage));
			//System.out.println(paging);

			ArrayList<Coupon> list = service.pagingCouponByEventNo(paging, sorter);
			System.out.println(list);
			
			ArrayList<Event> eventList = eService.selectEventAll();
			
			request.setAttribute("eventList", eventList);
			request.setAttribute("no", sorter);
			request.setAttribute("list", list);
			request.setAttribute("paging", paging);
			request.setAttribute("total", total);
			request.setAttribute("cnt", cntPerPage);
			System.out.println("sorter>" + sorter);
			
		
			
		}
		
		return url;
	}

}
