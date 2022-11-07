package com.petcare.service;

import java.util.Random;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
public class MailSendService {
	@Autowired
	private JavaMailSenderImpl mailSender;
	private int authNumber;	
	public void makeRandomNumber() {
		Random r = new Random();
		int checkNum = r.nextInt(888888) + 111111;
		authNumber = checkNum;
	}		
	
	public String joinEmail(String email) {
		makeRandomNumber();
		String setFrom = "dolbom.kosmo@gmail.com";  
		String toMail = email;
		String title = "회원 가입 인증 이메일 입니다."; 
		String content = 
				"홈페이지를 방문해주셔서 감사합니다." +  
                "<br><br>" + 
			    "인증 번호는 " + authNumber + "입니다." + 
			    "<br>" + 
			    "해당 인증번호를 인증번호 확인란에 기입하여 주세요."; 
		mailSend(setFrom, toMail, title, content);
		return Integer.toString(authNumber);
	}		
	 
	public String rejoinEmail(String email) {
		makeRandomNumber();
		String setFrom = "dolbom.kosmo@gmail.com"; 
		String toMail = email;
		String title = "임시 비밀번호 발급 이메일 입니다.";  
		String content = 
				"임시 비밀번호를 보내 드립니다." + 	 
                "<br><br>" + 
			    "임시 비밀번호는 " + authNumber + "입니다." + 
			    "<br>" + 
			    "해당 번호를 통해 로그인 후 변경해주세요." + 
			    "<br>" +
			    "<a href='http://localhost:8080/member/login.do'>로그인하러 가기</a>"; 
		mailSend(setFrom, toMail, title, content);
		return Integer.toString(authNumber);
	}
	
	public void mailSend(String setFrom, String toMail, String title, String content) { 
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message,true,"utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content,true);
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
}