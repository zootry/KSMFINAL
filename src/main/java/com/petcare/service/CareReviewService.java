package com.petcare.service;

import java.util.List;
import com.petcare.domain.CareReview;
import com.petcare.domain.CareReviewVo;


public interface CareReviewService {
	List<CareReviewVo> selectList();
	List<CareReviewVo> selectSearchS(String category, String keyword);
	List<CareReviewVo> selectSearchAllS(String keyword);
	List<CareReviewVo> rankingDateS();
	List<CareReviewVo> rankingStarS();
	void insertS(CareReview carereview);
	void deleteS(String cr_seq);
	void editS(CareReview carereview);	
	CareReview getcarereviewS(String cr_seq); 
	CareReview selectBySeqS(String cr_seq);
}
