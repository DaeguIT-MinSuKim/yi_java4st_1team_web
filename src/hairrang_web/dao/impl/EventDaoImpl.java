package hairrang_web.dao.impl;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;

import hairrang_web.dao.EventDao;
import hairrang_web.ds.JndiDs;
import hairrang_web.dto.Event;

public class EventDaoImpl implements EventDao {

	private static final EventDaoImpl instance = new EventDaoImpl();
	
	private EventDaoImpl() {
		// TODO Auto-generated constructor stub
	}
	
	public static EventDaoImpl getInstance() {
		return instance;
	}

	@Override
	public ArrayList<Event> selectEventAll() {
		String sql = "SELECT * FROM EVENT";
		
		try(Connection con = JndiDs.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery()) {

			if(rs.next()) {
				ArrayList<Event> list = new ArrayList<>();
				do {
					list.add(getEvent(rs));
				} while(rs.next());
				return list;
			}
			
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		
		return null;
	}

	private Event getEvent(ResultSet rs) throws SQLException {
		int eventNo = rs.getInt("EVENT_NO");
		String eventName = rs.getString("EVENT_NAME");
		double eventSaleRate = rs.getFloat("EVENT_SALERATE");
		LocalDate eventStart = rs.getTimestamp("EVENT_START").toLocalDateTime().toLocalDate();
		LocalDate eventEnd = rs.getTimestamp("EVENT_END").toLocalDateTime().toLocalDate();
		String eventPic = rs.getString("EVENT_PIC");
		String eventContent = rs.getString("EVENT_CONTENT");
		
		return new Event(eventNo, eventName, eventSaleRate, eventStart, eventEnd, eventPic, eventContent);
	}

	@Override
	public Event selectEventByNo(Event event) {
		String sql = "SELECT * FROM EVENT WHERE EVENT_NO = ?";
		
		try(Connection con = JndiDs.getConnection();
			PreparedStatement pstmt = con.prepareStatement(sql)) {
			
			pstmt.setInt(1, event.getEventNo());
			
			try(ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					return getEvent(rs);
				}
			}
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
		
		return null;
	}

	@Override
	public int insertEvent(Event event) {
		String sql = "INSERT INTO EVENT(EVENT_NAME, EVENT_SALERATE, EVENT_START, EVENT_END, EVENT_PIC, EVENT_CONTENT) "
				+ "VALUES(?, ?, ?, ?, ?, ?)";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
				
			pstmt.setString(1, event.getEventName());
			pstmt.setDouble(2, event.getEventSaleRate());
			pstmt.setDate(3, Date.valueOf(event.getEventStart()));
			pstmt.setDate(4, Date.valueOf(event.getEventEnd()));
			pstmt.setString(5, event.getEventPic());
			pstmt.setString(6, event.getEventContent());
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	
	}

	@Override
	public int updateEvent(Event event) {
		String sql = "UPDATE EVENT SET EVENT_NAME = ?, EVENT_SALERATE = ?, EVENT_START = ?, "
				+ "EVENT_END = ?, EVENT_PIC = ?, EVENT_CONTENT = ? WHERE EVENT_NO = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
				
			pstmt.setString(1, event.getEventName());
			pstmt.setDouble(2, event.getEventSaleRate());
			pstmt.setDate(3, Date.valueOf(event.getEventStart()));
			pstmt.setDate(4, Date.valueOf(event.getEventEnd()));
			pstmt.setString(5, event.getEventPic());
			pstmt.setString(6, event.getEventContent());
			pstmt.setInt(7, event.getEventNo());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

	@Override
	public int deleteEvent(Event event) {
		String sql = "DELETE EVENT WHERE EVENT_NO = ?";
		
		try(Connection con = JndiDs.getConnection();
				PreparedStatement pstmt = con.prepareStatement(sql)) {
				
			pstmt.setInt(1, event.getEventNo());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

}