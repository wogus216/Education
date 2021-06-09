package com.gd.test.service;

public class TestService6 {
	public static String s = "static 변수이지롱";
	
	public static final String SF= "상수임"; //파이널 덕분에 값변경 안된다.
	
	public void test() {
		SingletonService ss =  SingletonService.getInstance();
		//인스턴스는 주소 만 담는다.
		System.out.println(ss.a);
	}
}
