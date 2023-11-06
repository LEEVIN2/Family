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

	public List<BoardDTO> getBoardList(BoardDTO boardDTO) {
		System.out.println("getBoardList dao");
		return sqlSession.selectList(namespace+".getBoardList", boardDTO);
	}
	
	public List<BoardDTO> getCommentList() {
		return sqlSession.selectList(namespace+".getCommentList");
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

	public void writePro2(BoardDTO boardDTO2) {
		sqlSession.insert(namespace+".writePro2", boardDTO2);
	}

	public void increaseViewCnt(String boardNum) {
		 sqlSession.update(namespace+".increaseViewCnt", boardNum);
	}

	public Object findLike(String boardNum, String nickname) {
	    Map<String, String> params = new HashMap<String, String>();
	    params.put("boardNum", boardNum);
	    params.put("nickname", nickname);
	    return sqlSession.selectOne(namespace+".findLike", params);
	}
	
	public int findLikeCnt(String boardNum) {
		return sqlSession.selectOne(namespace+".findLikeCnt", boardNum);
	}

	public void likeUp(BoardDTO boardDTO) {
		sqlSession.insert(namespace+".likeUp", boardDTO);
	}

	public void likeDown(BoardDTO boardDTO) {
		sqlSession.delete(namespace+".likeDown", boardDTO);
	}

	public List<BoardDTO> getFreesearchList(BoardDTO boardDTO) {
		System.out.println("getFreesearchList dao");
		return sqlSession.selectList(namespace+".getFreesearchList", boardDTO);
	}

	public int getFreeboardCount(BoardDTO boardDTO) {
		System.out.println("getFreeboardCount dao");
		return sqlSession.selectOne(namespace+".getFreeboardCount",boardDTO);
    }

	
}
