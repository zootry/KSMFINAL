package com.petcare.service;

import java.util.List;

import com.petcare.domain.ListVo;
import com.petcare.domain.PrevAndNext;
import com.petcare.domain.ShareMarket;

public interface ShareMarketService {
	List<ShareMarket> getShareMarketLists(ListVo listVo);
	List<ShareMarket> getShareMarketSearchLists(ListVo listVo);
	long getTotalRowCounts(List<String> region);
	long getTotalSearchRowCounts(ListVo listVo);
	ShareMarket getShareMarketContents(String sm_seq);
	void setShareMarketContents(ShareMarket shareMarket);
	void renewShareMarketContents(ShareMarket shareMarket);
	void removeShareMarketContents(String sm_seq);
	PrevAndNext getPrevAndNext(ListVo listVo);
	void renewShareMarketViews(String sm_seq);
}
