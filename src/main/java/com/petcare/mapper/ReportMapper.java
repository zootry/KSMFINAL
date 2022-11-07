package com.petcare.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.petcare.domain.Report;
import com.petcare.domain.ReportVo;

public interface ReportMapper {
	List<Report> list();
	void insert(Report report);
	void delete(long rep_seq);
	void update(@Param("rep_state") String rep_state,@Param("rep_seq") long rep_seq);
	Report content(long rep_seq);
	List<Report> selectPerPage(ReportVo reportVo);
	long selectCount();
	long selectCountBySearch(ReportVo reportVo);
	List<Report> selectPerPageBySearch(ReportVo reportVo);
}
