package com.animal.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

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
	
	@GetMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		String id = (String) session.getAttribute("id");
		MemberDTO memberDTO = mypageService.getMyProfile(id);
		model.addAttribute("memberDTO", memberDTO);
		return "mypage/mypage";
	}
	
	@GetMapping("/profile")
	public String profile(HttpSession session, Model model) {
		
		String id = (String) session.getAttribute("id");
		MemberDTO memberDTO = mypageService.getMyProfile(id);
		model.addAttribute("memberDTO", memberDTO);
		return "mypage/profile";
	}
	
	//	프로필 사진 수정
	@PostMapping("/changePhoto")
	public String changePhoto(MultipartHttpServletRequest mtfRequest, HttpSession session) {
		
	    // 파일 업로드 로직
	    List<MultipartFile> fileList = mtfRequest.getFiles("file");
	    
	    for (MultipartFile mf : fileList) {
	        String originFileName = mf.getOriginalFilename(); // 원본 파일 명
	        long fileSize = mf.getSize(); // 파일 사이즈

	        System.out.println("originFileName : " + originFileName);
	        System.out.println("fileSize : " + fileSize);
	        
	        String uploadPath = "C:\\Users\\sonmi\\git\\Family\\Family\\Family\\src\\main\\webapp\\resources\\img\\profile";

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
	
	@GetMapping("/deletePhoto")
	public String deletePhoto(HttpSession session) {
		String id = (String) session.getAttribute("id");
		MemberDTO memberDTO = mypageService.getMyProfile(id); // 사용자의 현재 프로필 사진 이름을 가져옵니다.
	    String profile = memberDTO.getProfile();
	    String uploadPath = "C:\\Users\\sonmi\\git\\Family\\Family\\Family\\src\\main\\webapp\\resources\\img\\profile";
	    String filePath = uploadPath + "\\" + profile;
	    File file = new File(filePath);
	    if(file.exists()) { // 파일이 실제로 존재하는지 확인합니다.
	        if(file.delete()) { // 파일을 삭제하고 성공 여부를 확인합니다.
	            System.out.println("File deleted successfully");
	        } else {
	            System.out.println("Failed to delete the file");
	        }
	    }
		mypageService.deletePhoto(id);
		return "redirect:/mypage/profile";
	}
	
}
