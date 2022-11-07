package com.petcare.mapper;

import java.util.HashMap;
import java.util.List;

import com.petcare.domain.Dolbom;
import com.petcare.domain.Dolbomlist;
import com.petcare.domain.ListVo;
import com.petcare.domain.PageVo;
import com.petcare.domain.SearchList;
import com.petcare.domain.Tag;

public interface DolbomMapper {
	Dolbom content(String dol_seq);
	void insertDolbom(Dolbom dolbom);
	List<Dolbomlist> selectDList(String email);
	void setStateContinue(long dl_seq);
	void setStateFinish(long dl_seq);
	String selectDolSeq(long dl_seq);
	void setStateContinueDolbom(String dol_seq);
	void setStateFinishDolbom(String dol_seq);
	void deleteList(long dl_seq);
	Dolbomlist selectforComt(long dl_seq);
	void insertDolbomList(Dolbomlist dolbomlist);
	void updateDolbom(Dolbom dolbom);
	void deleteDolbom(String dol_seq);
	Tag selectTag(String dol_seq);
	void updateTag(Tag tag);
	
	/* 1005 검색*/
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
	/* 검색 페이징 */
	long selectSearchDongRCounts(List<String> region);
	long selectSearchAllRCounts();
	List<Dolbom> selectSearchAllByPage(ListVo listVo);
	List<Dolbom> selectSearchDongByPage(ListVo listVo);
	long searchOptionRCounts(ListVo listVo);
	long searchOptionDateRCounts(ListVo listVo);
	long searchAllOptionRCounts(ListVo listVo);
	long searchAllOptionDateRCounts(ListVo listVo);
	
	List<Dolbomlist> reviewList(String email);
	void finishReview(long dl_seq);
} 

