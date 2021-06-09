package com.spring.sample.web.test.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TestLDao implements ITestLDao {

	@Autowired
	public SqlSession sqlSession;

	@Override
	public HashMap<String, String> getM(HashMap<String, String> params) throws Throwable {

		return sqlSession.selectOne("L.getM", params);
	}
}
