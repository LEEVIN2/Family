package com.animal.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.animal.dao.MypageDAO;
import com.animal.domain.MemberDTO;

@Service
public class MypageService {
	
	@Inject
	private MypageDAO mypageDAO;
	
	public MemberDTO getMyProfile(String id) {
		return mypageDAO.getMyProfile(id);
	}

	public void changePhoto(MemberDTO memberDTO) {
		System.out.println("MypageService");
		mypageDAO.changePhoto(memberDTO);
	}

}
