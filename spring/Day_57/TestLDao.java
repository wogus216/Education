package com.spring.sample.web.test.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TestLDao implements ITestLDao {

	@Autowired
	public SqlSession sqlSession;

	@Override
	public HashMap<String, String> getM(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectOne("L.getM",params);
	}

	@Override
	public int writeOb(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.insert("L.writeOb", params);
	}

	@Override
	public int getObCnt(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectOne("L.getObCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getObList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("L.getObList", params);
	}

	@Override
	public int updateOb(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("L.updateOb", params);
	}
}
