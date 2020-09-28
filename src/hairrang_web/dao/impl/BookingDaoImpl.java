package hairrang_web.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertBooking(Booking booking) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateBooking(Booking booking) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteBooking(Booking booking) {
		// TODO Auto-generated method stub
		return 0;
	}

}
