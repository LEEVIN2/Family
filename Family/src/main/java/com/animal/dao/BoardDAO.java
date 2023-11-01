package com.animal.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.animal.domain.BoardDTO;

@Repository
public class BoardDAO {
	
	@Inject
	private SqlSession sqlSession;
	private static final String namespace="com.animal.mappers.BoardMapper";
	
	public void writePro(BoardDTO boardDTO) {
		sqlSession.insert(namespace+".writePro", boardDTO);
	}

	public List<BoardDTO> getBoardList() {
		return sqlSession.selectList(namespace+".getBoardList");
	}
	
}
