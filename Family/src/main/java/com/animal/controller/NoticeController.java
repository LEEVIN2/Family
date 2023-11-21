package com.animal.controller;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.animal.domain.BoardDTO;
import com.animal.service.NoticeService;

import edu.emory.mathcs.backport.java.util.Collections;

@Controller
@RequestMapping("/notice/*")
public class NoticeController {
	
	@Inject
	private NoticeService noticeService;
	
	@GetMapping("/notice")
	public String notice(HttpSession session, Model model) {
		
		String id = (String) session.getAttribute("id");
		
		BoardDTO boardDTO =new BoardDTO();
		boardDTO.setId(id);
		
//		댓글알림
		List<BoardDTO> commentList = noticeService.getCommentList(boardDTO);
		model.addAttribute("commentList", commentList);
		
//		좋아요알림
		List<BoardDTO> likeList = noticeService.getLikeList(boardDTO);
		model.addAttribute("likeList", likeList);
		
		// 빙 추가작성 코드 (댓글과 좋아요를 합쳐서 noticeList로 한번에 보여주기 (submitTime을 기준으로 내림차순정렬)
		// Merge the two lists
	    List<BoardDTO> noticeActiveList = new ArrayList<BoardDTO>();
	    noticeActiveList.addAll(likeList);
	    noticeActiveList.addAll(commentList);

	    // Sort the merged list in descending order of submitTime
	    Collections.sort(noticeActiveList, new Comparator<BoardDTO>() {
	        public int compare(BoardDTO dto1, BoardDTO dto2) {
	            return dto2.getSubmitTime().compareTo(dto1.getSubmitTime());
	        }
	    });
	    
	    
//	    소식내용
	    List<BoardDTO> popularList = noticeService.getPopularList();
	    List<BoardDTO> bestList = noticeService.getBestList();
	    
	    List<BoardDTO> noticeNewsList2 = new ArrayList<BoardDTO>();
	    noticeNewsList2.addAll(bestList);
	    noticeNewsList2.addAll(popularList);

//	    중복제거
	    List<BoardDTO> noticeNewsList = noticeNewsList2.stream()
	        .distinct()
	        .collect(Collectors.toList());
	    
	    Collections.sort(noticeNewsList, new Comparator<BoardDTO>() {
	        public int compare(BoardDTO dto1, BoardDTO dto2) {
	            return dto2.getSubmitTime().compareTo(dto1.getSubmitTime());
	        }
	    });
	    
	    ////////////////////////
	    // 여기서부터 전체 보여주기 (noticeActiveList+noticeNewsList)
	    List<BoardDTO> noticeList = new ArrayList<BoardDTO>();
	    noticeList.addAll(noticeActiveList);
	    noticeList.addAll(noticeNewsList);
	    
	    Collections.sort(noticeList, new Comparator<BoardDTO>() {
	        public int compare(BoardDTO dto1, BoardDTO dto2) {
	            return dto2.getSubmitTime().compareTo(dto1.getSubmitTime());
	        }
	    });
	    
	    // Now you can add notificationList to your model and return it to your view
	    model.addAttribute("noticeActiveList", noticeActiveList);
	    model.addAttribute("noticeNewsList", noticeNewsList);
	    model.addAttribute("noticeList", noticeList);
		
		return "notice/notice";
	}

	@PostMapping("/updateRead")
	public String updateRead(BoardDTO boardDTO) {
		System.out.println(boardDTO);
		noticeService.updateRead(boardDTO);
		return "redirect:/board/detail?boardNum=" + boardDTO.getBoardNum();
	}
	
	@PostMapping("/delete")
	public ResponseEntity<String> delete(BoardDTO boardDTO) {
//	    System.out.println(boardDTO);
	    noticeService.delete(boardDTO);
	    return new ResponseEntity<>("Success", HttpStatus.OK);
	}

	
}
