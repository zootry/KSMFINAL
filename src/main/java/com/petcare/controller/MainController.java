package com.petcare.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.petcare.domain.Chatting;
import com.petcare.domain.Path;
import com.petcare.service.ChattingService;
import com.petcare.service.MemberService;



import com.petcare.handler.Room;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MainController {
	List<Room> roomList = new ArrayList<Room>();
	List<Chatting> chattinglist = new ArrayList<Chatting>();
	List<HashMap<String, String>> recordslist = new ArrayList<HashMap<String, String>>();
	static int roomNumber = 0;
	@Autowired
	private MemberService memberservice;
	@Autowired
	private ChattingService chattingservice;
	
	@RequestMapping("/chat")
	public ModelAndView chat() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("chat/chat");
		return mv;
	}
	
	@RequestMapping("/room")
	public ModelAndView room() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("chat/room");
		return mv;
	}
	
	@RequestMapping("/createRoom")
	public @ResponseBody List<Chatting> createRoom(@RequestParam HashMap<Object, Object> params){
		String roomName = (String) params.get("roomName");
		String email = (String) params.get("email");
		String gemail = (String) params.get("gemail");
		String category = (String) params.get("category");
		String c_b_seq = (String) params.get("c_b_seq");
		String c_b_seq_offer = (String) params.get("c_b_seq_offer");
		if(c_b_seq.contains("SM")) {
			c_b_seq_offer = c_b_seq;
		}
		String nickname = memberservice.getNicknameS(email);
		String gnickname = memberservice.getNicknameS(gemail);
		
		if(roomName != null && !roomName.trim().equals("")) {
			Chatting chatting = new Chatting();
			UUID roomUUID = UUID.randomUUID();
			String rnuuid = roomUUID.toString();
			chatting.setC_subject(roomName);
			chatting.setC_guest(gemail);
			chatting.setC_number(rnuuid);
			chatting.setC_owner(email);
			chatting.setC_category(category);
			chatting.setC_b_seq(c_b_seq);
			chatting.setC_b_seq_offer(c_b_seq_offer);
			chatting.setC_ownername(nickname);
			chatting.setC_guestname(gnickname);
			chattingservice.insertS(chatting);
			chattinglist = chattingservice.listS(email, gemail);
		}
		return chattinglist;
	}
	
	@RequestMapping("/deleteRoom")
	public @ResponseBody void deleteRoom(@RequestParam HashMap<Object, Object> params) {
		String roomNumber = (String) params.get("roomNumber");
		chattingservice.deleteS(roomNumber);
		File file = new File(Path.FILE_STORE, "roomnumber"+roomNumber+".txt");
		if(file.exists()) {
			file.delete();
		}else {
			log.info("삭제할 파일이 없어요");
		}
	}
	
	@RequestMapping("/getRoom")
	public @ResponseBody List<Chatting> getRoom(@RequestParam HashMap<Object, Object> params){
		String email = (String) params.get("email");
		chattinglist = chattingservice.listS(email, email);
		String uN = memberservice.getNicknameS(email);
		return chattinglist;
	}
	
	@RequestMapping("/moveChating")
	public ModelAndView chating(@RequestParam HashMap<Object, Object> params, HttpSession session) {
		ModelAndView mv = new ModelAndView();	
		String roomNumber = (String) params.get("roomNumber");
		String email = (String) session.getAttribute("email");
		String uN = memberservice.getNicknameS(email);
		String nickname = (String) params.get("nickname");
		String gnickname = (String) params.get("gnickname");
		String gemail = memberservice.getemailS(gnickname);
		chattinglist = chattingservice.listS(email, email);
		List<Chatting> new_list = chattinglist.stream().filter(o->o.getC_number().equals(roomNumber)).collect(Collectors.toList());
		if(new_list != null && new_list.size() > 0) {
			mv.addObject("nickname", nickname);
			mv.addObject("gnickname", gnickname);
			mv.addObject("gemail", gemail);
			mv.addObject("roomNumber", params.get("roomNumber"));
			mv.addObject("uN", uN);
			readFile(roomNumber);
			mv.addObject("recordslist", recordslist);
			mv.setViewName("chat/chat");
		}else {
			mv.addObject("diffRoom","diffRoom");
			mv.setViewName("chat/room");
		}
		return mv;
	}
	
	@RequestMapping("/getNickName")
	public @ResponseBody HashMap<String, String> getNickName(String email) {
		String userName = memberservice.getNicknameS(email);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userName", userName);
		return map;
	}
	@PostMapping("/searchroom")
	public @ResponseBody List<Chatting> search(String c_owner, String c_guest, String c_subject){
		List<Chatting> chattinglist = new ArrayList<Chatting>();
		chattinglist = chattingservice.listsearchS(c_owner, c_guest, c_subject);
		return chattinglist;
	}
	
	public void readFile(String roomNumber) {
		File file = new File("C:/Users/Kosmo/Desktop/file/roomnumber"+roomNumber+".txt");
		String records ="";
		recordslist = new ArrayList<HashMap<String, String>>();
		String userName = "";
		String msg = "";
		if (!file.exists()) {
			System.out.println("파일이 없어요");
		}
		HashMap<String, String> map = new HashMap<String,String>();
		try {
			BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file), "utf-8"));
			while((records = br.readLine()) != null) {
				
				if(records.contains("userName:")) {
					int idx = records.indexOf(":");
					userName = records.substring(idx+1);
					map.put("userName",userName);
				} 
				if(records.contains("msg:")) {
					int idx = records.indexOf(":");
					msg = records.substring(idx+1);
					map.put("msg",msg);
					recordslist.add(map);
					map = new HashMap<String,String>();
				}
			}
		}catch(Throwable e) {
			log.info("저런 파일이 없어요");
		}
		
	}
}
