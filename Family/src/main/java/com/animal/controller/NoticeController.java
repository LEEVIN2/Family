package com.animal.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/notice/*")
public class NoticeController {
	
	@Inject
//	private NoticeController noticeService;
	
	@GetMapping("/notice")
	public String notice() {
		return "notice/notice";
	}
	
}
