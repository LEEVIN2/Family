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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	// 사진파일경로 (서블릿에서 가져오는거임)
	@Autowired
    private String uploadPath;
	
	@GetMapping("/home")
	public String home(Model model) {
		BoardDTO boardDTO =new BoardDTO();
		List<BoardDTO> boardNewList = boardService.getBoardNewList(boardDTO);
		List<BoardDTO> boardPopList = boardService.getBoardPopList(boardDTO);
		
		for (BoardDTO boardDTO2 : boardNewList) {
		    updateSubmitTime(boardDTO2);
		}
		
		for (BoardDTO boardDTO2 : boardPopList) {
		    updateSubmitTime(boardDTO2);
		}
		
		model.addAttribute("boardNewList", boardNewList);
		model.addAttribute("boardPopList", boardPopList);
		return "board/home";
	}
	
	// 무한스크롤
	@PostMapping("/loadMoreData")
	@ResponseBody
	public List<BoardDTO> loadMoreData(@RequestParam("start") int start, @RequestParam("limit") int limit) {
//	    System.out.println(start);
//	    System.out.println(limit);
	    
	    BoardDTO boardDTO = new BoardDTO();
	    boardDTO.setStart(start);
	    boardDTO.setLimit(limit);
	    
//	    System.out.println(boardDTO);
	    
	    List<BoardDTO> loadMoreData = boardService.getLoadMoreData(boardDTO);
//	    System.out.println(loadMoreData);
	    
	    for (BoardDTO boardDTO2 : loadMoreData) {
		    updateSubmitTime(boardDTO2);
		}
	    
//	    서버에서 클라이언트로 데이터를 반환하는 것을 의미합니다. 이 경우 클라이언트는 웹 브라우저에서 실행되는 JavaScript 코드
//	    즉 컨트롤러에서 loadMoreData를 요청한 jsp 파일로  loadMoreData 리스트 값이 자동적으로 전송된다
	    return loadMoreData;
	}
	
	@GetMapping("/board")
	public String board() {
		return "board/board";
	}
	
	@GetMapping("/bestboard")
	public String bestboard(Model model) {
		BoardDTO boardDTO =new BoardDTO();
		List<BoardDTO> boardBestList = boardService.getBoardBestList(boardDTO);
		model.addAttribute("boardBestList", boardBestList);
		return "board/bestboard";
	}
	
	@GetMapping("/popularboard")
	public String popularboard(Model model) {
		BoardDTO boardDTO =new BoardDTO();
		List<BoardDTO> boardPopList = boardService.getBoardPopList(boardDTO);
		model.addAttribute("boardPopList", boardPopList);
		return "board/popularboard";
	}
	
	@GetMapping("/written")
	public String written(HttpSession session, Model model) {
		
		String id = (String) session.getAttribute("id");
		
		BoardDTO boardDTO =new BoardDTO();
		boardDTO.setId(id);
		
		List<BoardDTO> writtenList = boardService.getWrittenList(boardDTO);
		
		model.addAttribute("writtenList", writtenList);
		return "board/written";
	}
	
	@GetMapping("/written2")
	public String written2(HttpSession session, Model model) {
		
		String id = (String) session.getAttribute("id");
		
		BoardDTO boardDTO =new BoardDTO();
		boardDTO.setId(id);
		
		List<BoardDTO> writtenList2 = boardService.getWrittenList2(boardDTO);
		
		model.addAttribute("writtenList2", writtenList2);
		return "board/written2";
	}
	
	@GetMapping("/freeboard")
	public String freeboard(HttpServletRequest request, HttpSession session, Model model) {

//		페이징
//		int pageSize = 3; //한 페이지에 표시할 게시물의 수
//	    String pageNum=request.getParameter("pageNum");
//	    if(pageNum == null) {
//	    	pageNum = "1";
//	    }
//	    
//	    int currentPage = Integer.parseInt(pageNum); //현재 사용자가 보고 있는 페이지 번호
	    BoardDTO boardDTO =new BoardDTO();
//	    boardDTO.setPageSize(pageSize);
//	    boardDTO.setPageNum(pageNum);
//	    boardDTO.setCurrentPage(currentPage);
//	    
//	    int count = boardService.getFreeboardCount(boardDTO);
//	    int pageBlock = 5; //네비게이션 바에 표시할 페이지 번호의 수 6페이지를 보고 있다면 네비게이션 바에는 6, 7, 8, 9, 10 페이지 번호가 표시됩니다.
//	    int startPage=(currentPage-1)/pageBlock*pageBlock+1;
//	    int endPage = startPage + pageBlock -1;
//	    int pageCount = count/pageSize+(count%pageSize==0?0:1);
//	    if(endPage > pageCount) {
//	    	endPage = pageCount;
//	    }
//	    
//	    boardDTO.setCount(count);
//	    boardDTO.setPageBlock(pageBlock);
//	    boardDTO.setStartPage(startPage);
//	    boardDTO.setEndPage(endPage);
//	    boardDTO.setPageCount(pageCount);
//	    model.addAttribute("boardDTO", boardDTO);
//	    
//	    // 현재 페이지 값 가져와서 detail에서 다시 freeboard 페이지로 올때 2페이지 유지하려고 만듬
//	    session.setAttribute("currentPage", currentPage);
	    
//	    표시
List<BoardDTO> boardList = boardService.getBoardList(boardDTO);
List<BoardDTO> boardHotList = boardService.getBoardHotList(boardDTO);

for (BoardDTO boardDTO2 : boardList) {
    updateSubmitTime(boardDTO2);
}

for (BoardDTO boardDTO2 : boardHotList) {
    updateSubmitTime(boardDTO2);
}
		
		model.addAttribute("boardList", boardList);
		model.addAttribute("boardHotList", boardHotList);
		return "board/freeboard";
	}
	
	public void updateSubmitTime(BoardDTO boardDTO2) {
	    String submitTime = boardDTO2.getSubmitTime();
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	    LocalDateTime submitDateTime = LocalDateTime.parse(submitTime, formatter);
	    LocalDateTime now = LocalDateTime.now();
	    long minutesBetween = ChronoUnit.MINUTES.between(submitDateTime, now);
	    long hoursBetween = ChronoUnit.HOURS.between(submitDateTime, now);
	    long daysBetween = ChronoUnit.DAYS.between(submitDateTime, now);

	    if (minutesBetween < 1) {
	        boardDTO2.setSubmitTime("방금");
	    } else if (minutesBetween < 60) {
	        boardDTO2.setSubmitTime(minutesBetween + "분");
	    } else if (hoursBetween < 24) {
	        boardDTO2.setSubmitTime(hoursBetween + "시간");
	    } else {
	        boardDTO2.setSubmitTime(daysBetween + "일");
	    }
	}
	
	@GetMapping("/freesearch")
	public String freesearch(HttpServletRequest request,Model model) {
		
		String search = request.getParameter("search");
		
		BoardDTO boardDTO =new BoardDTO();
		boardDTO.setSearch(search); // 검색어저장
		
		// 품목추가한 내용 뿌려주기
	    List<BoardDTO> boardList= boardService.getFreesearchList(boardDTO);
	    
	    for (BoardDTO boardDTO2 : boardList) {
	        updateSubmitTime(boardDTO2);
	    }
		
	 // 품목추가한 내용 뿌려주기
	    model.addAttribute("boardList", boardList);
		
		return "board/freesearch";
	}
	
	@GetMapping("/search")
	public String search(HttpServletRequest request,Model model) {
		
		String search = request.getParameter("search");
		
		BoardDTO boardDTO =new BoardDTO();
		boardDTO.setSearch(search); // 검색어저장
		
		// 품목추가한 내용 뿌려주기
	    List<BoardDTO> boardList= boardService.getSearchList(boardDTO);
	    
	    for (BoardDTO boardDTO2 : boardList) {
	        updateSubmitTime(boardDTO2);
	    }
		
	 // 품목추가한 내용 뿌려주기
	    model.addAttribute("boardList", boardList);
		
		return "board/search";
	}
	

	
	@GetMapping("/detail")
	public String detail(HttpServletRequest request, HttpSession session, Model model) {
		//boardNum에 해당하는 board + board_file 내용 가져오기
		String boardNum = request.getParameter("boardNum");
	    BoardDTO boardDTO = boardService.getDetail(boardNum);
	    List<String> filePaths = boardService.getFilePaths(boardNum);
	    updateSubmitTime(boardDTO);
	    
//	    // 댓글 내용 뿌려주기
//	    List<BoardDTO> commentList = boardService.getCommentList();
	    
//	    for (BoardDTO boardDTO2 : commentList) {
//	        updateSubmitTime(boardDTO2);
//	    }
	    
	    // 조회수 증가 로직
	    // 게시글 작성자 닉네임
	    String currentBoardNum = boardDTO.getBoardNum();
	    String currentId = boardDTO.getId();
	    // 세션에서 이전에 클릭한 닉네임 가져오기
	    String sessionBoardNum = (String) session.getAttribute("boardNum");
	    String sessionId = (String) session.getAttribute("id");

	    // 세션에 저장된 닉네임이 없거나, 현재 닉네임과 세션에 저장된 닉네임이 다르면 조회수 증가
//	    if (sessionBoardNum == null || !sessionBoardNum.equals(currentBoardNum) && !sessionId.equals(currentId))
	    // 조회수는 어떤 조건에서 올라가게 할건지 나중에 다시 상의...해보고
	    if (sessionBoardNum == null || !sessionBoardNum.equals(currentBoardNum) || sessionId == null || !sessionId.equals(currentId)) {
	        boardService.increaseViewCnt(boardNum);
	        session.setAttribute("boardNum", currentBoardNum);	        
	    }

	    
	    // 내 좋아요 로직
	    // 이건 작성자 닉네임이고
//	    String id = request.getParameter("id");
	    // 이게 내 닉네임
	    String id = (String) session.getAttribute("id");
	    int board_like = (int) boardService.findLike(boardNum, id);
	    model.addAttribute("board_like", board_like);
	    
	    // 전체 좋아요 로직
	    int board_likeCnt = (int) boardService.findLikeCnt(boardNum);
	    model.addAttribute("board_likeCnt", board_likeCnt);
	    
	    
	    model.addAttribute("boardDTO", boardDTO);
	    model.addAttribute("filePaths", filePaths);
//	    model.addAttribute("commentList", commentList);
	    
	    return "board/detail";
	}
	

	
	
	@GetMapping("/comments")
    public ResponseEntity<List<BoardDTO>> comments(@RequestParam String boardNum) {
		System.out.println("여기가지 도착");
        List<BoardDTO> commentList = boardService.getCommentList(boardNum);
        
        for (BoardDTO boardDTO2 : commentList) {
	        updateSubmitTime(boardDTO2);
	    }
        System.out.println(commentList);
        return ResponseEntity.ok(commentList);
    }
	
	
	@PostMapping("/likeUp")
	public ResponseEntity<String> likeUp(@RequestParam String boardNum, @RequestParam String id) {
	    BoardDTO boardDTO = new BoardDTO();
	    boardDTO.setBoardNum(boardNum);
	    boardDTO.setId(id);

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
	public ResponseEntity<String> likeDown(@RequestParam String boardNum, @RequestParam String id) {
	    BoardDTO boardDTO = new BoardDTO();
	    boardDTO.setBoardNum(boardNum);
	    boardDTO.setId(id);

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
	    
	    // 게시글 작성 로직
	    boardService.writePro(boardDTO);
	    
	    for (MultipartFile mf : fileList) {
	        String originFileName = mf.getOriginalFilename(); // 원본 파일 명
	        long fileSize = mf.getSize(); // 파일 사이즈

	        System.out.println("originFileName : " + originFileName);
	        System.out.println("fileSize : " + fileSize);

	        String safeFile = uploadPath + "\\" + originFileName;
            System.out.println(safeFile);
	        try {
	            mf.transferTo(new File(safeFile));
	            String filePath = originFileName;
	            boardService.addFilePath(boardNum, filePath); // 파일 경로 추가
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
		// boardNum 자동생성
		// = FR + yyMMddHHmmss
		Date now = new Date();
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yyMMddHHmmss");
	    String formattedDate = dateFormat.format(now);
	    String commentNum = "FR" + formattedDate;
	    boardDTO2.setCommentNum(commentNum);
	    
	    boardService.writePro2(boardDTO2);
	    return "redirect:/board/detail?boardNum=" + boardDTO2.getBoardNum();
	}
	
	@GetMapping("/deleteBoard")
	public String deleteBoard(HttpServletRequest request) {
		String boardNum = request.getParameter("boardNum");
		String id = request.getParameter("id");

		BoardDTO boardDTO = new BoardDTO();
	    boardDTO.setBoardNum(boardNum);
	    boardDTO.setId(id);
	    
		boardService.deleteBoard(boardDTO);
		return "redirect:/board/freeboard";
	}
		
}
