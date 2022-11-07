package com.petcare.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.petcare.domain.CareReview;
import com.petcare.domain.Member;
import com.petcare.domain.MemberVo;
import com.petcare.mapper.MemberMapper;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {
	private MemberMapper mapper;	
	public void signupMS(Member member) {
		mapper.signupM(member);
	}
	public String checkEmailS(String id) {
		return mapper.checkEmail(id);
	}
	public String checkNickS(String nick) {
		return mapper.checkNick(nick);
	}
	public Member checkLoginS(String id) {
		return mapper.checkLogin(id);
	}
	public Member getMyinfoS(String m_seq) {
		return mapper.getMyinfo(m_seq);
	}
	public void updateMS(Member member) {
		mapper.updateM(member);
	}
	public void deleteMS(String m_seq) {
		mapper.deleteM(m_seq);
	}
	@Override
	public String getNicknameS(String email) {
		return mapper.getNickname(email);
	}
	@Override
	public void resetPwdS(String email, String pwd) {
		mapper.resetPwd(email, pwd);
	}
	@Override
	public List<Member> userlistS() {
		return mapper.userlist();
	}
	@Override
	public void userupdateS(Member member) {
		mapper.userupdate(member);
	}
	@Override
	public Member userbyemailS(String email) {
		return mapper.userbyemail(email);
	}
	@Override
	public MemberVo getMemberVo(int cp, int ps) {
		MemberVo memberVo = new MemberVo(cp, ps);
		long totalCount = mapper.selectCount();
		List<Member> list = mapper.selectPerPage(memberVo);
		return new MemberVo(cp, totalCount, ps, list);
	}
	@Override
	public MemberVo getMemberVo(int cp, int ps, String catgo, String keyword) {
		MemberVo memberVo = new MemberVo(cp, ps, catgo, keyword);
		long totalCount = mapper.selectCountBySearch(memberVo);
		List<Member> list = mapper.selectPerPageBySearch(memberVo);
		return new MemberVo(cp, totalCount, ps, list);
	}
	@Override
	public String getemailS(String nickname) {
		return mapper.getemail(nickname);
	}
	@Override
	public void setMemberStar(CareReview carereview) {
		mapper.updateMemberStar(carereview);
	}
	@Override
	public Member getDolbomyInfo(String email) {
		return mapper.selectDolbomyInfo(email);
	}
	@Override
	public int countPets(String email) {
		return mapper.countPets(email);
	}
}