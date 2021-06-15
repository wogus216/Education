package com.spring.sample.web.tests.dao;

import java.util.HashMap;
import java.util.List;

public interface ITestSEDao {

	public int getSECnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getSEList(HashMap<String, String> params) throws Throwable;

	public int addSE(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getSE(HashMap<String, String> params) throws Throwable;


}
