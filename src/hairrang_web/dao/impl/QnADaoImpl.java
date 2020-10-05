package hairrang_web.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import hairrang_web.dao.QnADao;
import hairrang_web.ds.JdbcUtil;
import hairrang_web.ds.JndiDs;
import hairrang_web.dto.Guest;
import hairrang_web.dto.QnA;

public class QnADaoImpl implements QnADao {
	private static final QnADaoImpl instance = new QnADaoImpl();

	public static QnADaoImpl getInstance() {
		return instance;
	}

	private QnADaoImpl() {
		super();
	}

	@Override
	public ArrayList<QnA> selctQnaAll() {
		String sql = "SELECT QNA_NO,QNA_TITLE,QNA_REGDATE,RES_YN FROM QNA_VIEW";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()){
			if(rs.next()) {
				ArrayList<QnA> list = new ArrayList<QnA>();
				do {
					list.add(getQnA(rs));
				}while(rs.next());
				return list;
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	private QnA getQnA(ResultSet rs) throws SQLException {
		QnA qna = new QnA();
		qna.setQnaNo(rs.getInt("QNA_NO"));
		qna.setQnaTitle(rs.getString("QNA_TITLE"));
		qna.setQnaRegDate(rs.getTimestamp("QNA_REGDATE").toLocalDateTime());
		qna.setQnaResyn(rs.getString("RES_YN"));
		return qna;
	}

	@Override
	public QnA selectQnAByIdNo(Guest guest, QnA qna) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertQnA(QnA qna) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateQnA(QnA qna) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteQnA(QnA qna) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int checkPwd() {
		// TODO Auto-generated method stub
		return 0;
	}

}
