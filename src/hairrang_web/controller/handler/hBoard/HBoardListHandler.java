package hairrang_web.controller.handler.hBoard;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.HBoard;
import hairrang_web.dto.HBoardCate;
import hairrang_web.service.HBoardService;

public class HBoardListHandler implements Command {
	private HBoardService service = new HBoardService();
	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		String category = request.getParameter("category");
		ArrayList<HBoard> list = service.selectHboardByAll();
		
		System.out.println("category:" + category);
		if(category == null) {
			request.setAttribute("list", list);
			return "hair/hair_list.jsp"; 
		}
		
		HBoardCate cate = service.selectHBoardByCateNo(Integer.parseInt(category));
		ArrayList<HBoardCate> cateList = new ArrayList<HBoardCate>();
		cateList.add(cate);
		
		ArrayList<HBoard> board = new ArrayList<HBoard>();
		for(HBoard hb: cate.gethBoard()) {
			board.add(hb);
		}
		request.setAttribute("board", board);
		request.setAttribute("cateList", cateList);
		request.setAttribute("list", list);
		
		return "hair/hair_list.jsp";
	}

}
