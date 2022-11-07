package com.petcare.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.petcare.domain.Files;
import com.petcare.domain.Member;
import com.petcare.domain.Objects;
import com.petcare.domain.Pet;
import com.petcare.service.AddressService;
import com.petcare.service.FileService;
import com.petcare.service.MailSendService;
import com.petcare.service.MemberService;
import com.petcare.service.PetService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/member")
@Controller
public class MemberController {
	private MailSendService mailService;	
	private MemberService mService;
	private PetService pService;
	private FileService fService;
	private AddressService addressservice;

	@GetMapping("/goSignupM.do")
	public String goSignupM() {
		return "member/signup";
	}
	@GetMapping("/mypage.do")
	public String goMypage() {
		return "member/mypage";
	}
	@GetMapping("/goSignupP.do")
	public String goSignupP() {
		return "/member/signupPet";
	}	
	@PostMapping("/signup.do")
	public String signupM(Member member, HttpSession session, ArrayList<MultipartFile> multipartFiles){
		if(multipartFiles != null) {
			for(MultipartFile image : multipartFiles) {
				String ofName = image.getOriginalFilename().trim();
				if(ofName.length() == 0) log.info("사진을 로드하는데 실패했습니다");
			}
			log.info("서비스 전");
			fService.setFiles(multipartFiles, member.getM_seq(), "M");
			log.info("서비스 후");
		}		
		mService.signupMS(member);
		return "redirect:login.do";
	}	
	@GetMapping(value="mypage.do", params = {"m_seq"})
	public ModelAndView getMyinfo(@RequestParam("m_seq") String m_seq,HttpSession session) {
		Member memberone = mService.getMyinfoS(m_seq);
		String email = (String) session.getAttribute("email");
		String mydong = addressservice.selectMydong(email);
		ModelAndView mv = new ModelAndView("member/mypage", "memberone", memberone);
		List<Files> profile = fService.getFiles(m_seq);
		mv.addObject("profile", profile);
		mv.addObject("mydong",mydong);
		return mv;						
	}
	@PostMapping("/updateM.do")
	public String updateM(HttpSession session,Member member, ArrayList<MultipartFile> multipartFiles, Objects fnames){
		if(fnames.getFnames() != null) {
			for(String fname : fnames.getFnames()) {
				fService.removeFiles(fname);
			}
		}
		if(multipartFiles != null) {
			for(MultipartFile image : multipartFiles) {
				String ofName = image.getOriginalFilename().trim();
				if(ofName.length() == 0) log.info("수정 실패");
			}
			log.info("#####: "+member.getM_seq());
			fService.setFiles(multipartFiles, member.getM_seq(),"M");
		}
		mService.updateMS(member);
		session.setAttribute("member", member);
	    return "member/mypage";
	}
	@GetMapping(value="deleteM.do", params = {"m_seq"})
	public String deleteM(@RequestParam("m_seq") String m_seq, HttpServletRequest httprequest) {
		mService.deleteMS(m_seq);
		fService.deleteS(m_seq);
		HttpSession session = httprequest.getSession();
		session.invalidate();
		return "redirect:/";
	}
	@PostMapping("/emailCheck.do")
	@ResponseBody
	public String checkEmail(@RequestParam("email") String id) {
		String cid = mService.checkEmailS(id);
		if(id.equals(cid)) {
			return "T";
		}else {
			return "F";
		}		
	}
	@PostMapping("/nickCheck.do")
	@ResponseBody
	public String checkNick(@RequestParam("nick") String nick) {
		String cnick = mService.checkNickS(nick);
		if(nick.equals(cnick)) {
			return "T";
		}else {
			return "F";
		}		
	}
	@GetMapping("/mailCheck")
	@ResponseBody
	public String checkMail(String email) {		
		return mailService.joinEmail(email);
	}
	@PostMapping("/resetPwd")
	@ResponseBody
	public String resetPwd(String email, String phone) {
		Member member = mService.checkLoginS(email);
		if(member != null) {	
			String truePhone = member.getPhone();		
			if (!truePhone.equals(phone)) {
				return "wp";
			}else {					
				String pwd = mailService.rejoinEmail(email);
				mService.resetPwdS(email, pwd);
				return pwd;
			}			
		}else {
			return "err";
		}		
	}
	@PostMapping("/loginCheck.do")
	@ResponseBody
	public ModelAndView checkLogin(String id, String pwd, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		Member member = mService.checkLoginS(id);
		if(member != null) {
			String truePwd = member.getPwd();		
			if (!truePwd.equals(pwd)) {
				mv.setViewName("member/login");
				mv.addObject("loginStat", "lf");
				return mv;
			} else {
				member.setPwd("classified");
				member.setPhone("classified");
				session.setAttribute("member", member);
				session.setAttribute("email", member.getEmail());
				mv.setViewName("redirect:/");
				return mv;
			}
		} else {
			mv.setViewName("member/login");
			mv.addObject("loginStat", "err");
			return mv;
		}				
	}
	@GetMapping("/logout.do")
	public String logout(HttpServletRequest httprequest) {
		HttpSession session = httprequest.getSession();
		session.invalidate();
		return "redirect:/";
	}
	//펫 C	
	@PostMapping("/signupPet.do")
	public String signupP(Pet pet, HttpSession session, ArrayList<MultipartFile> multipartFiles){
		if(multipartFiles != null) {
			for(MultipartFile image : multipartFiles) {
				String ofName = image.getOriginalFilename().trim();
				if(ofName.length() == 0) log.info("사진을 로드하는데 실패");
			}
			fService.setFiles(multipartFiles, pet.getPetseq(), "pet");
		}
		pService.signupPS(pet);
		return "redirect:mypage.do";
	}
	@GetMapping("/checkPet.do")
	@ResponseBody
	public HashMap<String, Object> getPetinfo(@RequestParam("email") String id) {
		List<HashMap<String, Object>> lists = new ArrayList<HashMap<String, Object>>();
		for(Pet pet: pService.getPetinfoS(id)) {
			HashMap<String, Object> petinfo = new HashMap<String, Object>();
			List<Files> petpic = fService.getFiles(pet.getPetseq());
			if(petpic.size() == 0) {
				petinfo.put("pet", pet);
				petinfo.put("fname", null);
			}else {
				petinfo.put("pet", pet);
				petinfo.put("fname", petpic.get(0).getFname());
			}
			lists.add(petinfo);
		}
		HashMap<String, Object> results = new HashMap<String, Object>();
		results.put("lists", lists);
		log.info("@@lists"+lists);
		return results;
	}
	@PostMapping("/updateP.do")
	public String updateP(Pet pet, ArrayList<MultipartFile> multipartFiles, Objects fnames){
		if(fnames != null && fnames.getFnames() != null) {
			for(String fname : fnames.getFnames()) {
				fService.removeFiles(fname);
			}
		}
		if(multipartFiles != null) {
			for(MultipartFile image : multipartFiles) {
				String ofName = image.getOriginalFilename().trim();
				if(ofName.length() == 0) log.info("수정 실패");
			}
			fService.setFiles(multipartFiles, pet.getPetseq(), "pet");
		}
		pService.updatePS(pet);
		return "redirect:mypage.do";
	}
	@GetMapping(value="deleteP.do", params = {"petseq"})
	public String deleteP(@RequestParam("petseq") String petseq) {
		pService.deletePS(petseq);
		fService.deleteS(petseq);
		return "member/mypage";
	}
	@GetMapping(value="myinfo.do", params = {"m_seq"})
	public ModelAndView printMyinfo(@RequestParam("m_seq") String m_seq) {
		Member memberone = mService.getMyinfoS(m_seq);
		ModelAndView mv = new ModelAndView("member/update", "memberone", memberone);
		List<Files> profile = fService.getFiles(m_seq);
		mv.addObject("profile", profile);
		return mv;
	}
	@GetMapping(value="updatePinfo.do", params = {"petseq"})
	public ModelAndView getOnePet(@RequestParam("petseq") String petseq) {
		Pet petone = pService.getOnePetS(petseq);
		ModelAndView mv = new ModelAndView("member/updatePet", "petone", petone);
		List<Files> profile = fService.getFiles(petseq);
		mv.addObject("profile", profile);
		return mv;
	}
	@GetMapping("/display")
	public ResponseEntity<Resource> display(String imgName) {
		return fService.findFiles(imgName);
	}	
}