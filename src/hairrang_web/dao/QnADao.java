package hairrang_web.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;

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
	//페이징처리된  총게시물
	List<QnA> selectPagingQnA(Paging paging);
	
	//답변한 문의
	int countResYQnA();
	//페이징처리된 답변 문의
	List<QnA> selectPagingResYQnA(Paging paging);
	
	//미답변한 문의
	int countResNQnA();
	//페이징처리된 미답변한 문의
	List<QnA> selectPagingResNQnA(Paging paging);
	
	//삭제된 문의
	int countDelYQnA();
	//페이징처리된 삭제된 문의
	List<QnA> selectPagingDelYQnA(Paging paging);
	
	//삭제된 공지
	int countDelYQnANotice();
	//페이징 처리된 삭제된 공지
	List<QnA> selectPagingDelYQnANotice(Paging paging);
	
	//답변 찾기
	QnA selectResByNo(QnA qna);
	
	//나의 문의 내역 페이징
	List<QnA> pagingQnaById(Paging paging, String id);
	
	int countQnaById(String id);
	
	//문의사항 공지사항 쓸때
	int insertQnaNotice(QnA qna);
	
	//답변 수정
	int updateResult(QnA qna);
	
	//복원
	int updateRestoreQna(String no);
	
	//공지 찾기 갯수
	int countPagingQnaSearch(String condition, String keyword,String stay);
	
	//공지 찾기 페이징
	List<QnA> selectPagingQnASearch(Paging paging, String condition, String keyword,String stay);
	
	//날짜 문의 갯수(공지x)
	JSONArray selectOnlyQnA();
}
