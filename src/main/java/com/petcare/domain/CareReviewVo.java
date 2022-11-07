package com.petcare.domain;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class CareReviewVo {
	private String cr_seq;
	private String content;
	private String writer; /*���ۼ��� �г���*/
	private String dolbomy; /*������ �г���*/
	private String addr;
	private float sat;
	private float star;
	private int give;
	private int take;
	private int reviews;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date wdate;
	long dl_seq;
	String m_seq;
}
