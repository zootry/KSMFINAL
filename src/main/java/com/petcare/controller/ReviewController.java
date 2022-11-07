package com.petcare.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.petcare.domain.CareReview;
import com.petcare.domain.CareReviewVo;
import com.petcare.domain.Dolbom;
import com.petcare.domain.Dolbomlist;
import com.petcare.domain.Files;
import com.petcare.domain.Member;
import com.petcare.domain.Objects;
import com.petcare.domain.Pet;
import com.petcare.domain.SearchList;
import com.petcare.service.CareReviewService;
import com.petcare.service.DolbomService;
import com.petcare.service.FileService;
import com.petcare.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/review")
@Controller
public class ReviewController {
	private CareReviewService carereviewservice;
	private MemberService memberservice;
	private DolbomService dolbomservice;
	private FileService fService;

	@GetMapping("/list.do") //리스트 띄우기 +검색
	public ModelAndView list(SearchList searchlist) {
		List<CareReviewVo> list = new ArrayList<CareReviewVo>();
		String category = searchlist.getCategory();
		String keyword = searchlist.getKeyword();
		
		if(category==null&&keyword==null) {
			list = carereviewservice.selectList();
		}else if(category.equals("all")) {
			list = carereviewservice.selectSearchAllS(keyword);
		}else {
			list = carereviewservice.selectSearchS(category, keyword);
		}
		
		List<String> fnames = new ArrayList<String>();
		List<String> dprofile = new ArrayList<String>();
		for(CareReviewVo crlist : list) {
			List<Files> files = fService.getFiles(crlist.getCr_seq());
			List<Files> pfiles = fService.getFiles(crlist.getM_seq());
			if(files.isEmpty()) {
				fnames.add(null);
			}else {
				fnames.add(files.get(0).getFname());
			}
			if(pfiles.isEmpty()) {
				dprofile.add(null);
			}else {
				dprofile.add(pfiles.get(0).getFname());
			}
		}
		ModelAndView mv = new ModelAndView();
		mv.setViewName("review/list");
		mv.addObject("list", list); 
		mv.addObject("category", category);
		mv.addObject("keyword", keyword);
		mv.addObject("fnames", fnames);
		mv.addObject("dprofile", dprofile);
		return mv;
	}
	
	@PostMapping("/write")
	public @ResponseBody boolean write(CareReview carereview,HttpSession session,ArrayList<MultipartFile> multipartFiles){
		//log.info("@@@@dl_seq"+dl_seq);
		if(multipartFiles != null) {
			for(MultipartFile image : multipartFiles) {
				String ofName = image.getOriginalFilename().trim();
				if(ofName.length() == 0) return false;
			}
			fService.setFiles(multipartFiles, "CR"+carereview.getDl_seq(), "CR");
		}
		String writerEmail = (String)session.getAttribute("email");
		String writerNickname = memberservice.getNicknameS(writerEmail);
		carereview.setWriterEmail(writerEmail);
		carereview.setWriter(writerNickname);
		carereview.setContent(carereview.getContent().replace("\r\n", "<br/>"));
		carereviewservice.insertS(carereview);
		dolbomservice.finishReview(carereview.getDl_seq());
		//회원 평점 업데이트
		log.info("@@star"+carereview.getStar());
		memberservice.setMemberStar(carereview);
		return true;
	}

	@GetMapping("/write.do")
	public ModelAndView write(HttpSession session,long dl_seq) {
		String useremail = (String)session.getAttribute("email");
		Dolbomlist dlist = dolbomservice.selectforComt(dl_seq);
		String writer = dlist.getRequester();
		String state = dlist.getState();
		ModelAndView mv = new ModelAndView();
		Member dolbomy = memberservice.getDolbomyInfo(dlist.getDolbomy());
		if(useremail.equals(writer)&&state.equals("완료")) {
			String dolbomyNick=memberservice.getNicknameS(dlist.getDolbomy());			
			mv.setViewName("review/write");
			mv.addObject("dlist", dlist);
			mv.addObject("dolbomy", dolbomy);
			mv.addObject("dolbomyNick", dolbomyNick);			
		}else {
			mv.setViewName("dolbom/list");
			mv.addObject("errorMsg","돌봄 미종료 또는 후기를 작성할 돌보미가 없습니다.");
		}
		return mv;
	}
	@GetMapping("/writeList")// 
	public ModelAndView write(HttpSession session) {
		String email = (String)session.getAttribute("email");
			
		List<Dolbomlist> list = dolbomservice.reviewList(email);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("review/writeList");
		mv.addObject("reviewList",list);
		log.info("@@reviewList"+list);
		/*Dolbomlist dlist = dolbomservice.selectforComt(dl_seq);
		String writer = dlist.getRequester();
		String state = dlist.getState();
		ModelAndView mv = new ModelAndView();
		if(useremail.equals(writer)&&state.equals("완료")) {
			String dolbomyNick=memberservice.getNicknameS(dlist.getDolbomy());			
			mv.setViewName("review/write");
			mv.addObject("dlist", dlist);
			mv.addObject("dolbomyNick", dolbomyNick);			
		}else {
			mv.setViewName("dolbom/list");
			mv.addObject("errorMsg","돌봄 미종료 또는 후기를 작성할 돌보미가 없습니다.");
		}*/		
		return mv;
	}

	@GetMapping("/content.do") //list에서 선택글 세부내용 확인
	public ModelAndView contentS(String cr_seq) {// contentS String타입으로 cr_seq
		CareReview carereview = carereviewservice.selectBySeqS(cr_seq);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("review/content");
		mv.addObject("carereview", carereview); // carereview carereview값을 보내줌
		mv.addObject("imgNames", fService.getFiles(cr_seq));
		return mv;
	}

	@GetMapping("/del.do") //content에 들어가서 삭제
	public String delete(String cr_seq) {
		carereviewservice.deleteS(cr_seq);
		return "redirect:list.do";
	}

	@GetMapping("/update") //수정누르면 이전정보가져와서 띄우기
	public ModelAndView update(String cr_seq) {	
		CareReview crv = carereviewservice.selectBySeqS(cr_seq);
		Member dolbomy = memberservice.getDolbomyInfo(crv.getDolbomyEmail());
		ModelAndView mv = new ModelAndView("review/update");
		mv.addObject("carereview", crv);
		mv.addObject("dolbomy", dolbomy);
		mv.addObject("files", fService.getFiles(cr_seq));
		return mv;
	}
	@PostMapping("/update")
    public @ResponseBody boolean update(CareReview carereview,ArrayList<MultipartFile> multipartFiles,Objects fnames) {
		if(fnames.getFnames() != null) {
			for(String fname : fnames.getFnames()) {
				fService.removeFiles(fname);
			}
		}
		if(multipartFiles != null) {
			for(MultipartFile image : multipartFiles) {
				String ofName = image.getOriginalFilename().trim();
				if(ofName.length() == 0) return false;
			}
			fService.setFiles(multipartFiles, carereview.getCr_seq(), "CR");
		}
		log.info("@updatecarereview"+carereview);
		carereview.setContent(carereview.getContent().replace("\r\n", "<br/>"));
		carereviewservice.editS(carereview);
		//회원 평점 업데이트
		memberservice.setMemberStar(carereview);
		return true; 
	}
	
	@GetMapping("searchOrder")
	public @ResponseBody HashMap<String, Object> searchOrder(String order) {
		List<CareReviewVo> list = new ArrayList<CareReviewVo>();
		if(order.equals("최신순")) {
			list = carereviewservice.rankingDateS();
		}else if(order.equals("별점순")) {
			list = carereviewservice.rankingStarS();
		}
		List<String> fnames = new ArrayList<String>();
		List<String> dprofile = new ArrayList<String>();
		for(CareReviewVo crlist : list) {
			List<Files> files = fService.getFiles(crlist.getCr_seq());
			List<Files> pfiles = fService.getFiles(crlist.getM_seq());
			if(files.isEmpty()) {
				fnames.add(null);
			}else {
				fnames.add(files.get(0).getFname());
			}
			if(pfiles.isEmpty()) {
				dprofile.add(null);
			}else {
				dprofile.add(pfiles.get(0).getFname());
			}
		}
		HashMap<String, Object> results = new HashMap<String, Object>();
		results.put("list",list);
		results.put("fnames",fnames);
		results.put("dprofile",dprofile);
		log.info("@@fnames: "+fnames);
		return results;
	}
	@GetMapping("/display")
	public ResponseEntity<Resource> display(String imgName) {
		return fService.findFiles(imgName);
	}
}