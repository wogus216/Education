package com.spring.sample.web.test.dao;

import java.util.HashMap;
import java.util.List;

public interface ITestMDao {

	public List<HashMap<String, String>> getMList(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getM(HashMap<String, String> params) throws Throwable;

	public int addM(HashMap<String, String> params) throws Throwable;

	public int updateM(HashMap<String, String> params) throws Throwable;

	public int deleteM(HashMap<String, String> params)  throws Throwable;

	public int getMCnt(HashMap<String, String> params)throws Throwable;

}
