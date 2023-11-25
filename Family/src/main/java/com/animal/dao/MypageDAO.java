package com.animal.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.animal.domain.MemberDTO;

@Repository
public class MypageDAO {
	
	@Inject
	private SqlSession sqlSession;
	private static final String namespace="com.animal.mappers.MypageMapper";
	
	public MemberDTO getMyProfile(String id) {
		return sqlSession.selectOne(namespace+".getMyProfile", id);
	}

	public void changePhoto(MemberDTO memberDTO) {
		System.out.println("MypageDAO");
		sqlSession.update(namespace+".changePhoto", memberDTO);
	}

}
