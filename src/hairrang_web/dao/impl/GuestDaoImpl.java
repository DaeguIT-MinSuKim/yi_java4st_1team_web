package hairrang_web.dao.impl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;

import hairrang_web.dao.GuestDao;
import hairrang_web.ds.JndiDs;
import hairrang_web.dto.Guest;

public class GuestDaoImpl implements GuestDao {

	private static final GuestDaoImpl instance = new GuestDaoImpl();
	
	public static GuestDaoImpl getInstance() {
		return instance;
	}

	private GuestDaoImpl() {}
	
	@Override
	public ArrayList<Guest> selectGuestAll() {
		String sql = "SELECT * FROM GUEST_VIEW";
		ArrayList<Guest> list = new ArrayList<>();
		System.out.println(list);
		
		try(Connection con = JndiDs.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery()) {

			while (rs.next()) {
				list.add(getGuest(rs));
			}
			
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		
		return list;
	}

	private Guest getGuest(ResultSet rs) throws SQLException {
		// GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_GENDER, GUEST_JOIN_DATE, GUEST_NOTE, DEL_YN
		
		String guestId = rs.getString("GUEST_ID");
		String guestPwd = null;
		
		try {
			guestPwd = rs.getString("GUEST_PWD");
		} catch(SQLException e) {
			// selectAll -> View 이용 -> PWD X
			// selectById -> 
		}
		
		String guestName = rs.getString("GUEST_NAME");
		LocalDate guestBirthday = rs.getTimestamp("GUEST_BIRTHDAY").toLocalDateTime().toLocalDate();
		String guestPhone = rs.getString("GUEST_PHONE");
		int guestGender = rs.getInt("GUEST_GENDER");
		LocalDateTime guestJoinDate = rs.getTimestamp("GUEST_JOIN_DATE").toLocalDateTime();
		String guestNote = rs.getString("GUEST_NOTE");
		String delYn = rs.getString("DEL_YN");
		
		return new Guest(guestId, guestPwd, guestName, guestBirthday, guestPhone, guestGender, guestJoinDate, guestNote, delYn) ;
	}

	
	@Override
	public Guest selectGuestById(Guest guest) {
		String sql = "SELECT * FROM GUEST WHER GUEST_ID = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, guest.getGuestId());
			
			try(ResultSet rs = pstmt.executeQuery()) {
				if(rs.next())
					return getGuest(rs);
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	
	@Override
	public int insertGuest(Guest guest) {
		String sql = "INSERT INTO(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_GENDER, GUEST_NOTE) "
					+ "VALUES(?, ?, ?, ?, ?, ?, ?)";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, guest.getGuestId());
			pstmt.setString(2, guest.getGuestPwd());
			pstmt.setString(3, guest.getGuestName());
			pstmt.setDate(4, Date.valueOf(guest.getGuestBirthday()));
			pstmt.setString(5, guest.getGuestPhone());
			pstmt.setInt(6, guest.getGuestGender());
			pstmt.setString(7, guest.getGuestNote());
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	
	// 회원정보 수정시 로그인과 별도로 비밀번호 재확인이 필요한데 어떻게 처리할지 고민해보기.
	@Override
	public int updateGuest(Guest guest) {
		String sql = "UPDATE GUEST SET GUEST_NAME = ?, GUEST_BIRTHDAY = ?, "
				+ "GUEST_PHONE =?, GUEST_NOTE = ? WHERE GUEST_ID = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, guest.getGuestName());
			pstmt.setDate(2, Date.valueOf(guest.getGuestBirthday()));
			pstmt.setString(3, guest.getGuestPhone());
			pstmt.setInt(4, guest.getGuestGender());
			pstmt.setString(5, guest.getGuestNote());
			pstmt.setString(6, guest.getGuestId());
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	
	@Override
	public int updateGuestPwd(Guest guest) {
		String sql = "UPDATE GUEST SET GUEST_PWD = ? WHERE GUEST_ID = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, guest.getGuestPwd());
			pstmt.setString(2, guest.getGuestId());
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	
	@Override
	public int deleteGuest(Guest guest) {
		String sql = "DELETE GUEST WHERE GUEST_ID = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, guest.getGuestId());
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}
	
	@Override
	public int checkPwd(String id, String pwd) {
		String sql = "SELECT 1 FROM GUEST WHERE GUEST_ID = ?, GUEST_PWD = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			try (ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					return rs.getInt(1); // 비밀번호 일치함
				}
				return 0; // 비밀번호 불일치, 혹은 아이디가 없을 수도. --> 경우를 따로 구분해줄 것인가?
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

}
