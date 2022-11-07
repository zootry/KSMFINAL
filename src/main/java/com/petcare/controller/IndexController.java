package com.petcare.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.petcare.domain.CareReviewVo;
import com.petcare.domain.Files;
import com.petcare.service.CareReviewService;
import com.petcare.service.DolbomService;
import com.petcare.service.FileService;
import com.petcare.service.MemberService;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Controller
public class IndexController {
	private CareReviewService carereviewservice;
	private FileService fService;
	
	/*@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index() {
		return "index";
	}*/
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView index() {
		List<CareReviewVo> list = carereviewservice.selectList();
		List<String> fnames = new ArrayList<String>();
		for(CareReviewVo crlist : list) {
			List<Files> files = fService.getFiles(crlist.getCr_seq());
			if(files.isEmpty()) {
				fnames.add(null);
			}else {
				fnames.add(files.get(0).getFname());
			}
		}
		ModelAndView mv = new ModelAndView();
		mv.setViewName("index");
		mv.addObject("list", list); 
		mv.addObject("fnames", fnames);
		return mv;
	}
	@GetMapping("/display")
	public ResponseEntity<Resource> display(String imgName) {
		return fService.findFiles(imgName);
	}
	/*public ModelAndView ReviewList(SearchList searchlist) {
		List<CareReviewVo> list = new ArrayList<CareReviewVo>();
		
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
		mv.addObject("fnames", fnames);
		mv.addObject("dprofile", dprofile);
		return mv;
	}*/
	
}