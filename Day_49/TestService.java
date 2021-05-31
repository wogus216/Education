package com.spring.sample.web.test.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.sample.web.test.dao.ITestDao;

@Service
public class TestService implements ITestService {
	//객체 주입받겠다.
	@Autowired
	public ITestDao iTestDao;

	@Override
	public List<HashMap<String, String>> getBList() throws Throwable {
		return iTestDao.getBList();
	}
}
