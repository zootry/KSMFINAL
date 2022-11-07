package com.petcare.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.petcare.domain.CareReview;
import com.petcare.domain.CareReviewVo;

public interface CareReviewMapper {
	List<CareReviewVo> selectList();
	List<CareReviewVo> selectSearch(@Param("category") String category, @Param("keyword")String keyword);
	List<CareReviewVo> selectSearchAll(String keyword);
	List<CareReviewVo> rankingDate();
	List<CareReviewVo> rankingStar();
	CareReview selectBySeq(String cr_seq);											
	void insert(CareReview carereview);
	CareReview getcarereview(String cr_seq);
	void delete(String cr_seq);
	void edit(CareReview carereview);
}
 