package com.animal.controller;

@org.springframework.stereotype.Controller
@RequestMapping("/board/*")
public class BoardController {
	
	// BoardService 객체생성
	@Inject
	private BoardService boardService;
	
	@GetMapping("/insert")
	public String insert() {
		return "member/insert";
	}
		
}
