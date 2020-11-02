package hairrang_web.dao;

import java.util.List;

import hairrang_web.dto.Notice;
import hairrang_web.utils.Paging;

public interface NoticeDao {
	
	List<Notice> NoticeAll();
	
	//총게시물
	int countNoitce();
	//페이징처리된 게시물
	List<Notice> selectPagingNotice(Paging paging);
	
	//삭제된 게시물
	int countDelNotice();
	//페이징처리된 삭제된 게시물
	List<Notice> selectPagingDelNotice(Paging paging);
	
	Notice selectNoticeByNo(int noticeNo);
	
	//noticeDetail밑에 이전글 다음글 정보 불러오기
	
	Notice selectNoticeDownSide(Notice notice);

	Notice selectNoticeUpSide(Notice notice);
	
	//삭제
	int deleteNotice(Notice notice);
	
	//추가
	int insertNotice(Notice notice);
	
	//수정
	int updateNotice(Notice notice);
	
	//복원
	int RestoreNotice(String no);
	
	// 공지찾기 갯수
	int countPagingNoticeSearch(Paging paging, String condition, String keyword,String stay);
	
	// 공지찾기 페이징
	List<Notice> selectPagingNoticeSearch(Paging paging, String condition, String keyword,String stay);
}
