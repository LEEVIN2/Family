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
	
	public List<BoardDTO> getNoticeList(BoardDTO boardDTO) {
		return noticeDAO.getNoticeList(boardDTO);
	}

}
