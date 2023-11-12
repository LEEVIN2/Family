package com.animal.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.animal.domain.BoardDTO;

@Repository
public class NoticeDAO {
	
	@Inject
	private SqlSession sqlSession;
	private static final String namespace="com.animal.mappers.NoticeMapper";
	
	public List<BoardDTO> getNoticeList(BoardDTO boardDTO) {
		return sqlSession.selectList(namespace+".getNoticeList", boardDTO);
	}

}
