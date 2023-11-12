package com.animal.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.animal.domain.BoardDTO;
import com.animal.service.NoticeService;

@Controller
@RequestMapping("/notice/*")
public class NoticeController {
	
	@Inject
	private NoticeService noticeService;
	
	@GetMapping("/notice")
	public String notice(HttpSession session, Model model) {
		
		String id = (String) session.getAttribute("id");
		System.out.println(id);
		
		BoardDTO boardDTO =new BoardDTO();
		boardDTO.setId(id);
		
		List<BoardDTO> noticeList = noticeService.getNoticeList(boardDTO);
		model.addAttribute("noticeList", noticeList);
		
		
		return "notice/notice";
	}


	
}
