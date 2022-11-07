package com.petcare.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginController {
	@RequestMapping(value = "member/login.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String login(Model model, HttpSession session) {
		return "member/login";
	}
	
}