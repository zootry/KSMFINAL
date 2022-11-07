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
		String title = "ȸ�� ���� ���� �̸��� �Դϴ�."; 
		String content = 
				"Ȩ�������� �湮���ּż� �����մϴ�." +  
                "<br><br>" + 
			    "���� ��ȣ�� " + authNumber + "�Դϴ�." + 
			    "<br>" + 
			    "�ش� ������ȣ�� ������ȣ Ȯ�ζ��� �����Ͽ� �ּ���."; 
		mailSend(setFrom, toMail, title, content);
		return Integer.toString(authNumber);
	}		
	 
	public String rejoinEmail(String email) {
		makeRandomNumber();
		String setFrom = "dolbom.kosmo@gmail.com"; 
		String toMail = email;
		String title = "�ӽ� ��й�ȣ �߱� �̸��� �Դϴ�.";  
		String content = 
				"�ӽ� ��й�ȣ�� ���� �帳�ϴ�." + 	 
                "<br><br>" + 
			    "�ӽ� ��й�ȣ�� " + authNumber + "�Դϴ�." + 
			    "<br>" + 
			    "�ش� ��ȣ�� ���� �α��� �� �������ּ���." + 
			    "<br>" +
			    "<a href='http://localhost:8080/member/login.do'>�α����Ϸ� ����</a>"; 
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