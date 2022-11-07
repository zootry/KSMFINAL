package com.petcare.domain;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class CareReview {
	private String cr_seq;
	private String content;
	private String writer; /*���ۼ��� �г���*/
	private String writerEmail; /*���ۼ��� �̸���*/
	private String dolbomy; /*������ �г���*/
	private String dolbomyEmail; /*������ �̸���*/
	private float star;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd")
	private Date wdate;
	long dl_seq;
}
