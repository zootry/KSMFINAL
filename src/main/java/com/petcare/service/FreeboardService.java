package com.petcare.service;

import java.util.List;

import com.petcare.domain.Freeboard;
import com.petcare.domain.Gallery;

public interface FreeboardService {
	List<Freeboard> list();
	void write(Freeboard freeboard);
	Freeboard content(String fb_seq);
	void delete(String fb_seq);
	void update(Freeboard freeboard);
	Freeboard updateList(String fb_seq);
}

