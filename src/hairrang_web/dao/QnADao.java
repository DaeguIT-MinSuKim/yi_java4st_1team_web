package hairrang_web.dao;

import java.util.ArrayList;
import java.util.List;

import hairrang_web.dto.Booking;
import hairrang_web.dto.Guest;
import hairrang_web.dto.QnA;
import hairrang_web.utils.Paging;

public interface QnADao {

	ArrayList<QnA> selctQnaAll();
	
	QnA selectQnAByIdNo(int qnaNo);
	
	int insertQnA(QnA qna);
	
	int updateQnA(QnA qna);
	
	int deleteQnA(QnA qna);
	
	ArrayList<QnA> selectNoticeAll();
	
	//비회윈이 문의 넣었을때
	QnA checkPwd(QnA qna);
	
	ArrayList<QnA> selectQnaAllById(Guest guest);
	
	int nextQnaNo();
	
	//총개시물
	int countQnA();
	
	//페이징처리된 게시물
	List<QnA> selectPagingQnA(Paging paging);
	
	//답변 찾기
	QnA selectResByNo(QnA qna);
	
	//나의 문의 내역 페이징
	List<QnA> pagingQnaById(Paging paging, String id);
	
	int countQnaById(String id);
	
	//문의사항 공지사항 쓸때
	int insertQnaNotice(QnA qna);
	
	//답변쓰기
	int insertQnaRestult(QnA qna, String qnaNo);
	
	//답변 처리
	int updateQnaResultYn(String  qnaNo);
}
