package com.animal.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import com.animal.domain.DTO;

@Repository
public class DAO {
	@Inject
	private SqlSession sqlSession;
	private static final String namespace="com.animal.mappers.Mapper";
	
	public void insert(DTO DTO) {
		sqlSession.insert(namespace+".insert", DTO);
	}

	public DTO checklogin(DTO dTO) {
		return sqlSession.selectOne(namespace+".checklogin", dTO);
	}

	public void insert2(JSONObject response_obj) {
		sqlSession.insert(namespace+".insert2", response_obj);
	}

	public boolean isUserExist(String nickname) {
		// 쿼리 실행
	    Integer count = sqlSession.selectOne(namespace+".isUserExist", nickname);

	    // 결과 확인
	    if (count != null && count > 0) {
	        return true;  // 사용자가 이미 존재함
	    } else {
	        return false;  // 사용자가 존재하지 않음
	    }
	}



	

}
