package com.petcare.domain;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data

public class Dolbom {
	private String dol_seq;
	private String category;
	private String header;
	private String content;
	private String kind;
	private String region;
	private Date workdate;
	private String workday;
	private String workstime;
	private String worketime;
	private String tag;
	private String state;
	@JsonFormat(shape= JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private Date wdate;
	private String nickname;
	private String email;
	private int chat;
	private long likes;
}
