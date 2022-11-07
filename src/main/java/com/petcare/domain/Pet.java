package com.petcare.domain;

import java.sql.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Pet {	
	private String petseq;
	private String email;
	private String name;
	private String kind;	
	private String breed;
	private int byear;
	private int age;
	private String sex;
	private String cut;
	private String big;
	private String memo;	
	private Date rdate;
}