package com.petcare.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class MyDong {
	private long dongno;
	private String dongname;
	private Double y;
	private Double x;
	private Double range;
	private String useremail;
}
