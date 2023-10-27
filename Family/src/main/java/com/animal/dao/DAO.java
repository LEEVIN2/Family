package com.animal.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
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

}
