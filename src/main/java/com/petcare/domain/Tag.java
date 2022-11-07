package com.petcare.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data


public class Tag {
	private List<String> kind; //��å,�湮����,��Ź����
	//private String gender;
	private String neighbor; //����,����,����/����
	private String meeting; //��������
	private String cut;
	private String bigcare;
	private String dol_seq;
}
