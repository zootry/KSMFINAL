package com.petcare.service;

import java.util.List;

import com.petcare.domain.Report;
import com.petcare.domain.ReportVo;

public interface ReportService {
	List<Report> listS();
	void insertS(Report report);
	void deleteS(long rep_seq);
	void updateS(String rep_state, long rep_seq);
	Report contentS(long rep_seq);
	ReportVo getReportVo(int cp, int ps, String catgo, String keyword, String rep_state);
	ReportVo getReportVo(int cp, int ps);
}
