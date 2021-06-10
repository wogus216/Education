package com.spring.sample.web.test.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sample.web.test.dao.ITestLDao;

@Service
public class TestLService implements ITestLService {

	@Autowired
	public ITestLDao iTestLDao;

	@Override
	public HashMap<String, String> getM(HashMap<String, String> params) throws Throwable {
		return iTestLDao.getM(params);
	}

	@Override
	public int writeOb(HashMap<String, String> params) throws Throwable {
		return iTestLDao.writeOb(params);
	}

	@Override
	public int getObCnt(HashMap<String, String> params) throws Throwable {
		return iTestLDao.getObCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getObList(HashMap<String, String> params) throws Throwable {
		return iTestLDao.getObList(params);
	}

	@Override
	public int updateOb(HashMap<String, String> params) throws Throwable {
		return iTestLDao.updateOb(params);
	}

	@Override
	public int deleteOb(HashMap<String, String> params) throws Throwable {
		return iTestLDao.deleteOb(params);
	}
}
