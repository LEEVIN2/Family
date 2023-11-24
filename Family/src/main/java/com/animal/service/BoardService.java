package com.animal.service;

import java.util.List;

import javax.inject.Inject;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import org.springframework.stereotype.Service;

import com.animal.dao.BoardDAO;
import com.animal.domain.BoardDTO;


@Service
public class BoardService {
	
	// BoardDAO 객체생성
	@Inject
	private BoardDAO boardDAO;

	public void writePro(BoardDTO boardDTO) {
		// 작성시간표시
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String submitTime = sdf.format(timestamp);
		boardDTO.setSubmitTime(submitTime);
        
		boardDAO.writePro(boardDTO);
	}

	public List<BoardDTO> getBoardList(BoardDTO boardDTO) {
//		페이징
		int startRow = (boardDTO.getCurrentPage()-1)*boardDTO.getPageSize() + 1;
        int endRow = startRow + boardDTO.getPageSize() - 1;
        boardDTO.setStartRow(startRow - 1);
        boardDTO.setEndRow(endRow);
		return boardDAO.getBoardList(boardDTO);
	}
	
	public List<BoardDTO> getBoardHotList(BoardDTO boardDTO) {
		return boardDAO.getBoardHotList(boardDTO);
	}

	public BoardDTO getDetail(String boardNum) {
	    return boardDAO.getDetail(boardNum);
	}

	public List<String> getFilePaths(String boardNum) {
	    return boardDAO.getFilePaths(boardNum);
	}
	
	public List<BoardDTO> getCommentList(String boardNum) {
		return boardDAO.getCommentList(boardNum);
	}

	public void addFilePath(String boardNum, String filePath) {
		boardDAO.addFilePath(boardNum, filePath);
		
	}

	public void writePro2(BoardDTO boardDTO2) {
		// 작성시간표시
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String submitTime = sdf.format(timestamp);
		boardDTO2.setSubmitTime(submitTime);
		boardDAO.writePro2(boardDTO2);
	}

	public void increaseViewCnt(String boardNum) {
		 boardDAO.increaseViewCnt(boardNum);
	}

	public Object findLike(String boardNum, String id) {
		return  boardDAO.findLike(boardNum, id);
	}
	
	public int findLikeCnt(String boardNum) {
		return  boardDAO.findLikeCnt(boardNum);
	}


	public void likeUp(BoardDTO boardDTO) {
		// 작성시간표시
				Timestamp timestamp = new Timestamp(System.currentTimeMillis());
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String submitTime = sdf.format(timestamp);
				boardDTO.setSubmitTime(submitTime);
		boardDAO.likeUp(boardDTO);
	}

	public void likeDown(BoardDTO boardDTO) {
		boardDAO.likeDown(boardDTO);
	}

	public List<BoardDTO> getFreesearchList(BoardDTO boardDTO) {
		return boardDAO.getFreesearchList(boardDTO);
	}

	public int getFreeboardCount(BoardDTO boardDTO) {
		return boardDAO.getFreeboardCount(boardDTO);
	}

	public List<BoardDTO> getWrittenList(BoardDTO boardDTO) {
	    return boardDAO.getWrittenList(boardDTO);
	}

	public List<BoardDTO> getWrittenList2(BoardDTO boardDTO) {
		return boardDAO.getWrittenList2(boardDTO);
	}

	public List<BoardDTO> getBoardBestList(BoardDTO boardDTO) {
		return boardDAO.getBoardBestList(boardDTO);
	}

	public List<BoardDTO> getBoardPopList(BoardDTO boardDTO) {
		return boardDAO.getBoardPopList(boardDTO);
	}

	public List<BoardDTO> getBoardNewList(BoardDTO boardDTO) {
		return boardDAO.getBoardNewList(boardDTO);
	}
	
	// 무한스크롤
	public List<BoardDTO> getLoadMoreData(BoardDTO boardDTO) {
	    return boardDAO.getLoadMoreData(boardDTO);
	}


}
