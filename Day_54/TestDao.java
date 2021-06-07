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
	public List<HashMap<String, String>> getBList(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectList("B.getBList", params);
	}

	@Override
	public HashMap<String, String> getB(HashMap<String, String> params) throws Throwable {
		//단일row selectOne
		return sqlSession.selectOne("B.getB",params);
	}

	@Override
	public int addB(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.insert("B.addB",params);
	}

	@Override
	public int updateB(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return sqlSession.update("B.updateB", params);
	}

	@Override
	public int deleteB(HashMap<String, String> params) throws Throwable {
		return sqlSession.delete("B.deleteB", params);
	}

	@Override
	public int getBCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("B.getBcnt", params);
	}
	
}
