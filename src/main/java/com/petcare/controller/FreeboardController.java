package com.petcare.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.petcare.domain.Files;
import com.petcare.domain.Freeboard;
import com.petcare.domain.Gallery;
import com.petcare.domain.LikesList;
import com.petcare.domain.Objects;
import com.petcare.service.ComntService;
import com.petcare.service.FileService;
import com.petcare.service.FreeboardService;
import com.petcare.service.GalleryService;
import com.petcare.service.LikesListService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/freeboard")
@Controller
public class FreeboardController {
	private FreeboardService freeboardService;
	private FileService fileService;
	private LikesListService likeListService;

	@GetMapping("/list")
	public ModelAndView list() {
		List<Freeboard> list = freeboardService.list();
		ModelAndView mv = new ModelAndView("freeboard/list", "list", list);
		// log.info("#list:"+list);
		return mv;
	}

	// 글 내용
	@GetMapping("/content")
	public ModelAndView content(String fb_seq) {
		Freeboard list = freeboardService.content(fb_seq);
		// log.info("#content:"+list);
		ModelAndView mv = new ModelAndView("freeboard/content", "list", list);
		return mv;
	}

	@GetMapping("/write")
	public String write() {
		return "freeboard/write";
	}

	// 글 작성
	@PostMapping("/write")
	public String write(Freeboard freeboard, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		freeboard.setEmail(email);
		freeboardService.write(freeboard);
		// log.info("#freeboard:"+freeboard);
		return "redirect:list";
	}

	// 글 삭제
	@GetMapping("/delete")
	public String delete(String fb_seq) {
		freeboardService.delete(fb_seq);
		return "redirect:list";
	}

	@GetMapping("/update")
	public ModelAndView update(String fb_seq) {
		Freeboard freeboardList = freeboardService.updateList(fb_seq);
		log.info("#updateList:"+freeboardList);
		ModelAndView mv = new ModelAndView("freeboard/update", "freeboardList", freeboardList);
		return mv;
	}

	// 글 수정
	@PostMapping("update")
	public String update(Freeboard freeboard) {
		freeboardService.update(freeboard);
		String fb_seq = freeboard.getFb_seq();
		log.info("getFb_seq:"+fb_seq);
		return "redirect:list";
	}

	//////////////////////// 여기서부턴 갤러리////////////////////////
	private GalleryService galleryService;

	// 갤러리 리스트
	@GetMapping("/galleryList")
	public ModelAndView gallery(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		List<Gallery> galleryList = galleryService.galleryList();
		log.info("#galleryList:"+galleryList);
		//log.info("#g_seq:"+g_seq);
		List<String> fnames = new ArrayList<String>();
		for(Gallery list : galleryList) {
			List<Files> files = fileService.getFiles(list.getG_seq());
			if(files.isEmpty()) {
				fnames.add(null);
			}else {
				fnames.add(files.get(0).getFname());
			}
		}			
		//log.info("@galleryFnames111:"+fnames);	
		ModelAndView mv = new ModelAndView();
		mv.addObject("galleryList", galleryList);
		mv.addObject("imgNames", fnames);
		return mv;
	}

	// 내가 쓴 게시물
	@GetMapping("/galleryMyList")
	public ModelAndView galleryMyList(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		String email = (String) session.getAttribute("email");
		List<Gallery> galleryMyList = galleryService.galleryMyList(email);
		log.info("#galleryMyList:"+galleryMyList);
		List<String> fnames = new ArrayList<String>();
		for(Gallery list : galleryMyList) {
			List<Files> files = fileService.getFiles(list.getG_seq());
			if(files.isEmpty()) {
				fnames.add(null);
			}else {
				fnames.add(files.get(0).getFname());
			}
		}
		//log.info("@galleryMyFnames222:"+fnames);
		ModelAndView mv = new ModelAndView();
		mv.addObject("galleryMyList", galleryService.galleryMyList(email));
		mv.addObject("imgNames", fnames);
		return mv;
	}
	/*
	@GetMapping("hasLike")
	public @ResponseBody boolean hasLike(String b_seq,HttpSession session){
		String email = (String) session.getAttribute("email");
		boolean hasLike = false;
		if(email != null) {
			hasLike = likeListService.getHasLike(b_seq, email);
		}
		return hasLike;
	}
	*/
	@GetMapping("hasLike")
	public @ResponseBody HashMap<String,Object> hasLike(String b_seq,HttpSession session){
		HashMap<String,Object> map = new HashMap<String,Object>();
		String email = (String) session.getAttribute("email");
		boolean hasLike = false;
		if(email != null) {
			hasLike = likeListService.getHasLike(b_seq, email);
		}
		map.put("hasLike",hasLike);
		map.put("likesone",galleryService.galleryContent(b_seq).getLikes());
		return map;
	}
	
	// 좋아요
	@PostMapping("/likes") 
	public @ResponseBody HashMap<String,Object> plusLike(LikesList likesList,String type) {
		HashMap<String,Object> map = new HashMap<String,Object>();
		log.info("@likesList"+likesList); 
		if(type.equals("plus")) { // + 좋아요
			likeListService.setLike(likesList);
			log.info("@@plus");
		}else if(type.equals("minus")) { // - 좋아요
			likeListService.removeLike(likesList);
			log.info("@@minus");
		}else {
			log.info("[Error] like");
		}
		log.info("@@count:"+galleryService.galleryContent(likesList.getB_seq()).getLikes());
		map.put("likesone",galleryService.galleryContent(likesList.getB_seq()).getLikes());
		map.put("gseq",likesList.getB_seq());
		//map.put("glist",galleryService.galleryList());
		return map;
	}
	
	@GetMapping("/display")
	public ResponseEntity<Resource> display(String imgNames) {
		return fileService.findFiles(imgNames);
	}

	@GetMapping("/galleryWrite")
	public String galleryWrite() {
		return "freeboard/galleryWrite";
	}

	// 갤러리 글작성
	@PostMapping("/galleryWrite")
	public @ResponseBody boolean galleryWrite(HttpSession session, Gallery gallery,	HttpServletRequest request,	ArrayList<MultipartFile> multipartFiles) {
		//log.info("#mpf:"+multipartFiles);
		gallery.setEmail(String.valueOf(session.getAttribute("email")));
		if (multipartFiles != null) {
			for(MultipartFile image: multipartFiles) {
				String ofName = image.getOriginalFilename().trim();
				//log.info("#fileName:"+ofName);
				if (ofName.length() == 0) {
					return false;
				}
			}
			 fileService.setFiles(multipartFiles, gallery.getG_seq(), "G");
		}
		log.info("#galleryfile:"+gallery);
		galleryService.galleryWrite(gallery);
		return true;
	}
	
	// 갤러리 글삭제
	@GetMapping("/galleryDelete")
	public String galleryDelete(String g_seq) {
		galleryService.galleryDelete(g_seq);
		return "redirect:galleryMyList";
	}

	@GetMapping("/galleryUpdate")
	public ModelAndView galleryUpdate(String g_seq) {
		ModelAndView mv = new ModelAndView("freeboard/galleryUpdate");
		mv.addObject("files", fileService.getFiles(g_seq));
		mv.addObject("galleryMyList", galleryService.gUpdateList(g_seq));
		return mv;
	}

	// 갤러리 글 수정
	@PostMapping("/galleryUpdate")
	public @ResponseBody boolean galleryUpdate(Gallery gallery, ArrayList<MultipartFile> multipartFiles, Objects fnames) {
		if (fnames.getFnames() != null) {
			for (String fname : fnames.getFnames()) {
				fileService.removeFiles(fname);
			}
		}
		if(multipartFiles != null) {
			for(MultipartFile image : multipartFiles) {
				String ofName = image.getOriginalFilename().trim();
				if(ofName.length() == 0) return false;
				log.info("#ofName: "+ofName);
			}
			fileService.setFiles(multipartFiles, gallery.getG_seq(), "G");
		}
		log.info("#galleryUpadtefile:"+gallery);
		galleryService.galleryUpdate(gallery);
		return true;
	}
}

