package com.petcare.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Pagination {
	private long pageNum;
	private long pageSize;
	private long totalRowCounts;
	private long totalPageCounts;
	private long firstPageScope;
	private long lastPageScope;
	private boolean isPrev;
	private boolean isNext;
	
	public Pagination(ListVo listVo, long totalRowCounts) {
		setPageNum(listVo.getPageNum());
		setPageSize(listVo.getPageSize());
		setTotalRowCounts(totalRowCounts);
		calTotalPageCounts();
		calLastPageScope();
		calFirstPageScope();
		calIsPrev();
		calIsNext();
	}

	public void calTotalPageCounts() {
		long calResult = (long)(Math.ceil((double)getTotalRowCounts()/(double)getPageSize()));
		setTotalPageCounts(calResult);
	}
	
	public void calLastPageScope() {
		long calResult = (long)(Math.ceil((double)getPageNum()/(double)getPageSize())*getPageSize());
		setLastPageScope(calResult);
		if(getLastPageScope()>getTotalPageCounts()) {
			setLastPageScope(getTotalPageCounts());
		}
	}
	
	public void calFirstPageScope() {
		setFirstPageScope(getLastPageScope()-getPageSize()+1);
		if(getFirstPageScope()<=0) setFirstPageScope(1);
	}
	
	public void calIsPrev() {
		if(getPageNum() > 1) setPrev(true);
	}
	
	public void calIsNext() {
		if(getPageNum() < getTotalPageCounts()) setNext(true);
	}
}
