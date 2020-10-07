package hairrang_web.service;

import java.util.ArrayList;
import java.util.List;

import hairrang_web.dao.QnADao;
import hairrang_web.dao.impl.QnADaoImpl;
import hairrang_web.dto.Guest;
import hairrang_web.dto.QnA;
import hairrang_web.utils.Paging;

public class QnaService {
	private QnADao dao = QnADaoImpl.getInstance();
	
	public ArrayList<QnA> qnaList(){
		return dao.selctQnaAll();
	}
	
	public ArrayList<QnA> noticeList(){
		return dao.selectNoticeAll();
	}
	
	public ArrayList<QnA> qnaListById(Guest guest){
		return dao.selectQnaAllById(guest);
	}
	
	public int nextQnaNo() {
		return dao.nextQnaNo();
	}
	
	public int insertQna(QnA qna) {
		return dao.insertQnA(qna);
	}
	
	public QnA selectQnaByNo(int qnaNo) {
		return dao.selectQnAByIdNo(qnaNo);
	}
	
	public int updateQna(QnA qna) {
		return dao.updateQnA(qna);
	}
	
	public int deleteQna(QnA qna) {
		return dao.deleteQnA(qna);
	}
	
	public int coutnQna() {
		return dao.countQnA();
	}
	
	public List<QnA> selectPagingQnA(Paging paging){
		return dao.selectPagingQnA(paging);
	}
}
