package com.animal.dao;

import java.util.HashMap;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Repository;

import com.animal.domain.MemberDTO;

@Repository
public class MemberDAO {
	@Inject
	private SqlSession sqlSession;
	private static final String namespace="com.animal.mappers.MemberMapper";
	
	public void join(MemberDTO memberDTO) {
		sqlSession.insert(namespace+".join", memberDTO);
	}

	public MemberDTO checklogin(MemberDTO memberDTO) {
		return sqlSession.selectOne(namespace+".checklogin", memberDTO);
	}

	public void join2(JSONObject response_obj) {
		sqlSession.insert(namespace+".join2", response_obj);
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

	public MemberDTO checkemail(MemberDTO memberDTO) {
		return sqlSession.selectOne(namespace+".checkemail", memberDTO);
	}

	public MemberDTO checkmobile(MemberDTO memberDTO) {
		return sqlSession.selectOne(namespace+".checkmobile", memberDTO);
	}

	public MemberDTO checkid(MemberDTO memberDTO) {
		return sqlSession.selectOne(namespace+".checkid", memberDTO);
	}

	public MemberDTO checkeidmail(MemberDTO memberDTO) {
		return sqlSession.selectOne(namespace+".checkeidmail", memberDTO);
	}

	public void findpassPro(MemberDTO memberDTO) {
		sqlSession.update(namespace+".findpassPro", memberDTO);
	}

	public MemberDTO checkeidmobile(MemberDTO memberDTO) {
		return sqlSession.selectOne(namespace+".checkeidmobile", memberDTO);
	}

	public void join3(HashMap<String, Object> userInfo) {
		sqlSession.insert(namespace+".join3", userInfo);
	}





	

}
