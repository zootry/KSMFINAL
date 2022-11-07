package com.petcare.domain;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class FilesVo {
	private long f_seq;
	private String seqinit; //������ ���� ����
	private String b_seq;
	private String seqname; //�������̸�
	private String fname;
	private String ofname;
	
	public FilesVo(MultipartFile img, String imgName,String seqinit) {
		setFname(imgName);
		setOfname(img.getOriginalFilename());
		settingSeq(seqinit);
	}
	public void settingSeq(String seqinit) {
		if(seqinit.startsWith("M")) {
			setSeqinit(seqinit);
			setSeqname("MEMBER_SEQ");
		}
		if(seqinit.startsWith("pet")) {
			setSeqinit(seqinit);
			setSeqname("PET_SEQ");
		}
		if(seqinit.startsWith("SM")) {
			setSeqinit(seqinit);
			setSeqname("SHAREMARKET_SEQ");
		}
		if(seqinit.startsWith("DOL")) {
			setSeqinit(seqinit);
			setSeqname("DOLBOM_SEQ");
		}
		if(seqinit.startsWith("G")) {
			setSeqinit(seqinit);
			setSeqname("GALLERY_SEQ");
		}
		if(seqinit.startsWith("CR")) {
			setSeqinit(seqinit);
			setSeqname("CAREREVIEW_SEQ");
		}
	}
}
