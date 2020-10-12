package hairrang_web.controller.mail;

import java.util.Random;

import javax.mail.MessagingException;

public class TestMain {
	public static void main(String[] args) {
		 String from = "official.hairrang@gmail.com";    // 메일 보내는 사람
		 String to = "chini91@naver.com";   // 메일 보낼사람
		 String cc = "";     // 참조
		 String subject = "[hairrang] 임시 비밀번호 발급 안내";// 제목
		 String content = "안녕하세요. \n";
		 content += "고객님의 임시 비밀번호는 \n";
		 content += createKey() + " 입니다. \n";
		 content += "로그인 후 비밀번호를 변경하세요.";
		  
		 if(from.trim().equals("")) {
		  System.out.println("보내는 사람을 입력하지 않았습니다.");
		  
		 } else if(to.trim().equals("")) {
		  System.out.println("받는 사람을 입력하지 않았습니다.");
		  
		 } else {
		   try {
		    SendMail mt = new SendMail();
		    
		    // 메일보내기
		    mt.sendEmail(from, to, cc, subject, content);
		    System.out.println("메일 전송에 성공하였습니다.");
		   }
		   catch(MessagingException me) {
		    System.out.println("메일 전송에 실패하였습니다.");
		    System.out.println("실패 이유 : messaging" + me.getMessage());
		   }
		   catch(Exception e) {
		    System.out.println("메일 전송에 실패하였습니다.");
		    System.out.println("실패 이유 : " + e.getMessage());
		   }
		  }
	}
	
	public static String createKey() {
		char pwd[] = new char[] { '1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'A', 'B', 'C', 'D', 'E',
				'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
				'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u',
				'v', 'w', 'x', 'y', 'z'};// 배열에 선언

		String random = "";

		for (int i = 0; i < 10; i++) {
			int selectRandomPw = (int) (Math.random() * (pwd.length));
			random += pwd[selectRandomPw];
		}
		return random;

	}
 
}
