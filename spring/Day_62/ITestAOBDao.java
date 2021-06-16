package com.spring.sample.web.tests.dao;

import java.util.HashMap;
import java.util.List;

public interface ITestAOBDao {

	public HashMap<String, String> getM(HashMap<String, String> params) throws Throwable;

	public int getOBCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getOBList(HashMap<String, String> params)throws Throwable;

	public int writeOB(HashMap<String, String> params)throws Throwable;

}
