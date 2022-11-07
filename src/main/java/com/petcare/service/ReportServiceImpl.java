package com.petcare.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petcare.domain.Report;
import com.petcare.domain.ReportVo;
import com.petcare.mapper.ReportMapper;
@Service
public class ReportServiceImpl implements ReportService {
	@Autowired
	private ReportMapper reportmapper;
	
	@Override
	public List<Report> listS() {
		return reportmapper.list();
	}

	@Override
	public void insertS(Report report) {
		reportmapper.insert(report);

	}

	@Override
	public void deleteS(long rep_seq) {
		reportmapper.delete(rep_seq);
	}

	@Override
	public void updateS(String rep_state, long rep_seq) {
		reportmapper.update(rep_state, rep_seq);
	}

	@Override
	public Report contentS(long rep_seq) {
		return reportmapper.content(rep_seq);
	}

	@Override
	public ReportVo getReportVo(int cp, int ps) {
		ReportVo reportVo = new ReportVo(cp, ps);
		long totalCount = reportmapper.selectCount();
		List<Report> list = reportmapper.selectPerPage(reportVo);
		return new ReportVo(cp, totalCount, ps, list);
	}
	
	@Override
	public ReportVo getReportVo(int cp, int ps, String catgo, String keyword, String rep_state) {
		ReportVo reportVo = new ReportVo(cp, ps, catgo, keyword, rep_state);
		long totalCount = reportmapper.selectCountBySearch(reportVo);
		List<Report> list = reportmapper.selectPerPageBySearch(reportVo);
		return new ReportVo(cp, totalCount, ps, list);
	}
}
