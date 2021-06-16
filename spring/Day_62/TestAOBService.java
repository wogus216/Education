package com.spring.sample.web.tests.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sample.web.tests.dao.ITestAOBDao;

@Service
public class TestAOBService implements ITestAOBService {

	@Autowired
	public ITestAOBDao iTestAOBDao;
	
	@Override
	public HashMap<String, String> getM(HashMap<String, String> params) throws Throwable {
	
		return iTestAOBDao.getM(params);
	}

	@Override
	public int getOBCnt(HashMap<String, String> params) throws Throwable {

		return iTestAOBDao.getOBCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getOBList(HashMap<String, String> params) throws Throwable {

		return iTestAOBDao.getOBList(params);
	}

	@Override
	public int writeOB(HashMap<String, String> params) throws Throwable {
		return iTestAOBDao.writeOB(params);
	}

}
