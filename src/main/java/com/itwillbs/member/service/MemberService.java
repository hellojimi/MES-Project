package com.itwillbs.member.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;

import com.itwillbs.member.domain.MemberDTO;

public interface MemberService {
	// 클래스 만들기 위한 부모 인터페이스 틀
	// 추상메서드 틀 정의
	public void insertMember(MemberDTO memberDTO);
	
	public MemberDTO getMember(String id);
	
	public void updateMember(MemberDTO memberDTO);
	
	public void deleteMember(MemberDTO memberDTO);
	
	public List<MemberDTO> getMemberList(MemberDTO memberDTO, Model model);
}
