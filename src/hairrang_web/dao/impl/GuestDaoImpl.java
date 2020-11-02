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
import hairrang_web.utils.Paging;

public class GuestDaoImpl implements GuestDao {

	private static final GuestDaoImpl instance = new GuestDaoImpl();
	private Connection con;

	private GuestDaoImpl() {
	}

	public static GuestDaoImpl getInstance() {
		return instance;
	}

	public void setCon(Connection con) {
		this.con = con;
	}

	@Override
	public ArrayList<Guest> selectGuestAll() {
		String sql = "SELECT GUEST_ID,GUEST_NAME,GUEST_BIRTHDAY,GUEST_PHONE, GUEST_EMAIL, GUEST_GENDER,GUEST_JOIN_DATE,GUEST_NOTE,DEL_YN,INFO_YN FROM GUEST_VIEW";

		try (PreparedStatement pstmt = con.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {

			if (rs.next()) {
				ArrayList<Guest> list = new ArrayList<>();
				do {
					list.add(getGuest(rs));
				} while (rs.next());
				return list;
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}

		return null;
	}

	private Guest getGuest(ResultSet rs) throws SQLException {
		// GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_GENDER,
		// GUEST_JOIN_DATE, GUEST_NOTE, DEL_YN, INFO_YN

		String guestId = rs.getString("GUEST_ID");
		String guestPwd = null;

		try {
			guestPwd = rs.getString("GUEST_PWD");
		} catch (SQLException e) {
			// selectAll -> View 이용 -> PWD X
			// selectById ->
		}

		String guestName = rs.getString("GUEST_NAME");
		LocalDate guestBirthday = rs.getTimestamp("GUEST_BIRTHDAY").toLocalDateTime().toLocalDate();
		String guestPhone = rs.getString("GUEST_PHONE");
		String guestEmail = rs.getString("GUEST_EMAIL");
		int guestGender = rs.getInt("GUEST_GENDER");
		LocalDateTime guestJoinDate = rs.getTimestamp("GUEST_JOIN_DATE").toLocalDateTime();
		String guestNote = rs.getString("GUEST_NOTE");
		String delYn = rs.getString("DEL_YN");
		String infoYn = rs.getString("INFO_YN");

		return new Guest(guestId, guestPwd, guestName, guestBirthday, guestPhone, guestEmail, guestGender,
				guestJoinDate, guestNote, delYn, infoYn);
	}

	@Override
	public Guest selectGuestById(Guest guest) {
		String sql = "SELECT * FROM GUEST WHERE GUEST_ID = ?";
		System.out.println(guest);
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, guest.getGuestId());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next())
					return getGuest(rs);
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	@Override
	public int insertGuest(Guest guest) {
		String sql = "INSERT INTO guest(GUEST_ID, GUEST_PWD, GUEST_NAME, GUEST_BIRTHDAY, GUEST_PHONE, GUEST_EMAIL, GUEST_GENDER, INFO_YN) VALUES"
				+ "(?, ?, ?, ?, ?, ?, ?, ?)";

		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, guest.getGuestId());
			pstmt.setString(2, guest.getGuestPwd());
			pstmt.setString(3, guest.getGuestName());
			pstmt.setDate(4, Date.valueOf(guest.getGuestBirthday()));
			pstmt.setString(5, guest.getGuestPhone());
			pstmt.setString(6, guest.getGuestEmail());
			pstmt.setInt(7, guest.getGuestGender());
			pstmt.setString(8, guest.getInfoYn());

			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	// 회원정보 수정시 로그인과 별도로 비밀번호 재확인이 필요한데 어떻게 처리할지 고민해보기.
	@Override
	public int updateGuest(Guest guest) {
		String sql = "UPDATE GUEST SET GUEST_NAME = ?, GUEST_BIRTHDAY = ?, GUEST_EMAIL = ?, GUEST_PHONE =?, GUEST_GENDER = ?, GUEST_NOTE = ?,INFO_YN = ?, DEL_YN = ? WHERE GUEST_ID = ? ";

		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, guest.getGuestName());
			pstmt.setDate(2, Date.valueOf(guest.getGuestBirthday()));
			pstmt.setString(3, guest.getGuestEmail());
			pstmt.setString(4, guest.getGuestPhone());
			pstmt.setInt(5, guest.getGuestGender());
			pstmt.setString(6, guest.getGuestNote());
			pstmt.setString(7, guest.getInfoYn());
			pstmt.setString(8, guest.getDelYn());
			pstmt.setString(9, guest.getGuestId());

			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int updateGuestPwd(Guest guest) {
		String sql = "UPDATE GUEST SET GUEST_PWD = ? WHERE GUEST_ID = ?";

		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
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

		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, guest.getGuestId());

			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int checkPwd(String id, String pwd) {
		String sql = "SELECT 1 FROM GUEST WHERE GUEST_ID = ?, GUEST_PWD = ?";

		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return rs.getInt(1); // 비밀번호 일치함
				}
				return 0; // 비밀번호 불일치, 혹은 아이디가 없을 수도. --> 경우를 따로 구분해줄 것인가?
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public Guest selectGuestByIdName(Guest guest) {
		String sql = "SELECT GUEST_ID ,GUEST_NAME FROM GUEST WHERE GUEST_ID =?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, guest.getGuestId());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					Guest loginUser = new Guest(rs.getString("GUEST_ID"));
					loginUser.setGuestName(rs.getString("GUEST_NAME"));
					return loginUser;
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	@Override
	public int confirmId(String id) {
		int result = -1;
		String sql = "SELECT * FROM GUEST WHERE GUEST_ID = ?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql);) {
			pstmt.setString(1, id);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					result = 1;
				} else {
					result = -1;
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException();
		}
		return result;
	}

	//id : name, email 
	//pw : id, name, email

	@Override
	public Guest findId(String name, String email) {
		String sql = "SELECT GUEST_ID FROM guest WHERE GUEST_NAME = ? AND GUEST_EMAIL = ?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					Guest findUser = new Guest(rs.getString("GUEST_ID"));
					return findUser;
				}

			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	@Override
	public Guest findPwd(String id, String name, String email) {
		String sql = "SELECT * FROM guest_view WHERE GUEST_ID = ? AND GUEST_NAME = ? AND GUEST_EMAIL= ?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return getGuest(rs);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	@Override
	public int updateGuestDelYn(Guest guest) {
		String sql = "UPDATE guest SET del_yn = 'y' WHERE GUEST_ID = ?";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, guest.getGuestId());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	///////페이징///////////////////////////////////////////////////////////////////////////////

	@Override
	public ArrayList<Guest> pagingGuestByAll(Paging paging) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM GUEST ORDER BY GUEST_JOIN_DATE desc) a) "
				+ "WHERE rn BETWEEN ? AND ? ORDER BY rn";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, paging.getStart());
			pstmt.setInt(2, paging.getEnd());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					ArrayList<Guest> list = new ArrayList<Guest>();
					do {
						list.add(getGuest(rs));
					} while (rs.next());

					return list;
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	@Override
	public int countGuest() {
		String sql = "SELECT COUNT(*) FROM guest";
		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return 0;
	}

	/////검색//////////////////////////////////////////////////////////////////////////

	@Override
	public ArrayList<Guest> searchGuestById(Paging paging, String id) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM "
				+ "(SELECT * FROM GUEST_VIEW WHERE GUEST_ID LIKE '%' || ? || '%' ORDER BY GUEST_JOIN_DATE desc) a) "
				+ "WHERE rn BETWEEN ? AND ? ORDER BY rn";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, id);
			pstmt.setInt(2, paging.getStart());
			pstmt.setInt(3, paging.getEnd());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					ArrayList<Guest> list = new ArrayList<Guest>();
					do {
						list.add(getGuest(rs));
					} while (rs.next());
					return list;
				}
			}

		} catch (SQLException e) {
			throw new RuntimeException();
		}
		return null;
	}

	@Override
	public ArrayList<Guest> searchGuestByName(Paging paging, String name) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM "
				+ "(SELECT * FROM GUEST_VIEW WHERE GUEST_NAME LIKE '%' || ? || '%' ORDER BY GUEST_JOIN_DATE desc) a) "
				+ "WHERE rn BETWEEN ? AND ? ORDER BY rn";

		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, name);
			pstmt.setInt(2, paging.getStart());
			pstmt.setInt(3, paging.getEnd());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					ArrayList<Guest> list = new ArrayList<Guest>();
					do {
						list.add(getGuest(rs));
					} while (rs.next());
					return list;
				}
			}

		} catch (SQLException e) {
			throw new RuntimeException();
		}
		return null;
	}
	
	@Override
	public ArrayList<Guest> searchGuestByPhone(Paging paging, String phone) {
		//FROM guest_view WHERE REGEXP_REPLACE(guest_phone, '[^0-9]+') LIKE '%' || ? || '%'";
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM "
				+ "(SELECT * FROM GUEST WHERE REGEXP_REPLACE(guest_phone, '[^0-9]+') LIKE '%' || ? || '%') a) "
				+ "WHERE rn BETWEEN ? AND ? ORDER BY rn";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, phone);
			pstmt.setInt(2, paging.getStart());
			pstmt.setInt(3, paging.getEnd());
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					ArrayList<Guest> list = new ArrayList<>();
					do {
						list.add(getGuest(rs));
					} while (rs.next());
					return list;
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	@Override
	public int countIdSearch(String id) {
		String sql = "SELECT COUNT(*) FROM guest WHERE GUEST_ID LIKE '%' || ? || '%'";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, id);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return rs.getInt(1);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return 0;
	}

	@Override
	public int countNameSearch(String name) {
		String sql = "SELECT COUNT(*) FROM guest WHERE GUEST_NAME LIKE '%' || ? || '%'";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, name);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return rs.getInt(1);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return 0;
	}


	@Override
	public int countPhoneSearch(String phone) {
		String sql = "SELECT COUNT(*) FROM guest WHERE REGEXP_REPLACE(guest_phone, '[^0-9]+') LIKE '%' || ? || '%'";
		try (Connection con = JndiDs.getConnection(); PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, phone);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return rs.getInt(1);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return 0;
	}
}
