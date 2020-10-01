package hairrang_web.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;

import hairrang_web.dao.BookingDao;
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
		ArrayList<Booking> list = null;
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if(rs.next()) {
				list = new ArrayList<>();
				while(rs.next()) {
					list.add(getBooking(rs));
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return list;
	}

	
	private Booking getBooking(ResultSet rs) throws SQLException {
		int bookNo = rs.getInt("BOOK_NO");
		Guest guest = new Guest(rs.getString("GUEST_NO"));
		LocalDateTime bookTime = rs.getTimestamp("BOOK_DATE").toLocalDateTime();
		Hair hair = new Hair(rs.getInt("HAIR_NO"));
		Designer designer = new Designer(rs.getInt("DE_NO"));
		LocalDateTime bookRegDate = rs.getTimestamp("BOOK_REG_DATE").toLocalDateTime();
		int bookStatus = rs.getInt("BOOK_STATUS");
		String bookNote = rs.getString("bookNote");
		
		return new Booking(bookNo, guest, bookTime, hair, designer, bookRegDate, bookStatus, bookNote);
	}

	
	@Override
	public Booking selectBookingByBookingNo(Booking booking) {
		String sql = "SELECT * FROM BOOKING WHERE BOOK_NO = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			
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
		String sql = "INSERT INTO BOOKING(GUEST_ID, BOOK_TIME, HAIR_NO, DE_NO, BOOK_STATUS, BOOK_NOTE) VALUES(?, ?, ?. ?, ?, ?)";
		
		try(Connection con = JndiDs.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setString(1, booking.getGuest().getGuestId());
			pstmt.setTimestamp(2, Timestamp.valueOf(booking.getBookDate()));
			pstmt.setInt(3, booking.getHair().getHairNo());
			pstmt.setInt(4, booking.getDesigner().getDeNo());
			pstmt.setInt(5, booking.getBookStatus());
			pstmt.setString(6, booking.getBookNote());
			
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

}
