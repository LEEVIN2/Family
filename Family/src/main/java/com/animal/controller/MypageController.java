package com.animal.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.animal.domain.MemberDTO;
import com.animal.service.MypageService;

@Controller
@RequestMapping("/mypage/*")
public class MypageController {
	
	@Inject
	private MypageService mypageService;
	
	// 사진파일경로 (서블릿에서 가져오는거임)
		@Autowired
	    private String uploadPath;
	
	@GetMapping("/mypage")
	public String mypage() {
		return "mypage/mypage";
	}
	
	@GetMapping("/profile")
	public String profile(HttpSession session, Model model) {
		
		String id = (String) session.getAttribute("id");
		MemberDTO memberDTO = mypageService.getMyProfile(id);
		model.addAttribute("memberDTO", memberDTO);
		return "mypage/profile";
	}
	
	
	@PostMapping("/changePhoto")
	public String changePhoto(MultipartHttpServletRequest mtfRequest, HttpSession session) {
		
	    // 파일 업로드 로직
	    List<MultipartFile> fileList = mtfRequest.getFiles("file");
	    
	    for (MultipartFile mf : fileList) {
	        String originFileName = mf.getOriginalFilename(); // 원본 파일 명
	        long fileSize = mf.getSize(); // 파일 사이즈

	        System.out.println("originFileName : " + originFileName);
	        System.out.println("fileSize : " + fileSize);

	        String safeFile = uploadPath + "\\" + originFileName;
	        try {
	            mf.transferTo(new File(safeFile));
	            String profile = originFileName;
	            String id = (String) session.getAttribute("id");
	            MemberDTO memberDTO = new MemberDTO();
	            memberDTO.setId(id);
	            memberDTO.setProfile(profile);
	            mypageService.changePhoto(memberDTO); // 파일 경로 추가
	            System.out.println(originFileName);
	        } catch (IllegalStateException e) {
	            e.printStackTrace();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
	    return "redirect:/mypage/profile";
	}
	
}
