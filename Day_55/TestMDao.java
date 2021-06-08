package com.spring.sample.web.test.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TestMDao implements ITestMDao {

	@Autowired
	public SqlSession sqlSession;
	
	@Override
	public List<HashMap<String, String>> getMList(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectList("M.getMList",params);
	}

	@Override
	public HashMap<String, String> getM(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectOne("M.getM", params);
	}

	@Override
	public int addM(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.insert("M.addM", params);
	}

	@Override
	public int updateM(HashMap<String, String> params) throws Throwable {
		return sqlSession.update("M.updateM", params);
	}

	@Override
	public int deleteM(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("M.deleteM", params);
	}

	@Override
	public int getMCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("M.getMCnt",params);
	}

}
