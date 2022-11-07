package com.petcare.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.petcare.domain.Chatting;

public interface ChattingMapper {
	List<Chatting> list(@Param("c_owner") String c_owner,@Param("c_guest") String c_guest);
	void insert(Chatting chatting);
	void update(String c_number);
	void delete(String c_number);
	List<Chatting> listall();
	List<Chatting> listsearch(@Param("c_owner") String c_owner,@Param("c_guest") String c_guest,@Param("c_subject") String c_subject);
	
	Chatting checkduplicate(@Param("b_seq")String b_seq,@Param("email")String email);
	String selectCNum(@Param("c_subject")String c_subject,@Param("c_ownername")String c_ownername,@Param("c_guestname")String c_guestname);
}
