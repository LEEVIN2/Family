package com.animal.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	public BoardDTO getDetail(String boardNum) {
	    return sqlSession.selectOne(namespace+".getDetail", boardNum);
	}

	public List<String> getFilePaths(String boardNum) {
	    return sqlSession.selectList(namespace+".getFilePaths", boardNum);
	}


	public void addFilePath(String boardNum, String filePath) {
		Map<String, Object> params = new HashMap<>();
        params.put("boardNum", boardNum);
        params.put("filePath", filePath);
        sqlSession.insert(namespace+".addFilePath", params);
		
	}
	
}
