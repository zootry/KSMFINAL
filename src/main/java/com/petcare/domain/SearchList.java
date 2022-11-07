package com.petcare.domain;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@AllArgsConstructor
@NoArgsConstructor
@Data
public class SearchList {
	private String category;
	private String kind;
	private String tag;
	private String workday;
	private Date workdate;
	private List<String> region;
	private String neighbor;
	private String meeting;
	private String cut;
	private String bigcare;
	private String stime;
	private String etime;
	private String keyword;
	//private long pageNum;
	//private long pageSize;
	//private long startRowPerPage;
	//private long endRowPerPage;
	
	/*public SearchList() {
		
	}
	public SearchList(long pageNum, long pageSize){
		setPageNum(pageNum);
		setPageSize(pageSize);
		calStartRowPerPage();
		calEndRowPerPage();
	}
	
	public void calStartRowPerPage() {
		setStartRowPerPage((getPageNum()-1) * getPageSize());
	}
	public void calEndRowPerPage() {
		setEndRowPerPage(getPageNum() * getPageSize());
	}*/
}

