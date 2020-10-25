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
	
	Notice selectNoticeByNo(int noticeNo);
	
	//noticeDetail밑에 이전글 다음글 정보 불러오기
	
	Notice selectNoticeDownSide(Notice notice);

	Notice selectNoticeUpSide(Notice notice);
}
