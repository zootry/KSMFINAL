package com.petcare.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberVo {
	private List<Member> list;
	private int cp;
	private int ps;
	private long totalCount;
	private long totalPageCount;
	private int currentRange = 1;
	private int rangeCount;
	private int startPage = 1;
	private int endPage = 1;
	private int prevPage;
	private int nextPage;
	private int rangeSize = 10;
	
	public MemberVo(int cp, int ps) {
		this.cp = cp;
		this.ps = ps;
	}
	public int getStartRow() {
		return (cp-1)*ps;
	}
	public int getEndRow() {
		return cp*ps;
	}
	public MemberVo(int cp, long totalCount, int ps, List<Member> list) {
		this.cp = cp;
		this.totalCount = totalCount;
		this.ps = ps;
		this.list = list;
		this.totalPageCount = calTotalPageCount();
		setRangeCount(totalPageCount);
	}
	private long calTotalPageCount() {
		long tpc = totalCount/ps;
		if(totalCount%ps != 0) tpc++;
		return tpc;
	}
	public void setPageCount(int totalCount) {
		this.totalPageCount = (int) Math.ceil(totalCount*1.0/ps);
	}
	public void setRangeCount(long totalPageCount) {
		this.rangeCount = (int) Math.ceil(totalPageCount*1.0/rangeSize);
	}
	public void setRange(int cp) {
		setCurRange(cp);
		this.startPage = (currentRange-1)*rangeSize+1;
		this.endPage = (int) (startPage + rangeSize -1);
		
		if(endPage>totalPageCount) {
			this.endPage = (int) totalPageCount;
		}
		
		this.prevPage = cp -1;
		this.nextPage = cp +1;
	}
	public void setCurRange(int cp) {
		this.currentRange = (int)((cp-1)/rangeSize)+1;
	}
	String catgo;
	String keyword;
	public MemberVo(int cp, int ps, String catgo, String keyword) {
		this.cp = cp;
		this.ps = ps;
		this.catgo = catgo;
		this.keyword = keyword;
	}
}
