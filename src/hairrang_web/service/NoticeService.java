package hairrang_web.service;

import java.util.ArrayList;
import java.util.List;

import hairrang_web.dao.NoticeDao;
import hairrang_web.dao.impl.NoticeDaoImpl;
import hairrang_web.dto.Notice;
import hairrang_web.utils.Paging;
import jdk.nashorn.internal.runtime.arrays.ArrayLikeIterator;

public class NoticeService {
	NoticeDao dao = NoticeDaoImpl.getInstance();
	
	public int countNotice() {
		return dao.countNoitce();
	}
	
	public int countDelNotice() {
		return dao.countDelNotice();
	}
	
	public List<Notice> selectPagingNotice(Paging paging){
		return dao.selectPagingNotice(paging);
	}
	
	public List<Notice> selectPagingDelNotice(Paging paging){
		return dao.selectPagingDelNotice(paging);
	}
	
	public Notice selectNoticeByNo(int noticeNo){
		return dao.selectNoticeByNo(noticeNo);
	}
	
	public ArrayList<Notice> selectNoticeSide(Notice notice){
		ArrayList<Notice> list= new ArrayList<Notice>();
		list.add(dao.selectNoticeDownSide(notice));
		list.add(dao.selectNoticeUpSide(notice));
		return list;
	}
	
	public ArrayList<Notice> selectAll(){
		ArrayList<Notice> list= (ArrayList<Notice>) dao.NoticeAll();
		return list;
	}
	
	public int delelteNotice(Notice notice) {
		return dao.deleteNotice(notice);
	}
	
	public int insertNotice(Notice notice) {
		return dao.insertNotice(notice);
	}
	
	public int updateNotice(Notice notice) {
		return dao.updateNotice(notice);
	}
	
	public int RestoreNotice(String no) {
		return dao.RestoreNotice(no);
	}
	
	//공지 찾기 갯수
	public int countPagingNoticeSearch(Paging paging, String condition, String keyword,String stay) {
		return dao.countPagingNoticeSearch(paging, condition, keyword, stay);
	}
	
	//공지 찾기 페이징
	public List<Notice> selectPagingNoticeSearch(Paging paging, String condition, String keyword,String stay){
		return dao.selectPagingNoticeSearch(paging, condition, keyword, stay);
	}
	
}
