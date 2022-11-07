package com.petcare.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.petcare.domain.CareReview;
import com.petcare.domain.Member;
import com.petcare.domain.MemberVo;

public interface MemberMapper {
	void signupM(Member member); 
	String checkEmail(String id);
	String checkNick(String nick);
	Member checkLogin(String id); 
	Member getMyinfo(String m_seq); 	
	void updateM(Member member); 
	void deleteM(String m_seq); 
	String getNickname(String email);
	void resetPwd(@Param("email") String email, @Param("pwd") String pwd);
	List<Member> userlist();
	void userupdate(Member member);
	Member userbyemail(String email);
	long selectCount();
	long selectCountBySearch(MemberVo memberVo);
	List<Member> selectPerPage(MemberVo memberVo);
	List<Member> selectPerPageBySearch(MemberVo memberVo);
	String getemail(String nickname);
	void updateMemberStar(CareReview carereview);
	Member selectDolbomyInfo(String email);
	int countPets(String email);
}