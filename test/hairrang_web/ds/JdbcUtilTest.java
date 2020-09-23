package hairrang_web.ds;

import java.sql.Connection;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

public class JdbcUtilTest {

	@Before
	public void setUp() throws Exception {
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void test() {
		System.out.println("testGetConnection()");
		Connection con = JdbcUtil.getConnection();
		System.out.println(con);
		Assert.assertNotNull(con);
	}

}
