package hairrang_web.service;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import hairrang_web.dao.QnADao;
import hairrang_web.dao.impl.QnADaoImpl;
import hairrang_web.ds.JndiDs;
import hairrang_web.dto.Guest;
import hairrang_web.dto.QnA;
import hairrang_web.utils.Paging;

public class QnaService {
	private QnADao dao = QnADaoImpl.getInstance();

	public ArrayList<QnA> qnaList() {
		return dao.selctQnaAll();
	}

	public ArrayList<QnA> noticeList() {
		return dao.selectNoticeAll();
	}

	public ArrayList<QnA> qnaListById(Guest guest) {
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

	/*	public int countQna() {
			return dao.countQnA();
		}
	
		public List<QnA> selectPagingQnA(Paging paging) {
			return dao.selectPagingQnA(paging);
		}*/

	public QnA selectResQnaByNo(QnA qna) {
		return dao.selectResByNo(qna);
	}

	//나의 문의내역 
	public int countQnaById(String id) {
		return dao.countQnaById(id);
	}

	public List<QnA> pagingQnaById(Paging paging, String id) {
		return dao.pagingQnaById(paging, id);
	}

	public QnA passwordQna(QnA qna) {
		return dao.checkPwd(qna);
	}

	public int insertQnaNotice(QnA qna) {
		return dao.insertQnaNotice(qna);
	}

	//답변처리 트랜잭션
	public int insertQnaResult(QnA qna, String qnaNo) {
		/*res += dao.insertQnaRestult(qna, qnaNo);
		res += dao.updateQnaResultYn(qnaNo);*/
		int res = 0;

		String resultYnSql = "UPDATE QNA  SET RES_YN = 'y' WHERE QNA_NO = ?";
		String resultWriteSql = "INSERT INTO QNA(ADMIN_ID, QNA_TITLE, QNA_CONTENT, QNA_FILE, QNA_REFNO) VALUES(?,?,?,?,?)";

		Connection con = null;
		PreparedStatement YnPstmt = null;
		PreparedStatement WritePstmt = null;

		try {
			con = JndiDs.getConnection();
			con.setAutoCommit(false);

			YnPstmt = con.prepareStatement(resultYnSql);

			YnPstmt.setString(1, qnaNo);
			res += YnPstmt.executeUpdate();

			WritePstmt = con.prepareStatement(resultWriteSql);

			WritePstmt.setString(1, qna.getAdminId().getAdminId());
			WritePstmt.setString(2, qna.getQnaTitle());
			WritePstmt.setString(3, qna.getQnaContent());
			WritePstmt.setString(4, qna.getQnaFile());
			WritePstmt.setString(5, qnaNo);

			res += WritePstmt.executeUpdate();

			con.commit();

		} catch (Exception e) {
			System.out.println("답변중 오류");
			rollbackUtill(con, e);
		} finally {
			closeUtil(con, YnPstmt, WritePstmt);
		}

		return res;
	}

	//롤백
	private void rollbackUtill(Connection con, Exception e) {
		try {
			System.out.println("roll back");
			con.rollback();
			throw new RuntimeException(e);
		} catch (Exception ex) {
		}
	}

	private void closeUtil(Connection con, PreparedStatement yPstmt, PreparedStatement wPstmt) {
		try {
			if (yPstmt != null) {
				yPstmt.close();
			}
			if (wPstmt != null) {
				wPstmt.close();
			}
			if (con != null) {
				con.setAutoCommit(true);
				con.close();
			}

		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	//기존에 저장되었던 파일 삭제하고 다시 업로드할때 트랜잭션처리
	public int updateResult(QnA qna, int qnaNo, ServletContext context) {
		QnA findRes = selectQnaByNo(qnaNo);
		int res = 0;
		res = dao.updateResult(qna);

		if (res == 1) {
			String savePath = "notice/setload";
			String filePath = context.getRealPath(savePath) + "/";
			filePath += findRes.getQnaFile();

			File f = new File(filePath);
			if (f.exists()) {
				f.delete();
				res += 1;
			} else {
				res += 1;
			}

		}
		return res;
	};
	/*
	//답변한 문의 갯수
	public int countResYQnA() {
		return dao.countResYQnA();
	};
	
	//페이징처리된 답변 문의
	public List<QnA> selectPagingResYQnA(Paging paging){
		return dao.selectPagingResYQnA(paging);
	};
	
	//미답변한 문의
	public int countResNQnA() {
		return dao.countResNQnA();
	};
	
	//페이징처리된 미답변한 문의
	public List<QnA> selectPagingResNQnA(Paging paging){
		return dao.selectPagingResNQnA(paging);
	};
	
	//삭제된 문의
	public int countDelYQnA() {
		return dao.countDelYQnA();
	};
	
	//페이징처리된 삭제된 문의
	public List<QnA> selectPagingDelYQnA(Paging paging){
		return dao.selectPagingDelYQnA(paging);
	};
	
	//삭제된 공지
	public int countDelYQnANotice() {
		return dao.countDelYQnANotice();
	};
	
	//페이징 처리된 삭제된 공지
	public List<QnA> selectPagingDelYQnANotice(Paging paging){
		return dao.selectPagingDelYQnANotice(paging);
	};*/
	
	//복원
	public int updateRestoreQna(String no) {
		return dao.updateRestoreQna(no);
	}
	
	//페이징 찾기 카운터
	public int countPagingQnaSearch(String condition, String keyword,String stay) {
		return dao.countPagingQnaSearch(condition, keyword, stay);
	}
	
	//페이징 찾기 
	public List<QnA> selectPagingQnASearch(Paging paging, String condition, String keyword,String stay){
		return dao.selectPagingQnASearch(paging, condition, keyword, stay);
	}
}
