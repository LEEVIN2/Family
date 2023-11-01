package com.animal.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;

import javax.inject.Inject;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.animal.domain.BoardDTO;
import com.animal.service.BoardService;

@org.springframework.stereotype.Controller
@RequestMapping("/board/*")
public class BoardController {
	
	// BoardService 객체생성
	@Inject
	private BoardService boardService;
	
	@GetMapping("/board")
	public String board() {
		return "board/board";
	}
	
	@GetMapping("/freeboard")
	public String freeboard(Model model) {
		List<BoardDTO> boardList= boardService.getBoardList();
		
		for (BoardDTO boardDTO : boardList) {
            String submitTime = boardDTO.getSubmitTime();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            LocalDateTime submitDateTime = LocalDateTime.parse(submitTime, formatter);
            LocalDateTime now = LocalDateTime.now();
            long minutesBetween = ChronoUnit.MINUTES.between(submitDateTime, now);
            if (minutesBetween < 1) {
                boardDTO.setSubmitTime("방금전");
            } else {
                boardDTO.setSubmitTime("한참전");
            }
        }
		
		model.addAttribute("boardList", boardList);
		return "board/freeboard";
	}
	
	@GetMapping("/freesearch")
	public String freesearch() {
		return "board/freesearch";
	}
	
	@GetMapping("/write")
	public String write() {
		return "board/write";
	}
	
	@PostMapping("/writePro")
	public String writePro(BoardDTO boardDTO) {
		boardService.writePro(boardDTO);
		return "redirect:/board/freeboard";
	}
		
}
