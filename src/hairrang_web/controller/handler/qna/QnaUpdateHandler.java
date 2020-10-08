package hairrang_web.controller.handler.qna;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hairrang_web.controller.Command;
import hairrang_web.dto.QnA;
import hairrang_web.service.QnaService;

public class QnaUpdateHandler implements Command {
	private QnaService service = new QnaService();

	@Override
	public String process(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		String url = "qnaList.do";
		//qnaNo는 get방식으로 post방식으로 둘다 정보를 불러올때 쓰이기 때문에 따로 밖에다가 선언생성하였습니다.
		int qnaNo = Integer.parseInt(request.getParameter("no"));
		
		//get방식에서는 해당 no를 통해서 db저장되어있는 qna를 불러옵니다.
		if (request.getMethod().equals("GET")) {
			QnA qna = service.selectQnaByNo(qnaNo);
			request.setAttribute("qna", qna);
			return "qna/qnaUpdate.jsp";
			
		} else {
			//post방식으로는 작성한 내용을 가져와서 다시 업데이트를 하는곳입니다 그리고 바로 sendRedirect방식으로 주소를 옮겨줍니다 
			System.out.println("POST");
			QnA qna = new QnA();
			qna.setQnaNo(qnaNo);
			String content = request.getParameter("content");
			qna.setQnaContent(content);
			service.updateQna(qna);
			response.sendRedirect(url);
			return null;
		}
	}

}
