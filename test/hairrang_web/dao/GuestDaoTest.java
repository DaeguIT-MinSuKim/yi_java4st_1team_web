package hairrang_web.dao;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.time.LocalDate;
import java.util.ArrayList;

import org.junit.Assert;
import org.junit.BeforeClass;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runners.MethodSorters;

import hairrang_web.dao.impl.GuestDaoImpl;
import hairrang_web.ds.JdbcUtil;
import hairrang_web.dto.Guest;


@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class GuestDaoTest {
	private static GuestDaoImpl dao;
	private static Connection con = JdbcUtil.getConnection();
	
	@BeforeClass
	public static void setUpBeforeClass() throws Exception{
		dao = GuestDaoImpl.getInstance();
		dao.setCon(con);
	}
	
	@Test
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
	public void testUpdateGuest() {
		
	}

	//@Test
	public void testUpdateGuestPwd() {
		fail("Not yet implemented");
	}

	//@Test
	public void testDeleteGuest() {
		fail("Not yet implemented");
	}

	//@Test
	public void testCheckPwd() {
		fail("Not yet implemented");
	}

}
