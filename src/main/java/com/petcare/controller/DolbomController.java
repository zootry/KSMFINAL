package com.petcare.controller;

import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.petcare.domain.Chatting;
import com.petcare.domain.Dolbom;
import com.petcare.domain.Dolbomlist;
import com.petcare.domain.Files;
import com.petcare.domain.LikesList;
import com.petcare.domain.ListVo;
import com.petcare.domain.Objects;
import com.petcare.domain.Pagination;
import com.petcare.domain.Pet;
import com.petcare.domain.SearchList;
import com.petcare.domain.ShareMarket;
import com.petcare.domain.Tag;
import com.petcare.domain.Timetable;
import com.petcare.service.AddressService;
import com.petcare.service.ChattingService;
import com.petcare.service.DolbomService;
import com.petcare.service.FileService;
import com.petcare.service.LikesListService;
import com.petcare.service.MemberService;
import com.petcare.service.PetService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/dolbom")
@Controller
public class DolbomController {
	private DolbomService dolbomservice;
	private MemberService memberservice;
	private AddressService addressservice;
	private FileService fService;
	private PetService PService;
	private ChattingService CService;
	private LikesListService likesService;
	
	@GetMapping("")
	public ModelAndView dolbom(HttpSession session) {
		session.removeAttribute("category");
		session.removeAttribute("kind");
		session.removeAttribute("workdate");
		session.removeAttribute("conditions");
		session.removeAttribute("neighbor");
		session.removeAttribute("meeting");
		session.removeAttribute("cut");
		session.removeAttribute("bigcare");
		session.removeAttribute("ampms");
		session.removeAttribute("stime");
		session.removeAttribute("etime");
		String email = (String) session.getAttribute("email");
		String mydong = addressservice.selectMydong(email);
		
		return new ModelAndView("/dolbom/search","mydong",mydong);
	}
	@GetMapping("/list.do")
	public ModelAndView list(HttpSession session) {
		String email = (String)session.getAttribute("email");
		ModelAndView mv = new ModelAndView("dolbom/list","userEmail",email);
		return mv;
	}
	@GetMapping("/form")
	public ModelAndView form(HttpSession session) {
		String email = (String)session.getAttribute("email");
		String mydong = addressservice.selectMydong(email);
		int count = memberservice.countPets(email);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("dolbom/form");
		mv.addObject("count",count);
		mv.addObject("mydong",mydong);	
		return mv;
	}
	@PostMapping("/dlist")
	public @ResponseBody List<Dolbomlist> dlist(HttpSession session){
		String email = (String)session.getAttribute("email");
		List<Dolbomlist> dlist = dolbomservice.selectDList(email);
		return dlist;
	}
	@GetMapping("/content.do")
	public ModelAndView content(HttpSession session,String dol_seq) {
		String email = (String)session.getAttribute("email");
		String nickname=memberservice.getNicknameS(email);
		Dolbom dolbom = dolbomservice.contentS(dol_seq);
		String checkWriter="";
		log.info("11111"+email);
		log.info("22222"+dolbom.getEmail());
		if(dolbom.getEmail().equals(email)) {
			checkWriter="Y";
		}
		List<Dolbom> times = dolbomservice.selectTime(email);
		List<Dolbomlist> dlist = dolbomservice.dolbomSchedule(dol_seq);
		List<Pet> plist = PService.getPetinfoS(dolbom.getEmail());
		log.info("@@@dlist"+dlist);
		log.info("@@@dolbom.getKind()"+dolbom.getKind());
		String[] kind = new String[3];
		if(dolbom.getKind().contains(",")) {
			kind = dolbom.getKind().split(",");
		}else {
			kind[0]=dolbom.getKind();
		}
		List<String> fnames = new ArrayList<String>();
		List<Files> files = fService.getFiles(dolbom.getDol_seq());
		if(files.isEmpty()) {
			fnames.add(null);
		}else {
			fnames.add(files.get(0).getFname());
		}
		LocalDate now = LocalDate.now();
		int year = now.getYear();
		log.info("@@year"+year);
		List<String> pfnames = new ArrayList<String>();
		for(Pet list : plist) {
			List<Files> pfiles = fService.getFiles(list.getPetseq());
			if(pfiles.isEmpty()) {
				pfnames.add(null);
			}else {
				pfnames.add(pfiles.get(0).getFname());
			}
			int age = year-list.getByear();
			list.setAge(age);
		}
		boolean hasLike = false;
		if(email != null) {
			hasLike = likesService.getHasLike(dol_seq, email);
		}
		log.info("@@@checkWriter"+checkWriter);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("dolbom/content");
		mv.addObject("dolbom",dolbom);
		mv.addObject("userNickname",nickname);
		mv.addObject("times",times);
		mv.addObject("dlist",dlist);
		mv.addObject("kind",kind);
		mv.addObject("fnames",fnames);
		mv.addObject("checkWriter",checkWriter);
		mv.addObject("plist",plist);
		mv.addObject("pfnames",pfnames);
		mv.addObject("hasLike",hasLike);
		return mv;
	}
	@GetMapping("checkMe")
	public @ResponseBody boolean checkMe(HttpSession session,String writer) {
		String email = (String)session.getAttribute("email");
		if(email.equals(writer)) {
			return true;
		}else {
			return false;
		}
	}
	@GetMapping("checkDuplicate")
	public @ResponseBody HashMap<String, Object> checkDuplicate(HttpSession session,String dol_seq) {
		log.info("!!dol_seq:"+dol_seq);
		String email = (String)session.getAttribute("email");
		/*int check = CService.checkduplicate(dol_seq, email);
		log.info("!!check:"+check);
		if(check>=1) {
			return true;
		}else {
			return false;
		}*/
		HashMap<String, Object> results = new HashMap<String, Object>();
		Chatting chat = CService.checkduplicate(dol_seq, email);
		log.info("@@chat"+chat);
		String url="";
		if(chat!=null) {
			url="/moveChating?roomName="+chat.getC_subject()+"&"+"roomNumber="+chat.getC_number()+"&nickname="+chat.getC_ownername()+"&gnickname="+chat.getC_guestname();
			results.put("url", url);
		}else {
			results.put("msg", "new");
		}
		return results;
	}
	@GetMapping("search")
	public @ResponseBody HashMap<String, Object> search(ListVo listVo, HttpServletResponse response, HttpSession session,@RequestParam(value="conditions[]") List<String> conditions,@RequestParam(value="ampms[]") List<String> ampms){
		
		HashMap<String, Object> results = new HashMap<String, Object>();
		String email = (String) session.getAttribute("email");
		String mydong = addressservice.selectMydong(email);
		List<String> nearlist = addressservice.selectNeardong(email);
		List<String> region = new ArrayList<String>();
		List<Dolbom> dolbomlist = new ArrayList<Dolbom>();
		Pagination pagination = new Pagination();
		region=nearlist;
		region.add(mydong);

		log.info("@@@region:"+region);
		log.info("@@@listVo:"+listVo);
		//SearchList search = new SearchList();
		
		if(listVo.getCategory()!="") {
			session.setAttribute("category", listVo.getCategory());
		}
		if(listVo.getKind()!="") {
			session.setAttribute("kind", listVo.getKind());
		}
		if(listVo.getWorkdate()!=null) {
			session.setAttribute("workdate", listVo.getWorkdate());
		}
		if(conditions.size()!=0) {
			if(conditions.contains("견주")&&!conditions.contains("집사")) {
				listVo.setNeighbor("견주");			
			}else if(!conditions.contains("견주")&&conditions.contains("집사")) {
				listVo.setNeighbor("집사");
			}else {
				listVo.setNeighbor("");
			}
			if(conditions.contains("사전만남")) {
				listVo.setMeeting("사전만남");
			}else {
				listVo.setMeeting("");
			}
			if(conditions.contains("중성화O")) {
				listVo.setCut("중성화O");
			}else {
				listVo.setCut("");
			}
			if(conditions.contains("대형견케어")) {
				listVo.setBigcare("대형견케어");
			}else {
				listVo.setBigcare("");
			}
			session.setAttribute("conditions", conditions);
			session.setAttribute("neighbor", listVo.getNeighbor());
			session.setAttribute("meeting", listVo.getMeeting());
			session.setAttribute("cut", listVo.getCut());
			session.setAttribute("bigcare", listVo.getBigcare());
		}
		if(ampms.size()!=0) {
			if(ampms.size()==1) {
				if(ampms.get(0).equals("오전")) {
					listVo.setStime(ampms.get(0));
					listVo.setEtime("");
				}else if(ampms.get(0).equals("오후")) {
					listVo.setStime("");
					listVo.setEtime(ampms.get(0));			
				}
			}else if(ampms.size()>1){
				listVo.setStime(ampms.get(0));
				listVo.setEtime(ampms.get(1));
			}
			session.setAttribute("ampms", ampms);
			session.setAttribute("stime", listVo.getStime());
			session.setAttribute("etime", listVo.getEtime());
		}
		/*검색 아닐때*/
		if(session.getAttribute("category")==null && session.getAttribute("kind")==null && session.getAttribute("conditions")==null && session.getAttribute("workdate")==null && session.getAttribute("ampms")==null) {
			if(mydong!=null) {
				listVo.setRegion(region);
				//dolbomlist = dolbomservice.searchDong(region);
				dolbomlist = dolbomservice.getSearchDongByPage(listVo);
				pagination = new Pagination(listVo, dolbomservice.getSearchDongRCounts(region));
				
			}else {
				//dolbomlist = dolbomservice.searchAll();
				dolbomlist = dolbomservice.getSearchAllByPage(listVo);
				pagination = new Pagination(listVo, dolbomservice.getSearchAllRCounts());
			}
		}else {
			//String category = (String)session.getAttribute("category");
			//String kind = (String)session.getAttribute("kind");
			Date workdate = (Date)session.getAttribute("workdate");
			if(session.getAttribute("category")!=null) {
				listVo.setCategory(String.valueOf(session.getAttribute("category")));
			}
			if(session.getAttribute("kind")!=null) {
				listVo.setKind(String.valueOf(session.getAttribute("kind")));
			}
			if(session.getAttribute("conditions")!=null) {
				listVo.setNeighbor(String.valueOf(session.getAttribute("neighbor")));
				listVo.setMeeting(String.valueOf(session.getAttribute("meeting")));
				listVo.setCut(String.valueOf(session.getAttribute("cut")));
				listVo.setBigcare(String.valueOf(session.getAttribute("bigcare")));
			}
			if(session.getAttribute("ampms")!=null) {
				listVo.setStime(String.valueOf(session.getAttribute("stime")));
				listVo.setEtime(String.valueOf(session.getAttribute("etime")));
			}
			
			if(workdate!=null) {
				log.info("야호111");
				int year = workdate.getYear()+1900;
				int month = workdate.getMonth()+1;
				int date = workdate.getDate();	
				LocalDate localday = LocalDate.of(year, month, date);
				DayOfWeek dayOfWeek = localday.getDayOfWeek();
				String day = dayOfWeek.getDisplayName(TextStyle.NARROW, Locale.KOREAN);
				listVo.setWorkdate(workdate);
				listVo.setWorkday(day);
				if(mydong!=null) {
					listVo.setRegion(region);
					dolbomlist = dolbomservice.searchOptionDate(listVo);
					pagination = new Pagination(listVo, dolbomservice.getOptionDateRCounts(listVo));
				}else {
					dolbomlist = dolbomservice.searchAllOptionDate(listVo);
					pagination = new Pagination(listVo, dolbomservice.getAllOptionDateRCounts(listVo));
				}
			}else {
				if(mydong!=null) {
					listVo.setRegion(region);
					dolbomlist = dolbomservice.searchOption(listVo);
					pagination = new Pagination(listVo, dolbomservice.getOptionRCounts(listVo));
				}else {
					dolbomlist = dolbomservice.searchAllOption(listVo);
					pagination = new Pagination(listVo, dolbomservice.getAllOptionRCounts(listVo));
				}		
			}
		}
			
		List<String> fnames = new ArrayList<String>();
		for(Dolbom list : dolbomlist) {
			List<Files> files = fService.getFiles(list.getDol_seq());
			if(files.isEmpty()) {
				fnames.add(null);
			}else {
				fnames.add(files.get(0).getFname());
			}
		}
		results.put("fnames", fnames);
		results.put("dolbomlist", dolbomlist);
		results.put("pagination", pagination);
		return results;
	}
	@GetMapping("searchOption")
	public @ResponseBody HashMap<String, Object> searchOption(HttpSession session, @RequestParam(value="conditions[]") List<String> conditions,SearchList searchlist,@RequestParam(value="ampms[]") List<String> ampms) {		
		//Tag tag = new Tag();
		HashMap<String, Object> results = new HashMap<String, Object>();
		SearchList search = new SearchList();
		//List<String> neighbor = new ArrayList<String>();
		if(conditions.contains("견주")&&!conditions.contains("집사")) {
			search.setNeighbor("견주");			
		}else if(!conditions.contains("견주")&&conditions.contains("집사")) {
			search.setNeighbor("집사");
		}else {
			search.setNeighbor("");
		}
		if(conditions.contains("사전만남")) {
			search.setMeeting("사전만남");
		}
		if(conditions.contains("중성화O")) {
			search.setCut("중성화O");
		}else {
			search.setCut("");
		}
		if(conditions.contains("대형견케어")) {
			search.setBigcare("대형견케어");
		}else {
			search.setBigcare("");
		}
		
		if(ampms.size()==1) {
			if(ampms.get(0).equals("오전")) {
				search.setStime(ampms.get(0));
				//search.setEtime("");
			}else if(ampms.get(0).equals("오후")) {
				//search.setStime("");
				search.setEtime(ampms.get(0));			
			}
		}else if(ampms.size()>1){
			search.setStime(ampms.get(0));
			search.setEtime(ampms.get(1));
		}	
		log.info("@@@search"+search);
		
		//String category,String kind,Date workdate
		String category = searchlist.getCategory();
		String kind = searchlist.getKind();
		Date workdate = searchlist.getWorkdate();
		
		String email = (String) session.getAttribute("email");
		String mydong = addressservice.selectMydong(email);
		List<String> nearlist = addressservice.selectNeardong(email);
		List<String> region = new ArrayList<String>();
		region=nearlist;
		region.add(mydong);

		search.setKind(kind);
		search.setCategory(category);
		//search.setTag(tag);
		search.setRegion(region);
		List<Dolbom> dolbomlist = new ArrayList<Dolbom>();
		
		List<String> fnames = new ArrayList<String>();
		for(Dolbom list : dolbomlist) {
			List<Files> files = fService.getFiles(list.getDol_seq());
			if(files.isEmpty()) {
				fnames.add(null);
			}else {
				fnames.add(files.get(0).getFname());
			}
		}
		results.put("dolbomlist", dolbomlist);
		results.put("fnames", fnames);

		return results;
	}
	@GetMapping("/display")
	public ResponseEntity<Resource> display(String imgName) {
		return fService.findFiles(imgName);
	}
	@GetMapping("/form_helper.do")
	public ModelAndView write_helper(HttpSession session) {
		String email = (String) session.getAttribute("email");
		String region = addressservice.selectMydong(email);
		ModelAndView mv = new ModelAndView("dolbom/form_helper","region",region);
		return mv;
	}
	@GetMapping("/form_receiver.do")
	public ModelAndView write_receiver(HttpSession session) {
		String email = (String) session.getAttribute("email");
		String region = addressservice.selectMydong(email);
		ModelAndView mv = new ModelAndView("dolbom/form_receiver","region",region);
		return mv;
	}
	@GetMapping("/he_tagitems")
	public @ResponseBody Tag write_receiver(@RequestParam(value="checkboxKinds[]") List<String> checkboxKinds,Tag tag) {
		tag.setKind(checkboxKinds);
		return tag;
	}
	@GetMapping("/re_tagitems")
	public @ResponseBody Tag write_helper(Tag tag) {
		return tag;
	}
	@PostMapping("/re_write")
	public @ResponseBody boolean writeReceiver(HttpSession session,Dolbom dolbom, ArrayList<MultipartFile> multipartFiles,Tag tag){
		if(multipartFiles != null) {
			for(MultipartFile image : multipartFiles) {
				String ofName = image.getOriginalFilename().trim();
				if(ofName.length() == 0) return false;
			}
			fService.setFiles(multipartFiles, dolbom.getDol_seq(), "DOL");
		}
		log.info("@@dolbom"+dolbom);
		log.info("@@tag"+tag);
		int year = dolbom.getWorkdate().getYear()+1900;
		int month = dolbom.getWorkdate().getMonth()+1;
		int date = dolbom.getWorkdate().getDate();
		LocalDate localday = LocalDate.of(year, month, date);
		DayOfWeek dayOfWeek = localday.getDayOfWeek();
		String day = dayOfWeek.getDisplayName(TextStyle.NARROW, Locale.KOREAN);		
		String email = (String)session.getAttribute("email");
		String nickname=memberservice.getNicknameS(email);		
		String header = dolbom.getWorkdate()+"("+day+") "+dolbom.getWorkstime()+"~"+dolbom.getWorketime();
		String newTag = "";
		if(tag.getMeeting().equals("X")) {
			newTag = "#"+tag.getKind().get(0)+" #"+tag.getNeighbor()+" #"+tag.getCut();
		}else {
			newTag = "#"+tag.getKind().get(0)+" #"+tag.getNeighbor()+" #"+tag.getMeeting()+" #"+tag.getCut();
		}
		tag.setBigcare(" ");
		
		dolbom.setEmail(email);
		dolbom.setNickname(nickname);
		dolbom.setHeader(header);
		dolbom.setCategory("요청");
		dolbom.setWorkday(day);
		dolbom.setWorkstime(dolbom.getWorkstime());
		dolbom.setWorketime(dolbom.getWorketime());
		dolbom.setTag(newTag);
		dolbom.setState("대기중");
		dolbom.setContent(dolbom.getContent().replace("\r\n", "<br/>"));//개행문자반영
		
		dolbomservice.insertDolbomS(dolbom);
		dolbomservice.insertTags(tag);

		return true;
	}
	
	@PostMapping("he_write")
	public @ResponseBody boolean writeHelper(HttpSession session,Dolbom dolbom,ArrayList<MultipartFile> multipartFiles,Tag tag){
		if(multipartFiles != null) {
			for(MultipartFile image : multipartFiles) {
				String ofName = image.getOriginalFilename().trim();
				if(ofName.length() == 0) return false;
			}
			fService.setFiles(multipartFiles, dolbom.getDol_seq(), "DOL");
		}	
		String day = "";
		if(dolbom.getWorkday().equals("월화수목금")) {
			day = "평일";
		}else if(dolbom.getWorkday().equals("토일")) {
			day = "주말";
		}else {
			day = dolbom.getWorkday();
		}
		String ampm="";
		String stime = dolbom.getWorkstime().substring(0, dolbom.getWorkstime().indexOf(" "));
		String etime = dolbom.getWorketime().substring(0, dolbom.getWorketime().indexOf(" "));
		if(stime.equals(etime)) {
			ampm=stime;
		}else {
			ampm=stime+"/"+etime;
		}
		log.info("@@ampm"+ampm);
		String email = (String)session.getAttribute("email");
		String nickname=memberservice.getNicknameS(email);
		String header = day+" "+ampm+" 시간대 가능";
		
		String newTag = "";
		for(int i=0;i<tag.getKind().size();i++) {
			newTag = newTag+tag.getKind().get(i)+",";
		}
		newTag = newTag.substring(0, newTag.lastIndexOf(","));
		if(tag.getMeeting().equals("X")) {
			newTag = "#"+newTag+" #"+tag.getNeighbor()+" #"+tag.getBigcare();
		}else {
			newTag = "#"+newTag+" #"+tag.getNeighbor()+" #"+tag.getMeeting()+" #"+tag.getBigcare();
		}
		tag.setCut(" ");
		dolbom.setEmail(email);
		dolbom.setNickname(nickname);
		dolbom.setHeader(header);
		dolbom.setCategory("제공");
		dolbom.setTag(newTag);
		dolbom.setState("가능");
		dolbom.setContent(dolbom.getContent().replace("\r\n", "<br/>"));//개행문자반영
		dolbomservice.insertDolbomS(dolbom);
		dolbomservice.insertTags(tag);
		
		return true;
	}
	@GetMapping("/acceptList")
	public @ResponseBody void acceptList(long dl_seq) {
		dolbomservice.setStateContinue(dl_seq);
		String dol_seq=dolbomservice.selectDolSeq(dl_seq);
		dolbomservice.setStateContinueDolbom(dol_seq);
	}
	@GetMapping("/deleteList")
	public @ResponseBody void deleteList(long dl_seq) {
		dolbomservice.deleteList(dl_seq);
	}
	@GetMapping("/finishList")
	public @ResponseBody void finishList(long dl_seq) {
		dolbomservice.setStateFinish(dl_seq);
		String dol_seq=dolbomservice.selectDolSeq(dl_seq);
		dolbomservice.setStateFinishDolbom(dol_seq);
		dolbomservice.updateGive(dl_seq);
		dolbomservice.updateTake(dl_seq);
	}
	@GetMapping("/cancelList")
	public @ResponseBody void canceltList(long dl_seq) {
		dolbomservice.deleteList(dl_seq);
	}
	@GetMapping("goChatting")
	public @ResponseBody HashMap<String,Object> goChatting(String sendernick,String receivernick,String roomName){
		log.info("@#@#@"+sendernick+receivernick+roomName);
		String roomNumber = CService.getCNum(roomName, sendernick, receivernick);
		HashMap<String,Object> result = new HashMap<String,Object>();
		result.put("roomNumber", roomNumber);
		log.info("@#@#@roomNumber"+roomNumber);
		return result;		
	}
	@PostMapping("/requestdolbom")
	public @ResponseBody void insertDolbomlist(HttpSession session,String dol_seq,String rdol_seq,String kind,String header) {
		log.info("@@dol_seq"+dol_seq);
		log.info("@@rdol_seq"+rdol_seq);
		Dolbom dolbom = dolbomservice.contentS(dol_seq);
		log.info("@@dolbom"+dolbom);
		Dolbomlist dlist = new Dolbomlist();
		String category="";
		if(dolbom.getCategory().equals("요청")) {
			category="제공";
			log.info("1111category"+category);
		}else if(dolbom.getCategory().equals("제공")) {
			category="요청";
			log.info("222category"+category);
		}
		String semail = (String)session.getAttribute("email");
		String snickname = memberservice.getNicknameS(semail);
		String remail = dolbom.getEmail();
		String rnickname = memberservice.getNicknameS(remail);
		String workdate = header;
		dlist.setCategory(category);
		dlist.setReceiveremail(remail);
		dlist.setReceivernick(rnickname);
		dlist.setSenderemail(semail);
		dlist.setSendernick(snickname);
		dlist.setState("대기중");
		dlist.setKind(kind);
		dlist.setWorkdate(workdate);
		if(category.equals("요청")) {
			dlist.setDseq(rdol_seq);
			dlist.setDolbomy(remail);
			dlist.setRequester(semail);
		}else if(category.equals("제공")) {
			dlist.setDseq(dol_seq);
			dlist.setDolbomy(semail);
			dlist.setRequester(remail);
		}
		log.info("#dlist"+dlist);
		dolbomservice.insertDolbomListS(dlist);
	}
	
	@GetMapping("delete")
	public String delete(String dol_seq) {
		dolbomservice.deleteDolbom(dol_seq);
		return "redirect:/dolbom";
	}
	@GetMapping("he_update")
	public ModelAndView update_helper(HttpSession session,String dol_seq) {
		String email = (String) session.getAttribute("email");
		String region = addressservice.selectMydong(email);
		Dolbom dolbom = dolbomservice.contentS(dol_seq);
		Tag tag = dolbomservice.selectTag(dol_seq);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("dolbom/update_helper");
		mv.addObject("region", region);
		mv.addObject("dolbom", dolbom);
		mv.addObject("tag", tag);
		mv.addObject("files", fService.getFiles(dol_seq));
		return mv;
	}
	@GetMapping("re_update")
	public ModelAndView update_receiver(HttpSession session,String dol_seq) {
		String email = (String) session.getAttribute("email");
		String region = addressservice.selectMydong(email);
		Dolbom dolbom = dolbomservice.contentS(dol_seq);
		Tag tag = dolbomservice.selectTag(dol_seq);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("dolbom/update_receiver");
		mv.addObject("region", region);
		mv.addObject("dolbom", dolbom);
		mv.addObject("tag", tag);
		mv.addObject("files", fService.getFiles(dol_seq));
		return mv;
	}
	@PostMapping("re_update")
	public @ResponseBody boolean update_receiver(HttpSession session,ArrayList<MultipartFile> multipartFiles,Dolbom dolbom, Tag tag, Objects fnames){
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
			fService.setFiles(multipartFiles, dolbom.getDol_seq(),"DOL");
		}	
		int year = dolbom.getWorkdate().getYear()+1900;
		int month = dolbom.getWorkdate().getMonth()+1;
		int date = dolbom.getWorkdate().getDate();
		LocalDate localday = LocalDate.of(year, month, date);
		DayOfWeek dayOfWeek = localday.getDayOfWeek();
		String day = dayOfWeek.getDisplayName(TextStyle.NARROW, Locale.KOREAN);		
		//String email = (String)session.getAttribute("email");
		//String nickname=memberservice.getNicknameS(email);		
		String header = dolbom.getWorkdate()+"("+day+") "+dolbom.getWorkstime()+"~"+dolbom.getWorketime();
		String newTag = "";
		if(tag.getMeeting().equals("X")) {
			newTag = "#"+tag.getKind().get(0)+" #"+tag.getNeighbor()+" #"+tag.getCut();
		}else {
			newTag = "#"+tag.getKind().get(0)+" #"+tag.getNeighbor()+" #"+tag.getMeeting()+" #"+tag.getCut();
		}
		tag.setBigcare(" ");
		
		//dolbom.setEmail(email);
		//dolbom.setNickname(nickname);
		dolbom.setHeader(header);
		dolbom.setWorkday(day);
		dolbom.setTag(newTag);
		dolbom.setContent(dolbom.getContent().replace("\r\n", "<br/>"));//개행문자반영
		
		dolbomservice.updateDolbom(dolbom);
		dolbomservice.updateTag(tag);
		return true;
	}
	@PostMapping("he_update")
	public @ResponseBody boolean update_helper(HttpSession session,ArrayList<MultipartFile> multipartFiles,Dolbom dolbom, Tag tag, Objects fnames){
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
			fService.setFiles(multipartFiles, dolbom.getDol_seq(),"DOL");
		}	
		String day = "";
		if(dolbom.getWorkday().equals("월화수목금")) {
			day = "평일";
		}else if(dolbom.getWorkday().equals("토일")) {
			day = "주말";
		}else {
			day = dolbom.getWorkday();
		}
		/*int year = dolbom.getWorkdate().getYear()+1900;
		int month = dolbom.getWorkdate().getMonth()+1;
		int date = dolbom.getWorkdate().getDate();
		LocalDate localday = LocalDate.of(year, month, date);
		DayOfWeek dayOfWeek = localday.getDayOfWeek();
		String day = dayOfWeek.getDisplayName(TextStyle.NARROW, Locale.KOREAN);		
		String email = (String)session.getAttribute("email");
		String nickname=memberservice.getNicknameS(email);*/
		String ampm="";
		String stime = dolbom.getWorkstime().substring(0, dolbom.getWorkstime().indexOf(" "));
		String etime = dolbom.getWorketime().substring(0, dolbom.getWorketime().indexOf(" "));
		if(stime.equals(etime)) {
			ampm=stime;
		}else {
			ampm=stime+"/"+etime;
		}
		log.info("@@ampm"+ampm);
		String email = (String)session.getAttribute("email");
		String nickname=memberservice.getNicknameS(email);
		String header = day+" "+ampm+" 시간대 가능";
		String newTag = "";
		for(int i=0;i<tag.getKind().size();i++) {
			newTag = newTag+tag.getKind().get(i)+",";
		}
		newTag = newTag.substring(0, newTag.lastIndexOf(","));
		if(tag.getMeeting().equals("X")) {
			newTag = "#"+newTag+" #"+tag.getNeighbor()+" #"+tag.getBigcare();
		}else {
			newTag = "#"+newTag+" #"+tag.getNeighbor()+" #"+tag.getMeeting()+" #"+tag.getBigcare();
		}
		tag.setCut(" ");
		//dolbom.setEmail(email);
		//dolbom.setNickname(nickname);
		dolbom.setHeader(header);
		//dolbom.setWorkday(day);
		dolbom.setTag(newTag);
		dolbom.setContent(dolbom.getContent().replace("\r\n", "<br/>"));//개행문자반영
		dolbomservice.updateDolbom(dolbom);
		dolbomservice.updateTag(tag);
		return true;
	}
	@PostMapping("/likes") // + 좋아요
	public @ResponseBody long plusLike(LikesList likesList,String type) {
		if(type.equals("plus")) {
			likesService.setLike(likesList);
		}else if(type.equals("minus")) {
			likesService.removeLike(likesList);
		}else {
			log.info("[Error] like");
		}
		return dolbomservice.contentS(likesList.getB_seq()).getLikes();
	}
	/*날짜형식 json으로 받을때*/
	@InitBinder
	protected void initBinder(WebDataBinder binder){
		DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}	   	
}