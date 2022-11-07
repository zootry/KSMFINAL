package com.petcare.service;

import java.util.List;

import com.petcare.domain.CareReview;
import com.petcare.domain.Member;
import com.petcare.domain.MemberVo;

public interface MemberService {
	void signupMS(Member member);
	String checkEmailS(String id);
	String checkNickS(String nick);
	Member checkLoginS(String id);
	Member getMyinfoS(String m_seq);
	void updateMS(Member member);
	void deleteMS(String m_seq);
	String getNicknameS(String email);
	void resetPwdS(String email, String pwd);
	List<Member> userlistS();
	void userupdateS(Member member);
	Member userbyemailS(String email);
	MemberVo getMemberVo(int cp, int ps, String catgo, String keyword);
	MemberVo getMemberVo(int cp, int ps);
	String getemailS(String nickname);
	void setMemberStar(CareReview carereview);
	Member getDolbomyInfo(String email);
	int countPets(String email);
}
