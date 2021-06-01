package com.spring.sample.web.test.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//저장소에 접근한다.
@Repository
public class TestDao implements ITestDao {

	@Autowired
	public SqlSession sqlSession;

	@Override
	public List<HashMap<String, String>> getBList() throws Throwable {
		
		return sqlSession.selectList("B.getBList");
	}

	@Override
	public List<HashMap<String, String>> getMList() throws Throwable {

		return sqlSession.selectList("M.getMList");
	}

	@Override
	public HashMap<String, String> getB(HashMap<String, String> params) throws Throwable {
	
		return null;
	}
	
}
