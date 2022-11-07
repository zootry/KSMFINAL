package com.petcare.service;

import java.util.HashMap;
import java.util.List;

import com.petcare.domain.Dolbom;
import com.petcare.domain.Dolbomlist;
import com.petcare.domain.ListVo;
import com.petcare.domain.SearchList;
import com.petcare.domain.Tag;

public interface DolbomService {
	Dolbom contentS(String dol_seq);	
	void insertDolbomS(Dolbom dolbom);
	List<Dolbomlist> selectDList(String email);
	void setStateContinue(long dl_seq);
	void setStateFinish(long dl_seq);
	String selectDolSeq(long dl_seq);
	void setStateContinueDolbom(String dol_seq);
	void setStateFinishDolbom(String dol_seq);
	void deleteList(long dl_seq);
	Dolbomlist selectforComt(long dl_seq);
	void insertDolbomListS(Dolbomlist dolbomlist);
	void updateDolbom(Dolbom dolbom);
	void deleteDolbom(String dol_seq);
	Tag selectTag(String dol_seq);
	void updateTag(Tag tag);
	
	//°Ë»ö
	List<Dolbom> searchOption(ListVo listVo);
	List<Dolbom> searchOptionDate(ListVo listVo);
	List<Dolbom> searchAllOption(ListVo listVo);
	List<Dolbom> searchAllOptionDate(ListVo listVo);
	
	String chatEmail(String dol_seq);
	List<Dolbom> selectTime(String email);
	List<Dolbomlist> dolbomSchedule(String dol_seq);
	
	void insertTags(Tag tag);
	
	void updateGive(long dl_seq);
	void updateTake(long dl_seq);
	
	long getSearchDongRCounts(List<String> region);
	long getSearchAllRCounts();
	List<Dolbom> getSearchAllByPage(ListVo listVo);
	List<Dolbom> getSearchDongByPage(ListVo listVo);
	long getOptionRCounts(ListVo listVo);
	long getOptionDateRCounts(ListVo listVo);
	long getAllOptionRCounts(ListVo listVo);
	long getAllOptionDateRCounts(ListVo listVo);
	
	List<Dolbomlist> reviewList(String email);
	void finishReview(long dl_seq);
}
