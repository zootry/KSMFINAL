package com.petcare.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;
import lombok.extern.log4j.Log4j;

@Log4j
@Data
public class ListVo {
	private long pageNum;
	private long pageSize;
	private String key;
	private String word;
	private long startRowPerPage;
	private long endRowPerPage;
	private String b_seq;
	private List<String> region;
	private String category;
	private String kind;
	private Date workdate;
	private String workday;
	private String neighbor;
	private String meeting;
	private String cut;
	private String bigcare;
	private String stime;
	private String etime;
		
	public ListVo(long pageNum, long pageSize){
		setPageNum(pageNum);
		setPageSize(pageSize);
		calStartRowPerPage();
		calEndRowPerPage();
	}
	
	public void calStartRowPerPage() {
		setStartRowPerPage((getPageNum()-1) * getPageSize());
		log.info(getStartRowPerPage());
	}
	public void calEndRowPerPage() {
		setEndRowPerPage(getPageNum() * getPageSize());
		log.info(getEndRowPerPage());
	}
}
