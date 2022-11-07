package com.petcare.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.petcare.domain.Info;
import com.petcare.domain.Member;
import com.petcare.domain.MemberVo;
import com.petcare.domain.Report;
import com.petcare.service.InfoService;
import com.petcare.service.MemberService;
import com.petcare.service.ReportService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/admin")
@Controller
public class AdministratorController {
	private MemberService memberservice;
	private InfoService infoservice;
	private ReportService reportservice;
	
	@GetMapping("/main.do")
	public ModelAndView main() {
		List<Info> listinfo = new ArrayList<Info>();
		List<Member> listmember = new ArrayList<Member>();
		List<Report> listreport = new ArrayList<Report>();
		ModelAndView mv = new ModelAndView("administrator/main");
		listinfo = infoservice.listS();
		listmember = memberservice.userlistS();
		listreport = reportservice.listS();
		mv.addObject("listinfo",listinfo);
		mv.addObject("listmember",listmember);
		for(int i=0;i<listmember.size();i++) {
	         if(listmember.get(i).getM_seq().contains("ADMIN")) {
	            listmember.remove(i);
	         }
		}
		mv.addObject("listreport",listreport);
		return mv;
	}
	
	@GetMapping("/useroperating.do")
	public ModelAndView useroperating(String m_seq) {
		Member member = new Member();
		member = memberservice.getMyinfoS(m_seq);
		ModelAndView mv = new ModelAndView("administrator/useroperating","member",member);
		return mv;
	}
	@GetMapping("/userlist.do")
	public ModelAndView userlist(HttpServletRequest request, HttpSession session, String usercatgo, String userkeyword, String usersearchModeStr) {
		String cpStr = request.getParameter("usercp");
		int cp = 1;
		if(cpStr == null) {
			Object cpObj = session.getAttribute("usercp");
			if(cpObj != null) {
				cp = (Integer)cpObj;
			}
		}else {
			cpStr = cpStr.trim();
			cp = Integer.parseInt(cpStr);
		}
		session.setAttribute("usercp", cp);
		
		int ps = 10;
		session.setAttribute("ps", ps);
		
		if(usercatgo == null) {
			Object catgoObj = session.getAttribute("usercatgo");
			if(catgoObj != null) {
				usercatgo = (String) catgoObj;
			}
		}else {
			usercatgo = usercatgo.trim();
		}
		session.setAttribute("usercatgo", usercatgo);
		
		if(userkeyword == null) {
			Object userkeywordObj = session.getAttribute("userkeyword");
			if(userkeywordObj != null) {
				userkeyword = (String) userkeywordObj;
			}
		}else {
			userkeyword = userkeyword.trim();
		}
		session.setAttribute("userkeyword", userkeyword);
		
		if(usersearchModeStr == null) {
			Object usersearchModeStrObj = session.getAttribute("usersearchModeStr");
			if(usersearchModeStrObj != null) {
				usersearchModeStr = (String) usersearchModeStrObj;
			}else {
				usersearchModeStr = "F";
			}
		}else {
			usersearchModeStr = usersearchModeStr.trim();
		}
		session.setAttribute("usersearchModeStr", usersearchModeStr);
		
		boolean searchMode = false;
		if(usersearchModeStr.equalsIgnoreCase("T")) {
			searchMode = true;
		}
		MemberVo memberVo = null;
		if(!searchMode) {
			memberVo = memberservice.getMemberVo(cp, ps);
		}else {
			memberVo = memberservice.getMemberVo(cp, ps, usercatgo, userkeyword);
		}
		memberVo.setRange(cp);
		ModelAndView mv = new ModelAndView("administrator/userlist", "memberVo", memberVo);
		for(int i=0;i<memberVo.getList().size();i++) {
	         if(memberVo.getList().get(i).getM_seq().contains("ADMIN")) {
	            memberVo.getList().remove(i);
	         }
		}
		if(memberVo.getList().size() == 0) {
			if(cp>1) {
				return new ModelAndView("redirect:list.do?usercp="+(cp-1));
			}else {
				return new ModelAndView("administrator/userlist","memberVo", null);
			}
		}else {
			return mv;
		}
	}
	@PostMapping("/update.do")
	public String update(String m_seq, String email, String pwd, String nickname, String phone, String addr, String sat) {
		Member member = new Member();
		member.setAddr(addr);
		float satis = Float.parseFloat(sat);
		member.setSat(satis);
		member.setEmail(email);
		member.setNickname(nickname);
		member.setPwd(pwd);
		member.setPhone(phone);
		member.setM_seq(m_seq);
		memberservice.userupdateS(member);
		return "redirect:userlist.do";
	}
	@GetMapping("/useroperatingemail.do")
	public ModelAndView useroperatingemail(String email) {
		Member member = new Member();
		member = memberservice.userbyemailS(email);
		ModelAndView mv = new ModelAndView("administrator/useroperating","member",member);
		return mv;
	}
	@GetMapping("/delete.do")
	public String delete(String m_seq) {
		memberservice.deleteMS(m_seq);
		return "redirect:userlist.do";
	}
	@GetMapping("/checkdelete.do")
	public String checkdelete(@RequestParam(value="del_list[]") List<String> del_list) {
		for(int i=0;i<del_list.size();i++) {
			String m_seq = del_list.get(i);
			memberservice.deleteMS(m_seq);
		}
		return "redirect:userlist.do";
	}
}