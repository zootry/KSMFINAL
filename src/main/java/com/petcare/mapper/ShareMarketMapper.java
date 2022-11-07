package com.petcare.mapper;

import java.util.List;

import com.petcare.domain.ListVo;
import com.petcare.domain.PrevAndNext;
import com.petcare.domain.ShareMarket;

public interface ShareMarketMapper {
	List<ShareMarket> selectShareMarketLists(ListVo listVo);
	List<ShareMarket> selectShareMarketSearchLists(ListVo listVo);
	long selectTotalRowCounts(List<String> region);
	long selectTotalSearchRowCounts(ListVo listVo);
	ShareMarket selectShareMarketContents(String sm_seq);
	void insertShareMarketContents(ShareMarket shareMarket);
	void updateShareMarketContents(ShareMarket shareMarket);
	void deleteShareMarketContents(String sm_seq);
	PrevAndNext selectPrevAndNext(ListVo listVo);
	void updateShareMarketViews(String sm_seq);
}
