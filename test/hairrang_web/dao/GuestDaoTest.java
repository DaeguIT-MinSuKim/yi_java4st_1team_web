package hairrang_web.dao;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;

import hairrang_web.dao.impl.BookingDaoImpl;
import hairrang_web.dao.impl.GuestDaoImpl;
import hairrang_web.ds.JdbcUtil;
import hairrang_web.dto.Booking;
import hairrang_web.dto.Guest;
import javafx.util.converter.LocalDateStringConverter;


@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class GuestDaoTest {
	private static GuestDaoImpl dao;
	
	private static Connection con = JdbcUtil.getConnection();
	
	@BeforeClass
	public static void setUpBeforeClass() throws Exception{
		dao = GuestDaoImpl.getInstance();
		dao.setCon(con);

	}
	
	//@Test
	public void testSelectGuestAll() {
		System.out.println("selectGuestAll()");
		ArrayList<Guest> list = dao.selectGuestAll();
		Assert.assertNotNull(list);
		list.stream().forEach(System.out::println);
	}

	//@Test
	public void testSelectGuestById() {
		System.out.println("selectId");
		Guest guest = dao.selectGuestById(new Guest("test"));
		Assert.assertNotNull(guest);
		System.out.println(guest);
	}

//	@Test
	public void testInsertGuest() {
		
		System.out.println("insert");
		Guest guest = new Guest("test3", "1234", "이지수", LocalDate.now(), "010-1234-1234", "test3@test.com",1,  null, "y");
		int res = dao.insertGuest(guest);
		Assert.assertNotNull(res);
		
	}

	//@Test
	public void testUpdateGuestPwd() {
		Guest guest = dao.selectGuestById(new Guest("test"));
		String pwd = "tt1234";
		guest.setGuestPwd(pwd);
		int res = dao.updateGuestPwd(guest);
		Assert.assertEquals(1, res);
	}
	
	//@Test
	public void testUpdateGuestInfo() {
		String date = "1991-12-19";
		LocalDate birth = LocalDate.parse(date, DateTimeFormatter.ISO_DATE);
		
		Guest g = dao.selectGuestById(new Guest("test"));
		System.out.println(g);
		g.setGuestName("변경");
		g.setGuestBirthday(birth);
		g.setGuestGender(1);
		g.setGuestEmail("이메일변경");
		g.setGuestPhone("010-000-0000");
		g.setInfoYn("n");
		
		int res = dao.updateGuest(g);
		Assert.assertEquals(1, res);
	}
	

	//@Test
	public void testDeleteGuest() {
		fail("Not yet implemented");
	}

	//@Test
	public void testCheckPwd() {
		fail("Not yet implemented");
	}
	
	//@Test
	public void confirmId() {
		//있으면 1 없으면 -1
		int res = dao.confirmId("one");
		Assert.assertNotNull(res);
		System.out.println(res);
		
	}
	
	//@Test
	public void findId() {
		Guest guest = dao.findId("김혜진", "hoon@test.co.kr");
		Assert.assertNotNull(guest);
		System.out.println(guest);
	}
	
	//@Test
	public void findPwd() {
		Guest guest = dao.findPwd("test2", "김혜진", "hoon@test.co.kr");
		Assert.assertNotNull(guest);
		System.out.println(guest);
	}
	

}
