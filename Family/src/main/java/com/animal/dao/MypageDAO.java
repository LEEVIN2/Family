package com.animal.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class MypageDAO {
	@Inject
	private SqlSession sqlSession;
	private static final String namespace="com.animal.mappers.MypageMapper";

}