package com.animal.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.animal.dao.NoticeDAO;
import com.animal.domain.BoardDTO;

@Service
public class NoticeService {
	
	@Inject
	private NoticeDAO noticeDAO;
	
	public List<BoardDTO> getCommentList(BoardDTO boardDTO) {
		return noticeDAO.getCommentList(boardDTO);
	}

	public List<BoardDTO> getLikeList(BoardDTO boardDTO) {
		return noticeDAO.getLikeList(boardDTO);
	}

	public void updateRead(BoardDTO boardDTO) {
		noticeDAO.updateRead(boardDTO);
	}

	public List<BoardDTO> getPopularList() {
		return noticeDAO.getPopularList();
	}

	public List<BoardDTO> getBestList() {
		return noticeDAO.getBestList();
	}

	public void delete(BoardDTO boardDTO) {
		noticeDAO.delete(boardDTO);
	}

}
