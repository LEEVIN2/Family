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
		System.out.println("getBoardList 서비스");
//		페이징
		int startRow = (boardDTO.getCurrentPage()-1)*boardDTO.getPageSize() + 1;
        int endRow = startRow + boardDTO.getPageSize() - 1;
        boardDTO.setStartRow(startRow - 1);
        boardDTO.setEndRow(endRow);
		return boardDAO.getBoardList(boardDTO);
	}

	public BoardDTO getDetail(String boardNum) {
	    return boardDAO.getDetail(boardNum);
	}

	public List<String> getFilePaths(String boardNum) {
	    return boardDAO.getFilePaths(boardNum);
	}
	
	public List<BoardDTO> getCommentList() {
		return boardDAO.getCommentList();
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

	public Object findLike(String boardNum, String nickname) {
		return  boardDAO.findLike(boardNum, nickname);
	}
	
	public int findLikeCnt(String boardNum) {
		return  boardDAO.findLikeCnt(boardNum);
	}


	public void likeUp(BoardDTO boardDTO) {
		boardDAO.likeUp(boardDTO);
	}

	public void likeDown(BoardDTO boardDTO) {
		boardDAO.likeDown(boardDTO);
	}

	public List<BoardDTO> getFreesearchList(BoardDTO boardDTO) {
		return boardDAO.getFreesearchList(boardDTO);
	}

	public int getFreeboardCount(BoardDTO boardDTO) {
		System.out.println("getFreeboardCount 서비스");
		return boardDAO.getFreeboardCount(boardDTO);
	}

	

	

}
