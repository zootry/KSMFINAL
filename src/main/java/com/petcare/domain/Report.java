package com.petcare.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data

public class Report {
	private long rep_seq;
	private String rep_content;
	private String rep_remail;
	private String rep_wemail;
	private String rep_reason;
	private String rep_wseq;
	private String rep_state;
	private Date rep_date;
	private Date rep_pdate;
}
