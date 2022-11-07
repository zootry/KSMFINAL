package com.petcare.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.petcare.domain.Address;
import com.petcare.domain.MyDong;
import com.petcare.domain.NearDong;
import com.petcare.service.AddressService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor

@Controller
public class AddressController {
	public AddressService addressservice;
	
	@RequestMapping(value="/autoData",method=RequestMethod.POST)
	public @ResponseBody List<Address> getAddressList(String addr){
		String[] exAddr = {"서울","경기","인천"};
		boolean check = false;
		for(String exaddr:exAddr) {
			if(exaddr.contains(addr.substring(0, 2))) {
				check=true;
			}
		}
		List<Address> list = new ArrayList<Address>();
		if(check==true) {
			list = null;
		}else {
			list = addressservice.list(addr);
		}
		return list;
	}
	@RequestMapping(value="/addressdo",method=RequestMethod.GET)
	public @ResponseBody JSONObject loadLocation(Double x,Double y,String addr,HttpSession session) throws ParseException{
		String email = (String)session.getAttribute("email");		
	    Double lat = y;
	    Double lon = x;
	    String apiUrl = "https://dapi.kakao.com/v2/local/geo/coord2regioncode.json?x=" + lon + "&y=" + lat;	    
	    if(addr=="") {
		    try {
		    	addr = getRegionAddress(getJSONData(apiUrl));
		    }catch (Exception e) {
		        e.printStackTrace();
		    }
	    }
	    addr = addr.substring(addr.indexOf(" ")+1);
	    Double range=2.0;
	    MyDong mydong = new MyDong();
	    mydong.setUseremail(email);
	    mydong.setDongname(addr);
	    mydong.setX(lon);
	    mydong.setY(lat);
	    mydong.setRange(range);
	    addressservice.settingDong(mydong);
	    //근처동네설정
	    List<String> nearlist = addressservice.nearlist(y, x,range);
	    log.info("@@nearlist"+nearlist);
	    for(int i=0;i<nearlist.size();i++) {
	    	NearDong neardong = new NearDong();
	    	String neardname = nearlist.get(i);
	    	neardname = neardname.substring(neardname.indexOf(" ")+1);
		    neardong.setUseremail(email);
		    neardong.setNeardname(neardname);
	    	addressservice.settingNearDong(neardong);
	    }
		String mydongname = addressservice.selectMydong(email);
		nearlist = addressservice.selectNeardong(email);
		String jsonStr = "{\"mydong\":\""+mydongname+"\",\"nearlist\":\""+nearlist+"\",\"lat\":\""+lat+"\",\"lon\":\""+lon+"\"}";
		JSONParser parser = new JSONParser();
		JSONObject jsonObject = (JSONObject) parser.parse(jsonStr);//throws ParseException
	    return jsonObject;
	}
	public String getJSONData(String apiUrl) throws Exception{
		URL url = new URL(apiUrl);
		URLConnection conn = url.openConnection();
		String REST_KEY = "208aff43d6dd9838178996b10b9b52e1";
		conn.setRequestProperty("Authorization", "KakaoAK " + REST_KEY);
		StringBuffer response = new StringBuffer();
		BufferedReader br = null;
		br = new BufferedReader(new InputStreamReader(conn.getInputStream(),"UTF-8"));
		String line="";
		while((line=br.readLine())!=null) {
			response.append(line);
		}
		return response.toString();
	}
	public String getRegionAddress(String jsonString) {
		JSONObject jObj = (JSONObject) JSONValue.parse(jsonString);
        JSONObject meta = (JSONObject) jObj.get("meta");
        long size = (long) meta.get("total_count");
        String addressName="";
        String addressName2="";
        if(size>0){
        	JSONArray jArray = (JSONArray) jObj.get("documents");
        	for(int i=0;i<jArray.size();i++) {
        		JSONObject subJobj = (JSONObject) jArray.get(i);
        		if(subJobj.get("region_type").equals("B")) {//행정동:H, 법정동:B
        			addressName = (String)subJobj.get("address_name");
        		}else {
        			addressName2 = (String)subJobj.get("address_name");
        		}
        	}
        }
        return addressName;	
	}	    
	@GetMapping("/address/setting")
	public ModelAndView checkMyDong(HttpSession session) {
		String email = (String)session.getAttribute("email");
		String mydongname = addressservice.selectMydong(email);
		List<String> nearlist = addressservice.selectNeardong(email);		
		MyDong mydong = addressservice.findMydong(email);
		int totNeardong = addressservice.countNeardong(email);
		ModelAndView mv = new ModelAndView();
		if(mydong != null) {
			Double range = mydong.getRange();
			mv.addObject("range", range);
		}else {
			mv.addObject("range", 2.0);
		}
		mv.setViewName("address");
		mv.addObject("mydong", mydong);
		mv.addObject("totNeardong",totNeardong);
		mv.addObject("nearlist", nearlist);
		if(mydongname==null) {
			List<Address> latLng = new ArrayList();
			Address add = new Address();
			add.setY(37.4769094);
			add.setX(126.8917326);
			latLng.add(add);
			mv.addObject("latLng", latLng);
		}else {
			mv.addObject("latLng", addressservice.list(mydongname));
		}
		return mv;	
	}
	@RequestMapping(value="/addressCancel",method=RequestMethod.GET)
	public @ResponseBody void cancelDong(HttpSession session) {
		String email = (String)session.getAttribute("email");
		addressservice.cancelDong(email);
	}
	@RequestMapping(value="/changeRange",method=RequestMethod.GET)
	public @ResponseBody HashMap<String,Object> changeRange(HttpSession session,Double range){	
		String email = (String)session.getAttribute("email");
		MyDong md = new MyDong();
		md.setUseremail(email);
		md.setRange(range);
		addressservice.updateRange(md);
		MyDong mydong = addressservice.findMydong(email);
		addressservice.cancelNearDong(mydong.getDongno());
		List<String> nearlist = addressservice.nearlist(mydong.getY(), mydong.getX(), range);
		for(int i=0;i<nearlist.size();i++) {
	    	NearDong neardong = new NearDong();
	    	String neardname = nearlist.get(i);
	    	neardname = neardname.substring(neardname.indexOf(" ")+1);
		    neardong.setUseremail(email);
		    neardong.setNeardname(neardname);
		    neardong.setDongno(mydong.getDongno());
	    	addressservice.setting2ndNearDong(neardong);
	    }	
		nearlist=addressservice.selectNeardong(email);
		HashMap<String,Object> result = new HashMap<String,Object>();
		result.put("nearlist", nearlist);
		result.put("lat", mydong.getY());
		result.put("lon", mydong.getX());
		return result;
	}
	
}