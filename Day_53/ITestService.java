package com.spring.sample.web.test.service;

import java.util.HashMap;
import java.util.List;

public interface ITestService {

	public List<HashMap<String, String>> getBList() throws Throwable;

	/* public List<HashMap<String, String>> getMList() throws Throwable; */

	public HashMap<String, String> getB(HashMap<String, String> params) throws Throwable;

	public int addB(HashMap<String, String> params) throws Throwable;

	public int updateB(HashMap<String, String> params) throws Throwable;
}
