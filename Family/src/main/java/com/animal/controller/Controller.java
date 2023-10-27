package com.animal.controller;

import javax.inject.Inject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.animal.domain.DTO;
import com.animal.service.Service;

@org.springframework.stereotype.Controller
@RequestMapping("/member/*")
public class Controller {
	
	@Inject
	private Service Service;
	
	@GetMapping("/login")
	public String employees() {
		return "member/login";
	}
	
	@PostMapping("/insertPro")
	public String loginPro(DTO DTO) {
		System.out.println(DTO);
		Service.insert(DTO);
		return "redirect:/member/login";
	}

}
