package hairrang_web.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
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
	
	public QnA selectResQnaByNo(QnA qna) {
		return dao.selectResByNo(qna);
	}
	
	//나의 문의내역 
	public int countQnaById(String id) {
		return dao.countQnaById(id);
	}
	
	public List<QnA> pagingQnaById(Paging paging, String id){
		return dao.pagingQnaById(paging, id);
	}
	
	public QnA passwordQna(QnA qna) {
		return dao.checkPwd(qna);
	}
	
	public int insertQnaNotice(QnA qna) {
		return dao.insertQnaNotice(qna);
	}
	
	public int insertQnaResult(QnA qna, String qnaNo) {
		int res = 0;
		Connection con = null;
		
		String jdbcDriver = "jdbc:oracle:thin:@localhost:1521:orcl?useSSL=false";
		String dbUser = "hairrang_web";
		String dbpass = "rootroot";
		
		try {
			con = DriverManager.getConnection(jdbcDriver, dbUser, dbpass);
			con.setAutoCommit(false);
			
			res += dao.insertQnaRestult(qna, qnaNo);
			res += dao.updateQnaResultYn(qnaNo);
			
			con.commit();
			con.setAutoCommit(true);
		}catch (Exception e) {
			try {
				con.rollback();
			} catch (SQLException e1) {
				System.out.println("답변중 시스템오류가 발생하였습니다.");
			}
		}finally {
			if(res != 2) {
				try {
					con.rollback();
				} catch (SQLException e) {
					System.out.println("답변중 Impl오류가 발생하였습니다.");
				}
			}
		}
		
		
		return res;
	}
}
