package com.animal.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
		List<BoardDTO> boardList = boardService.getBoardList();
		
		
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
	public String freesearch(HttpServletRequest request,Model model) {
		
		String search = request.getParameter("search");
		System.out.println("search : " + search);
		
		BoardDTO boardDTO =new BoardDTO();
		boardDTO.setSearch(search); // 검색어저장
		
		// 품목추가한 내용 뿌려주기
	    List<BoardDTO> boardList= boardService.getFreesearchList(boardDTO);
		
	 // 품목추가한 내용 뿌려주기
	    model.addAttribute("boardList", boardList);
		
		return "board/freesearch";
	}
	
	@GetMapping("/detail")
	public String detail(HttpServletRequest request, HttpSession session, Model model) {
		//boardNum에 해당하는 board + board_file 내용 가져오기
		String boardNum = request.getParameter("boardNum");
	    BoardDTO boardDTO = boardService.getDetail(boardNum);
	    List<String> filePaths = boardService.getFilePaths(boardNum);
	    
	    // 댓글 내용 뿌려주기
	    List<BoardDTO> commentList = boardService.getCommentList();
	    
	    // 조회수 증가 로직
	    // 게시글 작성자 닉네임
	    String currentBoardNum = boardDTO.getBoardNum();
	    String currentNickname = boardDTO.getNickname();
	    // 세션에서 이전에 클릭한 닉네임 가져오기
	    String sessionBoardNum = (String) session.getAttribute("boardNum");
	    String sessionNickname = (String) session.getAttribute("nickname");

	    // 세션에 저장된 닉네임이 없거나, 현재 닉네임과 세션에 저장된 닉네임이 다르면 조회수 증가
	    if (sessionBoardNum == null || !sessionBoardNum.equals(currentBoardNum) && !sessionNickname.equals(currentNickname)) {
	        boardService.increaseViewCnt(boardNum);
	        session.setAttribute("boardNum", currentBoardNum);
	    }
	    
	    // 내 좋아요 로직
	    // 이건 작성자 닉네임이고
//	    String nickname = request.getParameter("nickname");
	    // 이게 내 닉네임
	    String nickname = (String) session.getAttribute("nickname");
	    int board_like = (int) boardService.findLike(boardNum, nickname);
	    model.addAttribute("board_like", board_like);
	    
	    // 전체 좋아요 로직
	    int board_likeCnt = (int) boardService.findLikeCnt(boardNum);
	    model.addAttribute("board_likeCnt", board_likeCnt);
	    
	    
	    model.addAttribute("boardDTO", boardDTO);
	    model.addAttribute("filePaths", filePaths);
	    model.addAttribute("commentList", commentList);
	    
	    return "board/detail";
	}
	
	
	@PostMapping("/likeUp")
	public ResponseEntity<String> likeUp(@RequestParam String boardNum, @RequestParam String nickname) {
	    BoardDTO boardDTO = new BoardDTO();
	    boardDTO.setBoardNum(boardNum);
	    boardDTO.setNickname(nickname);

	    ResponseEntity<String> entity = null;
	    try {
	        boardService.likeUp(boardDTO);
	        entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	    } catch (Exception e) {
	        e.printStackTrace();
	        entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
	    }
	    return entity;
	}
	
	
	@PostMapping("/likeDown")
	public ResponseEntity<String> likeDown(@RequestParam String boardNum, @RequestParam String nickname) {
	    BoardDTO boardDTO = new BoardDTO();
	    boardDTO.setBoardNum(boardNum);
	    boardDTO.setNickname(nickname);

	    ResponseEntity<String> entity = null;
	    try {
	        boardService.likeDown(boardDTO);
	        entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
	    } catch (Exception e) {
	        e.printStackTrace();
	        entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
	    }
	    return entity;
	}
	
	@GetMapping("/write")
	public String write() {
		return "board/write";
	}
	
	@PostMapping("/writePro")
	public String writePro(BoardDTO boardDTO, MultipartHttpServletRequest mtfRequest) {
		
		// boardNum 자동생성
				// = FR + yyMMddHHmmss
				Date now = new Date();
			    SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMddHHmmss");
			    String formattedDate = dateFormat.format(now);
			    String boardNum = "FR" + formattedDate;
			    boardDTO.setBoardNum(boardNum);
		
	    // 파일 업로드 로직
	    List<MultipartFile> fileList = mtfRequest.getFiles("file");
	    String path = "C:\\Users\\sonmi\\git\\Family\\Family\\Family\\src\\main\\webapp\\resources\\img\\";
	    
	    // 게시글 작성 로직
	    boardService.writePro(boardDTO);
	    
	    for (MultipartFile mf : fileList) {
	        String originFileName = mf.getOriginalFilename(); // 원본 파일 명
	        long fileSize = mf.getSize(); // 파일 사이즈

	        System.out.println("originFileName : " + originFileName);
	        System.out.println("fileSize : " + fileSize);

	        String safeFile = path + originFileName;
	        try {
	            mf.transferTo(new File(safeFile));
	            String filePath = originFileName;
	            boardService.addFilePath(boardNum, filePath); // 파일 경로 추가
	            System.out.println(originFileName);
//	            boardDTO.setFilePath(originFileName); // 파일 경로 설정
//	            System.out.println(boardDTO.getFilePath());
	        } catch (IllegalStateException e) {
	            e.printStackTrace();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
	    return "redirect:/board/freeboard";
	}
	
	@PostMapping("/writePro2")
	public String writePro2(BoardDTO boardDTO2) {
	    boardService.writePro2(boardDTO2);
	    return "redirect:/board/detail?boardNum=" + boardDTO2.getBoardNum();
	}
		
}
