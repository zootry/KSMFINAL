package com.petcare.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import com.petcare.domain.Dolbom;
import com.petcare.domain.Dolbomlist;
import com.petcare.domain.ListVo;
import com.petcare.domain.PageVo;
import com.petcare.domain.SearchList;
import com.petcare.domain.Tag;
import com.petcare.mapper.DolbomMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class DolbomServiceImpl implements DolbomService{
	private DolbomMapper dolbommapper;
	
	@Override
	public Dolbom contentS(String dol_seq){
		return dolbommapper.content(dol_seq);
	}
	@Override
	public void insertDolbomS(Dolbom dolbom) {
		dolbommapper.insertDolbom(dolbom);
	}
	@Override
	public List<Dolbomlist> selectDList(String email){
		List<Dolbomlist> dlist = dolbommapper.selectDList(email);
		return dlist;
	}
	@Override
	public void setStateContinue(long dl_seq) {
		dolbommapper.setStateContinue(dl_seq);
	}
	@Override
	public void setStateFinish(long dl_seq) {
		dolbommapper.setStateFinish(dl_seq);
	}
	@Override
	public String selectDolSeq(long dl_seq) {
		String dol_seq = dolbommapper.selectDolSeq(dl_seq);
		return dol_seq;
	}
	@Override
	public void setStateContinueDolbom(String dol_seq) {
		dolbommapper.setStateContinueDolbom(dol_seq);
	}
	@Override
	public void setStateFinishDolbom(String dol_seq) {
		dolbommapper.setStateFinishDolbom(dol_seq);
	}
	@Override
	public void deleteList(long dl_seq) {
		dolbommapper.deleteList(dl_seq);
	}
	@Override
	public Dolbomlist selectforComt(long dl_seq) {
		Dolbomlist dlist = dolbommapper.selectforComt(dl_seq);
		return dlist;
	}
	@Override
	public void insertDolbomListS(Dolbomlist dolbomlist){
		 dolbommapper.insertDolbomList(dolbomlist);
	}
	@Override
	public void updateDolbom(Dolbom dolbom) {
		dolbommapper.updateDolbom(dolbom);
	}
	@Override
	public void deleteDolbom(String dol_seq) {
		dolbommapper.deleteDolbom(dol_seq);
	}
	@Override
	public Tag selectTag(String dol_seq) {
		return dolbommapper.selectTag(dol_seq);
	}
	@Override
	public void updateTag(Tag tag) {
		dolbommapper.updateTag(tag);
	}
	@Override
	public List<Dolbom> searchOption(ListVo listVo){
		List<Dolbom> dolbomlist = dolbommapper.searchOption(listVo);
		return dolbomlist;
	}
	@Override
	public List<Dolbom> searchOptionDate(ListVo listVo){
		List<Dolbom> dolbomlist = dolbommapper.searchOptionDate(listVo);
		return dolbomlist;
	}
	@Override
	public List<Dolbom> searchAllOption(ListVo listVo){
		List<Dolbom> dolbomlist = dolbommapper.searchAllOption(listVo);
		return dolbomlist;
	}
	@Override
	public List<Dolbom> searchAllOptionDate(ListVo listVo){
		List<Dolbom> dolbomlist = dolbommapper.searchAllOptionDate(listVo);
		return dolbomlist;
	}
	@Override
	public String chatEmail(String dol_seq) {
		String gemail = dolbommapper.chatEmail(dol_seq);
		return gemail;/*????*/
	}
	@Override
	public List<Dolbom> selectTime(String email) {
		List<Dolbom> times = dolbommapper.selectTime(email);
		return times;
	}
	@Override
	public List<Dolbomlist> dolbomSchedule(String dol_seq){
		List<Dolbomlist> dlist = dolbommapper.dolbomSchedule(dol_seq);
		return dlist;
	}
	@Override
	public void insertTags(Tag tag) {
		dolbommapper.insertTags(tag);
	}
	@Override
	public void updateGive(long dl_seq) {
		dolbommapper.updateGive(dl_seq);
	}
	@Override
	public void updateTake(long dl_seq) {
		dolbommapper.updateTake(dl_seq);	
	}
	@Override
	public long getSearchDongRCounts(List<String> region) {
		return dolbommapper.selectSearchDongRCounts(region);
	}
	@Override
	public long getSearchAllRCounts() {
		return dolbommapper.selectSearchAllRCounts();
	}
	@Override
	public List<Dolbom> getSearchAllByPage(ListVo listVo){
		return dolbommapper.selectSearchAllByPage(listVo);
	}
	@Override
	public List<Dolbom> getSearchDongByPage(ListVo listVo){
		List<Dolbom> list = dolbommapper.selectSearchDongByPage(listVo);
		return list;
	}
	@Override
	public long getOptionRCounts(ListVo listVo) {
		return dolbommapper.searchOptionRCounts(listVo);
	}
	@Override
	public long getOptionDateRCounts(ListVo listVo) {
		return dolbommapper.searchOptionDateRCounts(listVo);
	}
	@Override
	public long getAllOptionRCounts(ListVo listVo) {
		return dolbommapper.searchAllOptionRCounts(listVo);
	}
	@Override
	public long getAllOptionDateRCounts(ListVo listVo) {
		return dolbommapper.searchAllOptionDateRCounts(listVo);
	}
	@Override
	public List<Dolbomlist> reviewList(String email){
		List<Dolbomlist> reviewlist = dolbommapper.reviewList(email);
		return reviewlist;
	}
	@Override
	public void finishReview(long dl_seq) {
		dolbommapper.finishReview(dl_seq);
	}
}
