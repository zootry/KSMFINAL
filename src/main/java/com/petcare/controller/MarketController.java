package com.petcare.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.petcare.domain.Comnt;
import com.petcare.domain.Files;
import com.petcare.domain.LikesList;
import com.petcare.domain.ListVo;
import com.petcare.domain.MyDong;
import com.petcare.domain.Objects;
import com.petcare.domain.Pagination;
import com.petcare.domain.PrevAndNext;
import com.petcare.domain.ShareMarket;
import com.petcare.service.AddressService;
import com.petcare.service.ComntService;
import com.petcare.service.FileService;
import com.petcare.service.LikesListService;
import com.petcare.service.MemberService;
import com.petcare.service.ShareMarketService;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.extern.log4j.Log4j;

@AllArgsConstructor
@Data
@RequestMapping("/market")
@RestController
public class MarketController {
	private ShareMarketService smService;
	private FileService fService;
	private ComntService coService;
	private LikesListService likesService;
	private AddressService addrService;
	private MemberService mService;
	
	@GetMapping("")
	public ModelAndView market(HttpSession session, HttpServletResponse response) {
		response.setHeader("Cache-Control", "no-store");

		return new ModelAndView("/market/list", "myDong", addrService.selectMydong(String.valueOf(session.getAttribute("email"))));
	}
	 
	@GetMapping("/list")
	public HashMap<String, Object> list(ListVo listVo, HttpServletResponse response, HttpSession session){
		response.setHeader("Cache-Control", "no-store");
		
		HashMap<String, Object> results = new HashMap<String, Object>();
		List<ShareMarket> lists = new ArrayList<ShareMarket>();
		List<String> fnames = new ArrayList<String>();
		Pagination pagination = new Pagination();
		
		listVo.setRegion(addrService.selectNeardong(String.valueOf(session.getAttribute("email"))));
		session.setAttribute("pageNum", listVo.getPageNum());
		
		if(listVo.getKey()!=null && listVo.getWord()!=null) {
			session.setAttribute("key", listVo.getKey());
			session.setAttribute("word", listVo.getWord());
		}
		
		if(session.getAttribute("key")==null && session.getAttribute("word")==null) {

			lists = smService.getShareMarketLists(listVo);
			pagination = new Pagination(listVo, smService.getTotalRowCounts(listVo.getRegion()));
			
		}else if(session.getAttribute("key")!=null && session.getAttribute("word")!=null){
			listVo.setKey(String.valueOf(session.getAttribute("key")));
			listVo.setWord(String.valueOf(session.getAttribute("word")));
			lists = smService.getShareMarketSearchLists(listVo);
			results.put("word", String.valueOf(session.getAttribute("word")));
			pagination = new Pagination(listVo, smService.getTotalSearchRowCounts(listVo));
		}
		
		for(ShareMarket list : lists) {
			List<Files> files = fService.getFiles(list.getSm_seq());
			if(files.isEmpty()) {
				fnames.add(null);
			}else {
				fnames.add(files.get(0).getFname());
			}
		}
		
		results.put("lists", lists);
		results.put("pagination", pagination);
		results.put("fnames", fnames);
		
		return results;
	}
	
	@DeleteMapping("/removeSession")
	public void removeSession(HttpSession session, @RequestParam("sessionAttrs[]") List<String> sessionAttrs) {
		for(String sessionAttr : sessionAttrs) {
			session.removeAttribute(sessionAttr);
		}
	}
	
	@GetMapping("/content")
	public ModelAndView content(HttpSession session, HttpServletRequest request, HttpServletResponse response, String sm_seq) {
		response.setHeader("Cache-Control", "no-store");

		List<HashMap<String, Object>> recentPosts = new ArrayList<HashMap<String, Object>>();
		
		Cookie viewProof = null;
		Cookie[] allCookies = request.getCookies();
		
		List<Cookie> realAllCookies = Arrays.asList(allCookies);
		Collections.reverse(realAllCookies);
		
		if(realAllCookies != null) {
			for(Cookie cookie : realAllCookies) {
				if(cookie.getName().equals(sm_seq)) viewProof = cookie;
				
				if(!cookie.getName().contains(sm_seq) && cookie.getName().contains("SM")) {
					ShareMarket recentPost = smService.getShareMarketContents(cookie.getName());
					String recentFileName = null;

					if(fService.getFiles(cookie.getName()).size() != 0) {
						recentFileName = fService.getFiles(cookie.getName()).get(0).getFname();
					}else {
						Cookie removedCookie = new Cookie(cookie.getName(), null);
						removedCookie.setMaxAge(0);
						response.addCookie(removedCookie);
					}
					if(recentPost != null) {
						if(recentPosts.size() == 3) continue;
						HashMap<String, Object> rp = new HashMap<String, Object>();
						rp.put("recentPost", recentPost);
						rp.put("recentFileName", recentFileName);
						recentPosts.add(rp);
					}
				}
			}
		}
		
		if(viewProof == null) {
			response.addCookie(new Cookie(sm_seq, sm_seq));
			smService.renewShareMarketViews(sm_seq);
		}
		
		String email = String.valueOf(session.getAttribute("email"));
		boolean hasLike = false;
		if(email != null) {
			String b_seq = sm_seq;
			hasLike = likesService.getHasLike(b_seq, email);
		}
		
		ModelAndView mv = new ModelAndView();
		
		ShareMarket smContents = smService.getShareMarketContents(sm_seq);
		ListVo pnInfo = new ListVo(0, 0);
		pnInfo.setB_seq(sm_seq);
		pnInfo.setRegion(addrService.selectNeardong(email));
		PrevAndNext pn = smService.getPrevAndNext(pnInfo);

		HashMap<String, Object> prevAndNext = new HashMap<String, Object>();
		
		prevAndNext.put("shareMarket", smService.getShareMarketContents(pn.getPrevSeq()));
		prevAndNext.put("fname", pn.getPrevFname());
		
		mv.addObject("prevContent", prevAndNext); 
		prevAndNext = new HashMap<String, Object>();
		
		prevAndNext.put("shareMarket", smService.getShareMarketContents(pn.getNextSeq()));
		prevAndNext.put("fname", pn.getNextFname()); 
		
		mv.addObject("latLng", addrService.list(smContents.getLocation()));
		mv.addObject("writerProfile", fService.getFiles(mService.userbyemailS(smContents.getEmail()).getM_seq())); 
		mv.addObject("nextContent", prevAndNext);
		mv.addObject("shareMarketContents", smContents);
		mv.addObject("imgNames", fService.getFiles(sm_seq));
		mv.addObject("lastPage", new Pagination(new ListVo(0, 5), coService.getTotalRowCounts(sm_seq)).getTotalPageCounts());
		mv.addObject("hasLike", hasLike);
		mv.addObject("recentPosts", recentPosts);
		return mv;
	}
	
	@GetMapping("/comment")
	public HashMap<String,Object> comment(HttpSession session, ListVo listVo){
		session.setAttribute("currPage", listVo.getPageNum());
		
		List<HashMap<String, Object>> lists = new ArrayList<HashMap<String,Object>>();
		for(Comnt comnt : coService.getComntLists(listVo)) {
			HashMap<String,Object> comntInfo = new HashMap<String, Object>();
			List<Files> profile = fService.getFiles(mService.userbyemailS(comnt.getEmail()).getM_seq());
			if(profile.size() == 0) {
				comntInfo.put("comnt", comnt);
				comntInfo.put("fname", null);
			}else {
				comntInfo.put("comnt", comnt);
				comntInfo.put("fname", profile.get(0).getFname());
			}
			lists.add(comntInfo);
		}
		
		HashMap<String, Object> results = new HashMap<String, Object>();
		results.put("lists", lists);
		results.put("pagination", new Pagination(listVo, coService.getTotalRowCounts(listVo.getB_seq())));
		return results;
	}
	
	@PostMapping(value = {"/comment", "/recomment"})
	public long coWrite(HttpServletRequest request, HttpSession session, Comnt comment) {
		comment.setEmail(String.valueOf(session.getAttribute("email")));
		long currPage = 0;
		if(request.getServletPath().equals("/market/comment.json")) {
			coService.setComnt(comment);
			currPage = new Pagination(new ListVo(0, 5), coService.getTotalRowCounts(comment.getB_seq())).getTotalPageCounts();
		}else if(request.getServletPath().equals("/market/recomment.json")){
			coService.setReply(comment); 
			currPage = Long.parseLong(String.valueOf(session.getAttribute("currPage")));
		}
		return currPage;
	}
	
	@PutMapping("/comment")
	public long coUpdate(HttpSession session, Comnt comment) {
		coService.renewComnt(comment); 
		return Long.parseLong(String.valueOf(session.getAttribute("currPage")));
	}
	
	@DeleteMapping("/comment")
	public long coDelete(HttpSession session, Comnt comment) {
		coService.removeComnt(comment);
		coService.renewChildComnt(comment); 
		return Long.parseLong(String.valueOf(session.getAttribute("currPage")));
	}
	
	@GetMapping("/display")
	public ResponseEntity<Resource> display(String imgName) {
		return fService.findFiles(imgName);
	}
	
	@GetMapping("/write")
	public ModelAndView write() {
		return new ModelAndView("/market/write");
	}
	
	@PostMapping("/write")
	public boolean write(HttpSession session, ShareMarket shareMarket, ArrayList<MultipartFile> multipartFiles) {
		MyDong myDong = addrService.findMydong(String.valueOf(session.getAttribute("email")));
		shareMarket.setEmail(myDong.getUseremail());
		shareMarket.setLocation(myDong.getDongname());
		shareMarket.setContent(shareMarket.getContent().replace("\r\n", "<br/>"));
		
		if(multipartFiles != null) {
			for(MultipartFile image : multipartFiles) {
				String ofName = image.getOriginalFilename().trim();
				if(ofName.length() == 0) return false;
			}
			fService.setFiles(multipartFiles, shareMarket.getSm_seq(), "SM");
		}
		smService.setShareMarketContents(shareMarket);
		return true;
	}
	
	@GetMapping("/update")
	public ModelAndView update(String sm_seq) {
		ModelAndView mv = new ModelAndView("/market/update");
		mv.addObject("files", fService.getFiles(sm_seq));
		mv.addObject("contents", smService.getShareMarketContents(sm_seq));
		return mv;
	}
	
	@PostMapping("/update")
	public boolean update(ShareMarket shareMarket, ArrayList<MultipartFile> multipartFiles, Objects fnames) {
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
			fService.setFiles(multipartFiles, shareMarket.getSm_seq(),"SM");
		}
		if(shareMarket != null) {
			shareMarket.setContent(shareMarket.getContent().replace("\r\n", "<br/>")); //개행문자 반영
			smService.renewShareMarketContents(shareMarket);
		}
		return true;
	}
	
	@DeleteMapping("/delete") // 게시글 삭제
	public void delete(String sm_seq) {
		smService.removeShareMarketContents(sm_seq);
	}
	
	@PostMapping("/likes") // + 좋아요
	public long plusLike(LikesList likesList) {
		likesService.setLike(likesList);
		return smService.getShareMarketContents(likesList.getB_seq()).getLikes();
	}
	
	@DeleteMapping("/likes") // - 좋아요
	public long minusLike(LikesList likesList) {
		likesService.removeLike(likesList);
		return smService.getShareMarketContents(likesList.getB_seq()).getLikes();
	}
	
}