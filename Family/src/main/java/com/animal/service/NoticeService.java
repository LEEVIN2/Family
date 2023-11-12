package com.animal.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.animal.dao.NoticeDAO;

@Service
public class NoticeService {
	
	@Inject
	private NoticeDAO noticeDAO;

}
