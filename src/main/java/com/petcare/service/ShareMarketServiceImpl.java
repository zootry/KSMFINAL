package com.petcare.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.petcare.domain.ListVo;
import com.petcare.domain.PrevAndNext;
import com.petcare.domain.ShareMarket;
import com.petcare.mapper.ShareMarketMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class ShareMarketServiceImpl implements ShareMarketService {
	private ShareMarketMapper mapper;
	
	@Override
	public List<ShareMarket> getShareMarketLists(ListVo listVo) {
		return mapper.selectShareMarketLists(listVo);
	}
	
	@Override
	public List<ShareMarket> getShareMarketSearchLists(ListVo listVo){
		return mapper.selectShareMarketSearchLists(listVo);
	}
	
	@Override
	public long getTotalRowCounts(List<String> region) {
		return mapper.selectTotalRowCounts(region);
	}
	
	@Override
	public long getTotalSearchRowCounts(ListVo listVo) {
		return mapper.selectTotalSearchRowCounts(listVo);
	}
	
	@Override
	public ShareMarket getShareMarketContents(String sm_seq) {
		return mapper.selectShareMarketContents(sm_seq);
	}
	
	@Override
	public void setShareMarketContents(ShareMarket shareMarket) {
		mapper.insertShareMarketContents(shareMarket);
	}
	
	@Override
	public void renewShareMarketContents(ShareMarket shareMarket) {
		mapper.updateShareMarketContents(shareMarket);
	}
	
	@Override
	public void removeShareMarketContents(String sm_seq) {
		mapper.deleteShareMarketContents(sm_seq);
	}
	
	@Override
	public PrevAndNext getPrevAndNext(ListVo listVo) {
		return mapper.selectPrevAndNext(listVo);
	}
	
	@Override
	public void renewShareMarketViews(String sm_seq) {
		mapper.updateShareMarketViews(sm_seq);
	}
}
