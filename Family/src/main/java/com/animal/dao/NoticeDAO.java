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
	
	public List<BoardDTO> getCommentList(BoardDTO boardDTO) {
		return sqlSession.selectList(namespace+".getCommentList", boardDTO);
	}

	public List<BoardDTO> getLikeList(BoardDTO boardDTO) {
		return sqlSession.selectList(namespace+".getLikeList", boardDTO);
	}
	
	public void updateRead(BoardDTO boardDTO) {
	    sqlSession.update(namespace+".updateReadComment", boardDTO);
	    sqlSession.update(namespace+".updateReadBoardLike", boardDTO);
	}

	public List<BoardDTO> getPopularList() {
		return sqlSession.selectList(namespace+".getPopularList");
	}

	public List<BoardDTO> getBestList() {
		return sqlSession.selectList(namespace+".getBestList");
	}

	public void delete(BoardDTO boardDTO) {
		sqlSession.update(namespace+".delete", boardDTO);
	}


}
