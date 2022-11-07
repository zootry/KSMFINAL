package com.petcare.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class PageVo {
	private long totalCount;
	private int totalPageCount;
	private int pageSize;
	private int currentPage;
	private int totalPageRange=5;
	private int pageRange=totalPageRange/2;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	public int getStartRow() {
		return (currentPage-1)*pageSize;
	}
	public int getEndRow() {
		return currentPage*pageSize;
	}
	public PageVo(int currentPage, int pageSize, long totalCount) {
		this.currentPage = currentPage;
		this.pageSize = pageSize;
		this.totalCount = totalCount;
		this.totalPageCount = calTotalPageCount();
		this.startPage = calStartPage();
		this.endPage = calEndPage();
		this.prev = hasPrev();
		this.next = hasNext();
	}
	private int calTotalPageCount() {
		int tpc = (int)totalCount/pageSize;
		if(totalCount%pageSize != 0) tpc++;
		
		return tpc;
	}
	private int calStartPage() {
		int sp = 1;
		if(totalPageCount<5) {
			sp = 1;
		}else {
			if(currentPage<=pageRange) sp = 1;
			else if(currentPage>=(totalPageCount-pageRange)) sp = totalPageCount-totalPageRange+1;
			else sp = currentPage-pageRange;
		}
		if(sp<1) sp=1;
		
		return sp;
	}
	private int calEndPage() {
		int ep = totalPageCount;
		
		if(totalPageCount>5){
			if(currentPage<=pageRange) ep = totalPageRange;
			else if(currentPage<=(totalPageCount-pageRange))ep = currentPage+pageRange;
		}
	
		return ep;
	}
	private boolean hasPrev() {
		boolean prev = false;
		if(currentPage>1 && totalPageCount>totalPageRange) prev = true;
		
		return prev;
	}
	private boolean hasNext() {
		boolean next = true;
		if(totalPageCount<=totalPageRange || currentPage>=totalPageCount) next = false;
		
		return next;
	}

}
