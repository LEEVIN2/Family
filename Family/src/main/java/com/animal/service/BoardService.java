package com.animal.service;

import java.time.LocalDateTime;
import java.util.List;

import javax.inject.Inject;
import java.sql.Timestamp;

import org.springframework.stereotype.Service;

import com.animal.dao.BoardDAO;
import com.animal.domain.BoardDTO;


@Service
public class BoardService {
	
	// BoardDAO 객체생성
	@Inject
	private BoardDAO boardDAO;

	public void writePro(BoardDTO boardDTO) {
//		작성시간표시
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		LocalDateTime submitTime = timestamp.toLocalDateTime();
		boardDTO.setSubmitTime(submitTime);

        
		boardDAO.writePro(boardDTO);
	}

	public List<BoardDTO> getBoardList() {
		return boardDAO.getBoardList();
	}

}
