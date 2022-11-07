package com.petcare.domain;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Member {
	private String email;
	private String pwd;
	private String nickname;
	private String agree;
	private String name;
	private String phone;
	private String gender;
	private String addr;
	private String m_seq;
	private float sat;
	private Date joindate;
	private int give;
	private int take;
	private int reviews;
}