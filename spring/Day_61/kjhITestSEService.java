package com.spring.sample.web.tests.service;

import java.util.HashMap;
import java.util.List;



public interface kjhITestSEService {

public	int getSECnt(HashMap<String, String> params) throws Throwable;

public List<HashMap<String, String>> getSEList(HashMap<String, String> params) throws Throwable;

public int addSE(HashMap<String, String> params) throws Throwable;

public HashMap<String, String> getSE(HashMap<String, String> params) throws Throwable;

public int updateSE(HashMap<String, String> params) throws Throwable;

public int deleteSE(HashMap<String, String> params)throws Throwable;


}
