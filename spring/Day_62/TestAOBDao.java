package com.spring.sample.web.tests.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TestAOBDao implements ITestAOBDao {

	@Autowired
	public SqlSession sqlSession;
	
	@Override
	public HashMap<String, String> getM(HashMap<String, String> params) throws Throwable {

		return sqlSession.selectOne("A.getM", params);
	}

	@Override
	public int getOBCnt(HashMap<String, String> params) throws Throwable {

		return sqlSession.selectOne("A.getOBCnt", params);
	}

	@Override
	public List<HashMap<String, String>> getOBList(HashMap<String, String> params) throws Throwable {

		return sqlSession.selectList("A.getOBList", params);
	}

	@Override
	public int writeOB(HashMap<String, String> params) throws Throwable {
		return sqlSession.insert("A.writeOB", params);
	}

}
