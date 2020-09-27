package hairrang_web.service;

import java.util.ArrayList;

import hairrang_web.dao.QnADao;
import hairrang_web.dao.impl.QnADaoImpl;
import hairrang_web.dto.QnA;

public class QnaService {
	private QnADao dao = QnADaoImpl.getInstance();
	
	public ArrayList<QnA> qnaList(){
		return dao.selctQnaAll();
	}
}
