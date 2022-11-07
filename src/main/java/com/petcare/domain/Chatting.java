package com.petcare.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data

public class Chatting {
	private String c_number;
	private String c_subject;
	private String c_owner;
	private String c_guest;
	private Date c_date;
	private String c_category;
	private String c_b_seq;
	private String c_b_seq_offer;
	private String c_ownername;
	private String c_guestname;
}
