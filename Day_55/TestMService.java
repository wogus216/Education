package com.spring.sample.web.test.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sample.web.test.dao.ITestMDao;

@Service
public class TestMService implements ITestMService {
	
	@Autowired
	public ITestMDao iTestMDao;
	
	@Override
	public List<HashMap<String, String>> getMList(HashMap<String, String> params) throws Throwable {
		
		return iTestMDao.getMList(params);
	}

	@Override
	public HashMap<String, String> getM(HashMap<String, String> params) throws Throwable {
		
		return iTestMDao.getM(params);
	}

	@Override
	public int addM(HashMap<String, String> params) throws Throwable {
		return iTestMDao.addM(params);
	}

	@Override
	public int updateM(HashMap<String, String> params) throws Throwable {
		return iTestMDao.updateM(params);
	}

	@Override
	public int deleteM(HashMap<String, String> params) throws Throwable {
		return iTestMDao.deleteM(params);
	}


	@Override
	public int getMCnt(HashMap<String, String> params) throws Throwable {
		return iTestMDao.getMCnt(params);
	}

}
