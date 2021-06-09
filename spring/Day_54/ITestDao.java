package com.spring.sample.web.test.dao;

import java.util.HashMap;
import java.util.List;

public interface ITestDao {
	
	public List<HashMap<String, String>> getBList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getB(HashMap<String, String> params) throws Throwable;

	public int addB(HashMap<String, String> params) throws Throwable;

	public int updateB(HashMap<String, String> params) throws Throwable;

	public int deleteB(HashMap<String, String> params) throws Throwable;

	public int getBCnt(HashMap<String, String> params) throws Throwable;
}
