package hairrang_web.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;

import hairrang_web.dao.BookingDao;
import hairrang_web.dao.DesignerDao;
import hairrang_web.dao.GuestDao;
import hairrang_web.dao.HairDao;
import hairrang_web.ds.JndiDs;
import hairrang_web.dto.Booking;
import hairrang_web.dto.BookingHairs;
import hairrang_web.dto.Designer;
import hairrang_web.dto.Guest;
import hairrang_web.dto.Hair;
import hairrang_web.dto.TimeTable;
import hairrang_web.utils.Paging;

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
//		String sql = "SELECT * FROM BOOKING_VIEW";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if(rs.next()) {
				ArrayList<Booking> list = new ArrayList<>();
				do {
					list.add(getBooking(rs));
				} while(rs.next());
				return list;
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}
	
	@Override
	public ArrayList<BookingHairs> selectBookingHairsByBookingNo(int bookNo) {
		String sql = "SELECT * FROM BOOKING_HAIRS_VIEW WHERE BOOK_NO = ? ORDER BY BOOK_NO, HAIR_NO";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, bookNo);
			try(ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					ArrayList<BookingHairs> list = new ArrayList<>();
					do {
						list.add(getSimpleBookingHairs(rs));
					} while(rs.next());
					return list;
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}
	
	private BookingHairs getSimpleBookingHairs(ResultSet rs) throws SQLException {
		// BOOK_NO,HAIR_NO,HAIR_NAME,HAIR_PRICE,KIND_NO,HAIR_QUANTITY
		Hair hair = new Hair(rs.getInt("HAIR_NO"));
		hair.setHairName(rs.getString("HAIR_NAME"));
		hair.setHairPrice(rs.getInt("hair_price"));
		int quantity = rs.getInt("HAIR_QUANTITY");
		return new BookingHairs(hair, quantity);
	}

	private BookingHairs getBookingHairs(ResultSet rs) throws SQLException {
		// BOOK_NO, HAIR_NO, HAIR_QUANTITY
		
		HairDao hDao = HairDaoImpl.getInstance();
		Hair hair = null; 
		int quantity = 0;
		try {
			hair = hDao.selectHairByNo(new Hair(rs.getInt("HAIR_NO")));
			quantity = rs.getInt("HAIR_QUANTITY");
		}catch(SQLException e) {
			
		}
		//System.out.println("getBookingHairs 안 : " + hair + ", " + quantity);
		return new BookingHairs(hair, quantity);
	}

	private Booking getSimpleBooking(ResultSet rs) throws SQLException {
		int bookNo = rs.getInt("BOOK_NO");
		
		Guest guest = new Guest(rs.getString("GUEST_ID"));
		guest.setGuestName(rs.getString("GUEST_NAME"));
		guest.setGuestPhone(rs.getString("GUEST_PHONE"));
		
		LocalDateTime bookTime = rs.getTimestamp("BOOK_TIME").toLocalDateTime();
		ArrayList<BookingHairs> hairList = selectBookingHairsByBookingNo(bookNo);
		
		//System.out.println("getBooking 안 : " + hairList);
		//Hair hair = hDao.selectHairByNo(new Hair(rs.getInt("HAIR_NO")));

		Designer designer = new Designer(rs.getInt("DE_NO"));
		designer.setDeName(rs.getString("DE_NAME"));
		designer.setDeNickname(rs.getString("DE_NICKNAME"));
		designer.setDeLevel(rs.getString("DE_LEVEL"));
		
		LocalDateTime bookRegDate = rs.getTimestamp("BOOK_REGDATE").toLocalDateTime();
		int bookStatus = rs.getInt("BOOK_STATUS");
		
		String bookNote = null;
		try {
			bookNote = rs.getString("BOOK_NOTE");
		} catch (SQLException e) {
		}
		
		return new Booking(bookNo, guest, bookTime, designer, bookRegDate, bookStatus, bookNote, hairList);
	}
	
	private Booking getBooking(ResultSet rs) throws SQLException {
		// BOOK_NO, GUEST_ID, BOOK_TIME, HAIR_NO, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE
		// BOOK_NO, GUEST_ID, BOOK_TIME, HAIR_NO, HAIR_QUANTITY, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE
		
		GuestDao gDao = GuestDaoImpl.getInstance();
		HairDao hDao = HairDaoImpl.getInstance();
		DesignerDao dDao = DesignerDaoImpl.getInstance();
				
		int bookNo = rs.getInt("BOOK_NO");
		Guest guest = gDao.selectGuestById(new Guest(rs.getString("GUEST_ID")));
		LocalDateTime bookTime = rs.getTimestamp("BOOK_TIME").toLocalDateTime();
		ArrayList<BookingHairs> hairList = selectBookingHairsByBookingNo(bookNo);
		
		//System.out.println("getBooking 안 : " + hairList);
//		Hair hair = hDao.selectHairByNo(new Hair(rs.getInt("HAIR_NO")));

		Designer designer = dDao.selectDesignerByNo(new Designer(rs.getInt("DE_NO")));
		LocalDateTime bookRegDate = rs.getTimestamp("BOOK_REGDATE").toLocalDateTime();
		int bookStatus = rs.getInt("BOOK_STATUS");
		
		int rowNum = 0;
		String bookNote = null;
		try {
			rowNum = rs.getInt("rn");
			bookNote = rs.getString("BOOK_NOTE");
		} catch (SQLException e) {
		}
		
		return new Booking(rowNum, bookNo, guest, bookTime, hairList, designer, bookRegDate, bookStatus, bookNote);
	}

	
	@Override
	public ArrayList<Booking> selectBookingByGuestId(Guest guest) {
//		String sql = "SELECT * FROM BOOKING WHERE GUEST_ID = ? ";
		String sql = "SELECT * FROM BOOKING_VIEW WHERE GUEST_ID = ? ";
		
		try (Connection con = JndiDs.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			//System.out.println("guest.getGuestId() : " + guest.getGuestId());
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
		String sql = "SELECT * FROM BOOKING_VIEW WHERE BOOK_NO = ?";
		
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
	
	/*
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
	*/
	
	/*
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
	*/
	
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
	public int selectNextValBookNo() {
		String sql = "SELECT BOOK_NO_SEQ.NEXTVAL FROM DUAL";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()) {
			if(rs.next()) {
				System.out.println("조회가 없어?");
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			throw new RuntimeException();
		}
		
		return 0;
	}
	
	@Override
	public int selectMaxBookNo() {
//		String sql = "SELECT max(book_no) FROM booking";
		String sql = "SELECT NVL(book_no, 0) FROM booking WHERE BOOK_REGDATE = (SELECT max(BOOK_REGDATE) FROM BOOKING)";
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
	
	@Override
	public ArrayList<TimeTable> getTimeTables(String wantDate, int deNo) {
		String sql = "SELECT times, nvl(used, 0) AS USED " + 
				"FROM (SELECT TO_CHAR(TO_DATE('08:30', 'hh24:mi') + LEVEL/24/2, 'hh24:mi') AS times " + 
				"	FROM DUAL CONNECT BY LEVEL <= 20) " + 
				"LEFT OUTER JOIN " + 
				"	(SELECT TO_CHAR(BOOK_TIME, 'hh24:mi') AS times, 1 AS used " + 
				"	FROM BOOKING WHERE TO_char(book_time, 'YYYY-MM-DD') = ? AND DE_NO = ?) " + 
				"USING (TIMES) ORDER BY TIMES";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, wantDate);
			pstmt.setInt(2, deNo);
			try (ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					ArrayList<TimeTable> list = new ArrayList<>();
					do {
						list.add(new TimeTable(rs.getString("TIMES"), rs.getInt("USED")));
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
	public int isAvailableTime(String wantDateTime, int deNo) {
		String sql = "SELECT 1 AS used FROM BOOKING WHERE TO_char(BOOK_TIME, 'YYYY-MM-DD hh24:mi') = ? AND DE_NO = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setString(1, wantDateTime);
			pstmt.setInt(2, deNo);
			try (ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					return rs.getInt(1); // 이미 사용중이면 1 반환
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return 0;
	}
	
	
	@Override
	public int updateBookingStaus(Booking booking) {
		String sql = "UPDATE booking SET BOOK_STATUS = 0 WHERE book_no = ?";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setInt(1, booking.getBookNo());
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException();
		}
		
	}
	
	
	
//////////////////////////////////////페이징/////////////////////////////////////////////////

	@Override
	public int countBookingById(String id) {
		String sql = "SELECT COUNT(*) FROM (SELECT DISTINCT book_no FROM booking_view WHERE guest_id = ?)";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
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
	public Booking pagingBookingById(Paging paging, String id, int no) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM booking_view WHERE GUEST_ID = ? AND book_no = ? ORDER BY book_no desc) a) "
				+ "WHERE rn BETWEEN ? AND ? ORDER BY rn";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setString(1, id);
			pstmt.setInt(2, no);
			pstmt.setInt(3, paging.getStart());
			pstmt.setInt(4, paging.getEnd());
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next()) {
					/* List<Booking> list = new ArrayList<Booking>(); */
					//BOOK_NO, GUEST_ID, BOOK_TIME, HAIR_NO, HAIR_QUANTITY, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE
					
					Booking booking = new Booking();
					GuestDao gDao = GuestDaoImpl.getInstance();
					DesignerDao dDao = DesignerDaoImpl.getInstance();
					HairDao hDao = HairDaoImpl.getInstance();
					
					booking.setBookNo(rs.getInt("BOOK_NO"));
					booking.setGuest(gDao.selectGuestById(new Guest(rs.getString("GUEST_ID"))));
					booking.setBookDate(rs.getTimestamp("BOOK_TIME").toLocalDateTime());
					booking.setDesigner(dDao.selectDesignerByNo(new Designer(rs.getInt("DE_NO"))));
					booking.setBookRegDate(rs.getTimestamp("BOOK_REGDATE").toLocalDateTime());
					booking.setBookStatus(rs.getInt("BOOK_STATUS"));
					booking.setBookNote(rs.getString("BOOK_NOTE"));
					
					ArrayList<BookingHairs> list = new ArrayList<BookingHairs>();
					booking.setHairList(list);
				
					do {
						list.add(getBookingHairs(rs));
					}while(rs.next());
					return booking;
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}
	
	@Override
	public ArrayList<Booking> pagingBookingListById(Paging paging, String id) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM booking WHERE GUEST_ID = ? ORDER BY book_no desc) a) "
				+ "WHERE rn BETWEEN ? AND ? ORDER BY rn";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setString(1, id);
			pstmt.setInt(2, paging.getStart());
			pstmt.setInt(3, paging.getEnd());
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next()) {
					ArrayList<Booking> list = new ArrayList<Booking>();
					//BOOK_NO, GUEST_ID, BOOK_TIME, HAIR_NO, HAIR_QUANTITY, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE
					do {
						Booking booking = new Booking();
						GuestDao gDao = GuestDaoImpl.getInstance();
						DesignerDao dDao = DesignerDaoImpl.getInstance();
						HairDao hDao = HairDaoImpl.getInstance();
						
						int bookNo = rs.getInt("BOOK_NO");
						booking.setBookNo(bookNo);
						booking.setGuest(gDao.selectGuestById(new Guest(rs.getString("GUEST_ID"))));
						booking.setBookDate(rs.getTimestamp("BOOK_TIME").toLocalDateTime());
						booking.setDesigner(dDao.selectDesignerByNo(new Designer(rs.getInt("DE_NO"))));
						booking.setBookRegDate(rs.getTimestamp("BOOK_REGDATE").toLocalDateTime());
						booking.setBookStatus(rs.getInt("BOOK_STATUS"));
						booking.setBookNote(rs.getString("BOOK_NOTE"));
						
						ArrayList<BookingHairs> hairList = selectBookingHairsByBookingNo(bookNo);
						booking.setHairList(hairList);
						
						list.add(booking);
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
	public ArrayList<BookingHairs> pagingBookingHairsById(Paging paging, String id) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT distinct(book_no) FROM booking_view WHERE GUEST_ID = ? AND book_no = ? ORDER BY book_no desc) a) WHERE rn BETWEEN ? AND ? ORDER BY rn";
//				"SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM booking_view WHERE GUEST_ID = ? ORDER BY book_no desc) a) "
//				+ "WHERE rn BETWEEN ? AND ? ORDER BY rn";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setString(1, id);
			pstmt.setInt(2, paging.getStart());
			pstmt.setInt(3, paging.getEnd());
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next()) {
					ArrayList<BookingHairs> list = new ArrayList<BookingHairs>();
					do {
						list.add(getBookingHairs(rs));
					}while(rs.next());
					return list;
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}


	@Override
	public Booking selectBookStatus1(Paging paging, String id, int no) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM booking_view "
				+ "WHERE GUEST_ID = ? AND book_status = 1 AND book_no = ? ORDER BY book_no desc) a) WHERE rn BETWEEN ? AND ? ORDER BY rn";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setString(1, id);
			pstmt.setInt(2, no);
			pstmt.setInt(3, paging.getStart());
			pstmt.setInt(4, paging.getEnd());
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next()) {
					/* List<Booking> list = new ArrayList<Booking>(); */
					//BOOK_NO,GUEST_ID,BOOK_TIME,HAIR_NO,HAIR_QUANTITY,DE_NO,BOOK_REGDATE,BOOK_STATUS,BOOK_NOTE
					
					Booking booking = new Booking();
					GuestDao gDao = GuestDaoImpl.getInstance();
					DesignerDao dDao = DesignerDaoImpl.getInstance();
					HairDao hDao = HairDaoImpl.getInstance();
					
					booking.setBookNo(rs.getInt("BOOK_NO"));
					booking.setGuest(gDao.selectGuestById(new Guest(rs.getString("GUEST_ID"))));
					booking.setBookDate(rs.getTimestamp("BOOK_TIME").toLocalDateTime());
					booking.setDesigner(dDao.selectDesignerByNo(new Designer(rs.getInt("DE_NO"))));
					booking.setBookRegDate(rs.getTimestamp("BOOK_REGDATE").toLocalDateTime());
					booking.setBookStatus(rs.getInt("BOOK_STATUS"));
					booking.setBookNote(rs.getString("BOOK_NOTE"));
				
					ArrayList<BookingHairs> list = new ArrayList<BookingHairs>();
					booking.setHairList(list);
					
					do {
						list.add(getBookingHairs(rs));
					}while(rs.next());
					
					return booking;
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
		
	}

	@Override
	public Booking selectBookStatus0(Paging paging, String id, int no) {
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM booking_view "
				+ "WHERE GUEST_ID = ? AND book_status = 0 AND book_no = ? ORDER BY book_no desc) a) WHERE rn BETWEEN ? AND ? ORDER BY rn";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
			pstmt.setString(1, id);
			pstmt.setInt(2, no);
			pstmt.setInt(3, paging.getStart());
			pstmt.setInt(4, paging.getEnd());
			try(ResultSet rs = pstmt.executeQuery()){
				if(rs.next()) {
					/* List<Booking> list = new ArrayList<Booking>(); */
					//BOOK_NO, GUEST_ID, BOOK_TIME, HAIR_NO, HAIR_QUANTITY, DE_NO, BOOK_REGDATE, BOOK_STATUS, BOOK_NOTE
					
					Booking booking = new Booking();
					GuestDao gDao = GuestDaoImpl.getInstance();
					DesignerDao dDao = DesignerDaoImpl.getInstance();
					HairDao hDao = HairDaoImpl.getInstance();
					
					booking.setBookNo(rs.getInt("BOOK_NO"));
					System.out.println(gDao.selectGuestById(new Guest("test")));
					booking.setGuest(gDao.selectGuestById(new Guest(rs.getString("GUEST_ID"))));
					booking.setBookDate(rs.getTimestamp("BOOK_TIME").toLocalDateTime());
					booking.setDesigner(dDao.selectDesignerByNo(new Designer(rs.getInt("DE_NO"))));
					booking.setBookRegDate(rs.getTimestamp("BOOK_REGDATE").toLocalDateTime());
					booking.setBookStatus(rs.getInt("BOOK_STATUS"));
					booking.setBookNote(rs.getString("BOOK_NOTE"));
					
					ArrayList<BookingHairs> list = new ArrayList<BookingHairs>();
					booking.setHairList(list);
					
					
					do {
						list.add(getBookingHairs(rs));
					}while(rs.next());
						return booking;
						
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		return null;
	}
	
	@Override
	public ArrayList<Integer> selectNoBooking(String id) {
		String sql = "SELECT DISTINCT book_no FROM booking_view WHERE guest_id = ? ORDER BY book_no desc";
		try (Connection con = JndiDs.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql)) {
				pstmt.setString(1, id);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					ArrayList<Integer> list = new ArrayList<>();
					do {
						list.add(rs.getInt(1));
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
	public ArrayList<Integer> selectNoStatus0(String id) {
		String sql = "SELECT DISTINCT book_no FROM booking_view WHERE guest_id = ? AND book_status = '0' ORDER BY book_no DESC";
		try (Connection con = JndiDs.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql)) {
				pstmt.setString(1, id);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					ArrayList<Integer> list = new ArrayList<>();
					do {
						list.add(rs.getInt(1));
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
	public ArrayList<Integer> selectNoStatus1(String id) {
		String sql = "SELECT DISTINCT book_no FROM booking_view WHERE guest_id = ? AND book_status = '1' ORDER BY book_no DESC";
		try (Connection con = JndiDs.getConnection(); 
				PreparedStatement pstmt = con.prepareStatement(sql)) {
				pstmt.setString(1, id);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					ArrayList<Integer> list = new ArrayList<>();
					do {
						list.add(rs.getInt(1));
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
	public int countStatus0(String id) {
		String sql = "SELECT COUNT(*) FROM (SELECT DISTINCT book_no FROM booking_view WHERE guest_id = ? AND BOOK_STATUS = '0')";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
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
	public int countStatus1(String id) {
		String sql = "SELECT COUNT(*) FROM (SELECT DISTINCT book_no FROM booking_view WHERE guest_id = ? AND BOOK_STATUS = '1')";
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)){
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
	
	
	/* Admin 쪽 */
	
	@Override
	public ArrayList<Booking> selectBookingAllToday() {
		String sql = "SELECT * FROM booking WHERE TO_CHAR(book_time, 'YYYY-MM-DD') = TO_CHAR(SYSDATE, 'YYYY-MM-DD')";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			try(ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					ArrayList<Booking> list = new ArrayList<>();
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
	public int countBookingByConditionForPaging(Paging paging, String where, String query, String sorter, String designer, String startDate, String endDate) {
		String sql = "SELECT COUNT(*) FROM booking_guest_view ";
		int cnt = 0;
		
		if(where == null) {
		} else if(where.equals("")) {
		} else {
			if(where.trim().equals("guestId")) {
				where = "guest_id";
			} else if (where.equals("guestName")) {
				where = "guest_name";
			} else if (where.equals("guestPhone")) {
				where = "REGEXP_REPLACE(guest_phone, '[^0-9]+')";
			}
			sql += " WHERE " + where + " LIKE '%" + query + "%'";
			cnt++;
		}
		
		if(sorter == null) {
		} else if (sorter.trim().equals("")) {
		} else {
			if(cnt == 1) {
				sql += " AND BOOK_STATUS = " + sorter;
			} else {
				sql += " WHERE BOOK_STATUS = " + sorter;
			}
			cnt++;
		}
		
		if(designer == null) {
		} else if (designer.trim().equals("")) {
		} else {
			if(cnt >= 1) {
				sql += " AND DE_NO = " + designer;
			} else {
				sql += " WHERE DE_NO = " + designer;
			}
			cnt++;
		}
		
		if(startDate == null) {
		} else if (startDate.trim().equals("")) {
		} else {
			if(cnt >= 1) {
				sql += " AND TO_CHAR(book_time, 'YYYY-MM-DD') >= '" + startDate + "' ";
			} else {
				sql += " WHERE TO_CHAR(book_time, 'YYYY-MM-DD') >= '" + startDate + "'";
			}
			cnt++;
		}
		
		if(endDate == null) {
		} else if (endDate.trim().equals("")) {
		} else {
			if(cnt >= 1) {
				sql += " AND TO_CHAR(book_time, 'YYYY-MM-DD') <= '" + endDate + "' ";
			} else {
				sql += " WHERE TO_CHAR(book_time, 'YYYY-MM-DD') <= '" + endDate + "' ";
			}
			cnt++;
		}
		
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
	
	
	@Override
	public ArrayList<Booking> selectBookingByCondition(Paging paging, String where, String query, String sorter, String designer, String startDate, String endDate) {
		
		String sql = "SELECT * FROM (SELECT rownum RN, a.* FROM (SELECT * FROM booking_guest_view ";
		int cnt = 0;
		
		if(where == null) {
			
		} else if(where.equals("")) {
			
		} else {
			if(where.trim().equals("guestId")) {
				where = "guest_id";
			} else if (where.equals("guestName")) {
				where = "guest_name";
			} else if (where.equals("guestPhone")) {
				where = "REGEXP_REPLACE(guest_phone, '[^0-9]+')";
			}
			sql += " WHERE " + where + " LIKE '%" + query + "%' ";
			cnt++;
		}
		
		if(sorter == null) {
		} else if (sorter.trim().equals("")) {
		} else {
			if(cnt == 1) {
				sql += " AND BOOK_STATUS = " + sorter;
			} else {
				sql += " WHERE BOOK_STATUS = " + sorter;
			}
			cnt++;
		}
		
		if(designer == null) {
		} else if (designer.trim().equals("")) {
		} else {
			if(cnt >= 1) {
				sql += " AND DE_NO = " + designer;
			} else {
				sql += " WHERE DE_NO = " + designer;
			}
			cnt++;
		}
		
		if(startDate == null) {
		} else if (startDate.trim().equals("")) {
		} else {
			if(cnt >= 1) {
				sql += " AND TO_CHAR(book_time, 'YYYY-MM-DD') >= '" + startDate + "' ";
			} else {
				sql += " WHERE TO_CHAR(book_time, 'YYYY-MM-DD') >= '" + startDate + "'";
			}
			cnt++;
		}
		
		if(endDate == null) {
		} else if (endDate.trim().equals("")) {
		} else {
			if(cnt >= 1) {
				sql += " AND TO_CHAR(book_time, 'YYYY-MM-DD') <= '" + endDate + "' ";
			} else {
				sql += " WHERE TO_CHAR(book_time, 'YYYY-MM-DD') <= '" + endDate + "' ";
			}
			cnt++;
		}
		
		sql += " ORDER BY book_no desc) a) WHERE rn BETWEEN ? AND ? ORDER BY rn";
		
		try (Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
			pstmt.setInt(1, paging.getStart());
			pstmt.setInt(2, paging.getEnd());
			try(ResultSet rs = pstmt.executeQuery()) {
				if(rs.next()) {
					ArrayList<Booking> list = new ArrayList<>();
					do {
						list.add(getSimpleBooking(rs));
					}while(rs.next());
					return list;
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		
		return null;
	}
	
}
