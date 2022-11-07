package com.petcare.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data


public class Tag {
	private List<String> kind; //산책,방문돌봄,위탁돌봄
	//private String gender;
	private String neighbor; //견주,집사,견주/집사
	private String meeting; //사전만남
	private String cut;
	private String bigcare;
	private String dol_seq;
}
