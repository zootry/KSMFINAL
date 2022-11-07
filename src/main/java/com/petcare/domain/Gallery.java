package com.petcare.domain;

import java.sql.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Gallery {
	private String g_seq;
	private String email;
	private String content;
	private int likes;
	private Date wdate;
}