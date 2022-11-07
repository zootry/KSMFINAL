package com.petcare.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.petcare.domain.Files;
import com.petcare.domain.Info;
import com.petcare.domain.InfoVo;
import com.petcare.service.FileService;
import com.petcare.service.InfoService;


import com.petcare.domain.Path;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/info")
@Controller
public class InfoController implements Cloneable {
	private InfoService infoservice;
	private FileService filestoreservice;
	@GetMapping("/list.do")
	public ModelAndView list(HttpServletRequest request, HttpSession session, String infocatgo, String infokeyword, String infosearchModeStr) {
		String cpStr = request.getParameter("infocp");
		
		int infocp = 1;
		if(cpStr == null) {
			Object cpObj = session.getAttribute("infocp");
			if(cpObj != null) {
				infocp = (Integer)cpObj;
			}
		}else {
			cpStr = cpStr.trim();
			infocp = Integer.parseInt(cpStr);
		}
		session.setAttribute("infocp", infocp);
		
		int ps = 10;
		session.setAttribute("ps", ps);
		
		if(infocatgo == null) {
			Object catgoObj = session.getAttribute("infocatgo");
			if(catgoObj !=null) {
				infocatgo = (String) catgoObj;
			}
		}else {
			infocatgo = infocatgo.trim();
		}
		session.setAttribute("infocatgo", infocatgo);
		
		if(infokeyword == null) {
			Object keywordObj = session.getAttribute("infokeyword");
			if(keywordObj != null) {
				infokeyword = (String) keywordObj;
			}
		}else {
			infokeyword = infokeyword.trim();
		}
		session.setAttribute("infokeyword", infokeyword);
		
		if(infosearchModeStr == null) {
			Object searchModeStrObj = session.getAttribute("infosearchModeStr");
			if(searchModeStrObj != null) {
				infosearchModeStr = (String) searchModeStrObj;
			}else {
				infosearchModeStr = "F";
			}
		}else {
			infosearchModeStr = infosearchModeStr.trim();
		}
		session.setAttribute("infosearchModeStr", infosearchModeStr);
		
		boolean searchMode = false;
		if(infosearchModeStr.equalsIgnoreCase("T")) {
			searchMode = true;
		}
		
		InfoVo infoVo = null;
		if(!searchMode) {
			infoVo = infoservice.getInfoVo(infocp, ps);
		}else {
			infoVo = infoservice.getInfoVo(infocp, ps, infocatgo, infokeyword);
		}
		infoVo.setRange(infocp);

		ModelAndView mv = new ModelAndView("info/list","listVo",infoVo);
		List<Info> listpinS = infoservice.listpinS();
		mv.addObject("listpinS",listpinS);
		if(infoVo.getList().size() == 0 && listpinS.size()==0) {
			if(infocp>1) {
				return new ModelAndView("redirect:list.do?cp="+(infocp-1));
			}else {
				return new ModelAndView("info/list", "listVo", null);
			}
		}else {
			return mv;
		}
		
	}
	@GetMapping("/infowrite.do")
	public String infowrite() {
		return "info/infowrite";
	}
	@GetMapping("/infodelete.do")
	public String delete(String n_seq) {
		infoservice.deleteS(n_seq);
		List<Files> filecontent = filestoreservice.filecontentS(n_seq);
		for(int i=0;i<filecontent.size();++i) {
			String fname = filecontent.get(i).getFname();
			File file = new File(Path.FILE_STORE, fname);
			if(file.exists()) file.delete();
		}
		filestoreservice.deleteS(n_seq);
		return "redirect:list.do";
	}
	@GetMapping("/infocontent.do")
	public ModelAndView content(String n_seq) {
		Info list = infoservice.contentS(n_seq);
		List<Files> filelist = filestoreservice.filecontentS(n_seq);
		File file = new File("");
		ModelAndView mv = new ModelAndView();
		mv.addObject("infolist",list);
		mv.setViewName("info/infocontent");
		for(int i=0;i<filelist.size();i++) {
			String fname = filelist.get(i).getFname();
			file = new File(Path.FILE_STORE, fname);
			if(file.exists()) {
				mv.addObject("filelist",filelist);
			}else {
				log.info("파일 누락");
				mv.addObject("lostfiles","현재 다운로드 할 수 없습니다");
			}
		}
		
		return mv;
	}
	
	@GetMapping("/infoupdate.do")
	public ModelAndView updatepage(String n_seq) {
		Info list = infoservice.contentS(n_seq);
		List<Files> filelist = filestoreservice.filecontentS(n_seq);
		ModelAndView mv = new ModelAndView();
		mv.addObject("infolist",list);
		File file = new File("");
		for(int i=0;i<filelist.size();i++) {
			String fname = filelist.get(i).getFname();
			file = new File(Path.FILE_STORE, fname);
			if(file.exists()) {
				mv.addObject("filelist",filelist);
			}else {
				log.info("파일 누락");
				mv.addObject("lostfiles","현재 다운로드 할 수 없습니다");
			}
		}
		mv.setViewName("info/infoupdate");
		return mv;
	}
	
	@PostMapping("/infowrite.do")
	public @ResponseBody boolean write(Info info, MultipartHttpServletRequest mhsr, Files filestore) {
		filestoreservice.setMultipartRequest(mhsr);
		Map<String, List<Object>> map = filestoreservice.getUpdateFileName();
		Object fnames = map.values().toArray()[0];
		Object ofnames = map.values().toArray()[1];
		Object fsizes = map.values().toArray()[2];
		List<Object> fnamelist = (List<Object>) fnames;
		List<Object> ofnamelist = (List<Object>) ofnames;
		List<Object> fsizelist = (List<Object>) fsizes;
		for(int i=0;i<ofnamelist.size();++i) {
			String fname = (String) fnamelist.get(i);
			String ofname = (String) ofnamelist.get(i);
			long fsize = (long) fsizelist.get(i);
			filestore.setFname(fname);
			filestore.setOfname(ofname);
			filestoreservice.insertS(filestore);	
		}
		infoservice.insertS(info);
		return true;
	}
	
	@GetMapping("/filedelete.do")
	public void filedelete(@RequestParam(value="deleteList[]") List<String> deleteList, String n_seq) {
		for(int i=0; i<deleteList.size();++i) {
			String ofname = deleteList.get(i).toString();
			List<Files> selectlist = filestoreservice.fileupdatedeleteselectS(n_seq,ofname);
			String fname = selectlist.get(0).getFname();
			File file = new File(Path.FILE_STORE, fname);
			if(file.exists()) file.delete();
		
			filestoreservice.fileupdatedeleteS(n_seq, ofname);
		}
		
		
	}
	
	@PostMapping("/fileupdate.do")
	public String fileupdateinsertS( MultipartHttpServletRequest mhsr, Files filestore, String n_seq, Info info) {
		filestoreservice.setMultipartRequest(mhsr);
		Map<String, List<Object>> map = filestoreservice.getUpdateFileName();
		
		Object fnames = map.values().toArray()[0];
		Object ofnames = map.values().toArray()[1];
		Object fsizes = map.values().toArray()[2];
		
		List<Files> filelist = filestoreservice.filecontentS(n_seq);

		List<Object> fnamelist = (List<Object>) fnames;
		List<Object> ofnamelist = (List<Object>) ofnames;
		List<Object> fsizelist = (List<Object>) fsizes;
		
		for(int i=0;i<ofnamelist.size();++i) {
			String fname = (String) fnamelist.get(i);
			String ofname = (String) ofnamelist.get(i);
			long fsize = (long) fsizelist.get(i);
			
			List<String> ofilenamelist = new ArrayList<>();
			String ofnametest ="";
			
			for(int j=0;j<filelist.size();++j) {
				ofnametest = filelist.get(j).getOfname();
				ofilenamelist.add(ofnametest);
			}
			
			if(!ofilenamelist.contains(ofname)) {
				filestore.setFname(fname);
				filestore.setOfname(ofname);
				filestore.setB_seq(n_seq);
				filestoreservice.insertS(filestore);
			}
		}
		infoservice.updateS(info);
		String url="redirect:infocontent.do?n_seq=";
		url = url + n_seq;
		return url;
		
		
		
	}
	@GetMapping("/display")
	public ResponseEntity<Resource> display(String imgName) {
		return filestoreservice.findFiles(imgName);
	}
	@GetMapping("/checkdelete.do")
	public String checkdelete(@RequestParam(value="del_list[]") List<String> del_list) {
		for(int i=0;i<del_list.size();i++) {
			String n_seq = del_list.get(i);
			infoservice.deleteS(n_seq);
			List<Files> filecontent = filestoreservice.filecontentS(n_seq);
			for(int j=0;j<filecontent.size();++j) {
				String fname = filecontent.get(j).getFname();
				File file = new File(Path.FILE_STORE, fname);
				if(file.exists()) file.delete();
			}
			filestoreservice.deleteS(n_seq);
		}
		return "redirect:/info/list.do";
	}
	@GetMapping("/download.do")
	public ModelAndView download(String fname, String ofname) {
		File file = new File(Path.FILE_STORE, fname);
		if(file.exists()) {
			return new ModelAndView("fileDownloadHandler", "downloadFile", file);
		}else {
			return new ModelAndView("redirect:content.do");
		}
	}
	
	
}