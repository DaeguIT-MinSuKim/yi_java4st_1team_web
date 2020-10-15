package hairrang_web.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;

import hairrang_web.dao.BookingDao;
import hairrang_web.dao.DesignerDao;
import hairrang_web.dao.GuestDao;
import hairrang_web.dao.HairDao;
import hairrang_web.ds.JndiDs;
import hairrang_web.dto.Booking;
import hairrang_web.dto.Designer;
import hairrang_web.dto.Guest;
import hairrang_web.dto.Hair;

public class BookingDaoImpl implements BookingDao {

	private static final BookingDaoImpl instance = new BookingDaoImpl();
	
	private BookingDaoImpl() {
	}
	
	public static BookingDaoImpl getInstance() {
		return instance;
	}

	@Override
	public ArrayList<Booking> selectBookingAll() {
		String sql = "SELECT * FROM BOOKING";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if(rs.next()) {
				ArrayList<Booking> list = new ArrayList<>();
				while(rs.next()) {
					list.add(getBooking(rs));
				}
				return list;
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}

	
	private Booking getBooking(ResultSet rs) throws SQLException {
		// BOOK_NO, GUEST_ID, BOOK_TIME, HAIR_NO, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE
		
		GuestDao gDao = GuestDaoImpl.getInstance();
		HairDao hDao = HairDaoImpl.getInstance();
		DesignerDao dDao = DesignerDaoImpl.getInstance();
				
		int bookNo = rs.getInt("BOOK_NO");
		Guest guest = gDao.selectGuestById(new Guest(rs.getString("GUEST_ID")));
		LocalDateTime bookTime = rs.getTimestamp("BOOK_TIME").toLocalDateTime();
		Hair hair = hDao.selectHairByNo(new Hair(rs.getInt("HAIR_NO")));
		Designer designer = dDao.selectDesignerByNo(new Designer(rs.getInt("DE_NO")));
		LocalDateTime bookRegDate = rs.getTimestamp("BOOK_REGDATE").toLocalDateTime();
		int bookStatus = rs.getInt("BOOK_STATUS");
		
		String bookNote = null;
		try {
			bookNote = rs.getString("BOOK_NOTE");
		} catch (SQLException e) {
		}
		
		return new Booking(bookNo, guest, bookTime, hair, designer, bookRegDate, bookStatus, bookNote);
	}

	
	@Override
	public ArrayList<Booking> selectBookingByGuestId(Guest guest) {
		String sql = "SELECT * FROM BOOKING WHERE GUEST_ID = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			System.out.println("guest.getGuestId() : " + guest.getGuestId());
			pstmt.setString(1, guest.getGuestId());
			try (ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					ArrayList<Booking> list = new ArrayList<Booking>();
					do {
						list.add(getBooking(rs));
					} while(rs.next());
					return list;
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		
		return null;
	}
	
	
	@Override
	public Booking selectBookingByBookingNo(Booking booking) {
		String sql = "SELECT * FROM BOOKING WHERE BOOK_NO = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			System.out.println("booking.getBookNo() : " + booking.getBookNo());
			pstmt.setInt(1, booking.getBookNo());
			try (ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					return getBooking(rs);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		
		return null;
	}
	@Override
	public int insertBooking(Booking booking) {
		String sql = "INSERT INTO BOOKING(GUEST_ID, BOOK_TIME, HAIR_NO, DE_NO, BOOK_NOTE) VALUES(?, ?, ?, ?, ?)";
		
		try(Connection con = JndiDs.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, booking.getGuest().getGuestId());
			pstmt.setTimestamp(2, Timestamp.valueOf(booking.getBookDate()));
			pstmt.setInt(3, booking.getHair().getHairNo());
			pstmt.setInt(4, booking.getDesigner().getDeNo());
//			pstmt.setInt(5, booking.getBookStatus());
			pstmt.setString(5, booking.getBookNote());
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	
	@Override
	public int updateBooking(Booking booking) {
		String sql = "UPDATE BOOKING SET BOOK_TIME = ?, HAIR_NO = ?, DE_NO = ?, BOOK_STATUS = ?, BOOK_NOTE = ? WHERE BOOK_NO = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setTimestamp(1, Timestamp.valueOf(booking.getBookDate()));
			pstmt.setInt(2, booking.getHair().getHairNo());
			pstmt.setInt(3, booking.getDesigner().getDeNo());
			pstmt.setInt(4, booking.getBookStatus());
			pstmt.setString(5, booking.getBookNote());
			pstmt.setString(6, booking.getGuest().getGuestId());
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	
	@Override
	public int deleteBooking(Booking booking) {
		String sql = "DELETE BOOKING WHERE BOOK_NO = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, booking.getBookNo());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int checkUser(Booking booking, Guest guest) {
		String sql = "SELECT 1 FROM BOOKING WHERE BOOK_NO = ? AND GUEST_ID = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, booking.getBookNo());
			pstmt.setString(2, guest.getGuestId());
			
			try(ResultSet rs = pstmt.executeQuery()) {
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
	public int selectMaxBookNo() {
//		String sql = "SELECT max(book_no) FROM booking";
		String sql = "SELECT book_no FROM booking WHERE BOOK_REGDATE = (SELECT max(BOOK_REGDATE) FROM BOOKING)";
		// test 데이터 60, 61번 때문에 가장 최근에 등록한 예약 번호 얻어오기로 변경.
		
		try(Connection con = JndiDs.getConnection();
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

}
