package com.spring.sample.web.tests.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sample.web.tests.dao.kjhITestSEDao;

@Service
public class kjhTestSEService implements kjhITestSEService {

	@Autowired
	public kjhITestSEDao iTestSEDao;
	
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

	@Override
	public int updateSE(HashMap<String, String> params) throws Throwable {
		return iTestSEDao.updateSE(params);
	}

	@Override
	public int deleteSE(HashMap<String, String> params) throws Throwable {
		return iTestSEDao.deleteSE(params);
	}

}
