package com.spring.sample.web.tests.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TestSEDao implements ITestSEDao {

	@Autowired
	public SqlSession sqlSession;

	@Override
	public int getSECnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("SELL.getSECnt", params);
	}

	@Override
	public List<HashMap<String, String>> getSEList(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("SELL.getSEList", params);
	}

	@Override
	public int addSE(HashMap<String, String> params) throws Throwable {

		return sqlSession.insert("SELL.addSE", params);
	}

	@Override
	public HashMap<String, String> getSE(HashMap<String, String> params) throws Throwable {

		return sqlSession.selectOne("SELL.getSE", params);
	}
}
