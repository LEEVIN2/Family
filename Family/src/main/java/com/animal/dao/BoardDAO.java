package com.animal.dao;

@Repository
public class BoardDAO {
	
	@Inject
	private SqlSession sqlSession;
	private static final String namespace="com.animal.mappers.BoardMapper";
	
}
