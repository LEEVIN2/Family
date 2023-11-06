package com.animal.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.animal.dao.MypageDAO;

@Service
public class MypageService {
	
	@Inject
	private MypageDAO mypageDAO;

}
