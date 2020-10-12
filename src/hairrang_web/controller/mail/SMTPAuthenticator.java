package hairrang_web.controller.mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticator extends Authenticator {
	/**
	 * @author Ray
	 *
	 */
	 protected PasswordAuthentication getPasswordAuthentication() {
	  String username = "official.hairrang@gmail.com"; // gmail 사용자;
	  String password = "hairrang1234";  // 패스워드;
	  return new PasswordAuthentication(username, password);
	 }
}
