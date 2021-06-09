package com.spring.sample.web.test.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sample.web.test.dao.ITestDao;

@Service
public class TestService implements ITestService {

	//객체 주입 받겠다.
	@Autowired
	public ITestDao iTestDao;
	
	@Override
	public List<HashMap<String, String>> getBList() throws Throwable {
		
		return iTestDao.getBList();
	}

	/*
	 * @Override public List<HashMap<String, String>> getMList() throws Throwable {
	 * 
	 * return iTestDao.getMList(); }
	 */

	@Override
	public HashMap<String, String> getB(HashMap<String, String> params) throws Throwable {
		
		return iTestDao.getB(params);
	}

	@Override
	public int addB(HashMap<String, String> params) throws Throwable {
		
		return iTestDao.addB(params);
	}

	@Override
	public int updateB(HashMap<String, String> params) throws Throwable {
		// TODO Auto-generated method stub
		return iTestDao.updateB(params);
	}

	@Override
	public int deleteB(HashMap<String, String> params) throws Throwable {
		return iTestDao.deleteB(params);
	}

}
