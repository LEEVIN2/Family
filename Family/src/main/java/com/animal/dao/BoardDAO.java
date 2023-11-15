package com.animal.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.RowBounds;
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
		return sqlSession.selectList(namespace+".getBoardList", boardDTO);
	}
	
//	스프링 메퍼에서는 LIMIT 1 구문이 직접적으로 적용되지 않습니다. 대신, 스프링 메퍼에서 제공하는 RowBounds 객체를 사용하여 특정 개수의 결과를 제한할 수 있습니다.
//	SQL 쿼리가 변경되지 않으므로 데이터베이스에 따라 성능에 영향을 줄 수 있습니다. 따라서 대량의 데이터를 처리할 때는 적절한 방법을 고려해야 합니다.
	public List<BoardDTO> getBoardHotList(BoardDTO boardDTO) {
	    return sqlSession.selectList(namespace+".getBoardHotList", boardDTO, new RowBounds(0, 1));
	}
	
	public List<BoardDTO> getCommentList(String boardNum) {
		return sqlSession.selectList(namespace+".getCommentList", boardNum);
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

	public Object findLike(String boardNum, String id) {
	    Map<String, String> params = new HashMap<String, String>();
	    params.put("boardNum", boardNum);
	    params.put("id", id);
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
		return sqlSession.selectList(namespace+".getFreesearchList", boardDTO);
	}

	public int getFreeboardCount(BoardDTO boardDTO) {
		return sqlSession.selectOne(namespace+".getFreeboardCount",boardDTO);
    }

	public List<BoardDTO> getWrittenList(BoardDTO boardDTO) {
		return sqlSession.selectList(namespace+".getWrittenList", boardDTO);
	}

	public List<BoardDTO> getWrittenList2(BoardDTO boardDTO) {
		return sqlSession.selectList(namespace+".getWrittenList2", boardDTO);
	}

	public List<BoardDTO> getBoardBestList(BoardDTO boardDTO) {
		return sqlSession.selectList(namespace+".getBoardBestList", boardDTO);
	}

	public List<BoardDTO> getBoardPopList(BoardDTO boardDTO) {
		return sqlSession.selectList(namespace+".getBoardHotList", boardDTO);
	}

	

	
}
