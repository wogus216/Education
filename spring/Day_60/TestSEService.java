package com.spring.sample.web.tests.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sample.web.tests.dao.ITestSEDao;

@Service
public class TestSEService implements ITestSEService {

	@Autowired
	ITestSEDao iTestSEDao;
	
	@Override
	public int getSECnt(HashMap<String, String> params) throws Throwable {
		return iTestSEDao.getSECnt(params);
	}

	@Override
	public List<HashMap<String, String>> getSEList(HashMap<String, String> params) throws Throwable {
	
		return iTestSEDao.getSEList(params);
	}

	@Override
	public int addSE(HashMap<String, String> params) throws Throwable {
		return iTestSEDao.addSE(params);
	}

	@Override
	public HashMap<String, String> getSE(HashMap<String, String> params) throws Throwable {
		return iTestSEDao.getSE(params);
	}

}
