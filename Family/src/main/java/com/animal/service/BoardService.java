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

	public List<BoardDTO> getBoardList() {
		return boardDAO.getBoardList();
	}

}
