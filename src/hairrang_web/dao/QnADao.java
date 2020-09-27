package hairrang_web.dao;

import java.util.ArrayList;

import hairrang_web.dto.Guest;
import hairrang_web.dto.QnA;

public interface QnADao {

	ArrayList<QnA> selctQnaAll();
	
	QnA selectQnAByIdNo(Guest guest,QnA qna);
	
	int insertQnA(QnA qna);
	
	int updateQnA(QnA qna);
	
	int deleteQnA(QnA qna);
	
	//비회윈이 문의 넣었을때
	int checkPwd();
}
