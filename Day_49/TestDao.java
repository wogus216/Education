package com.spring.sample.web.test.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//저장소에 접근한다.
@Repository
public class TestDao implements ITestDao {
	
	@Autowired
	public SqlSession sqlSession;
}
