package com.animal.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;

import javax.inject.Inject;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
	public String writePro(BoardDTO boardDTO, MultipartHttpServletRequest mtfRequest) {
	    // 파일 업로드 로직
	    List<MultipartFile> fileList = mtfRequest.getFiles("file");
	    String path = "C:\\Users\\sonmi\\git\\Family\\Family\\Family\\src\\main\\webapp\\resources\\img\\";
	    for (MultipartFile mf : fileList) {
	        String originFileName = mf.getOriginalFilename(); // 원본 파일 명
	        long fileSize = mf.getSize(); // 파일 사이즈

	        System.out.println("originFileName : " + originFileName);
	        System.out.println("fileSize : " + fileSize);

	        String safeFile = path + originFileName;
	        try {
	            mf.transferTo(new File(safeFile));
	            boardDTO.setFilePath(originFileName); // 파일 경로 설정
	            System.out.println(boardDTO.getFilePath());
	        } catch (IllegalStateException e) {
	            e.printStackTrace();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }

	    // 게시글 작성 로직
	    boardService.writePro(boardDTO);

	    return "redirect:/board/freeboard";
	}
	
//	@PostMapping("/writePro")
//	public String writePro(BoardDTO boardDTO, MultipartHttpServletRequest mtfRequest) {
//		boardService.writePro(boardDTO);
//		return "redirect:/board/freeboard";
//	}
//	
////	다중파일업로드
//	@RequestMapping(value = "requestupload2")
//    public String requestupload2(MultipartHttpServletRequest mtfRequest) {
//        List<MultipartFile> fileList = mtfRequest.getFiles("file");
//        String src = mtfRequest.getParameter("src");
//        System.out.println("src value : " + src);
//
//        String path = "C:\\image\\";
//
//        for (MultipartFile mf : fileList) {
//            String originFileName = mf.getOriginalFilename(); // 원본 파일 명
//            long fileSize = mf.getSize(); // 파일 사이즈
//
//            System.out.println("originFileName : " + originFileName);
//            System.out.println("fileSize : " + fileSize);
//
//            String safeFile = path + System.currentTimeMillis() + originFileName;
//            try {
//                mf.transferTo(new File(safeFile));
//            } catch (IllegalStateException e) {
//                // TODO Auto-generated catch block
//                e.printStackTrace();
//            } catch (IOException e) {
//                // TODO Auto-generated catch block
//                e.printStackTrace();
//            }
//        }
//
//        return "redirect:/board/freeboard";
//    }
		
}
