package com.spring.sample.web.test.service;

import java.util.HashMap;

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
}
