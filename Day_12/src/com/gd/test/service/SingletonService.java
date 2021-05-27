package com.gd.test.service;

public class SingletonService {
	// 정적 변수 선언
	private static SingletonService instance = null;

	//객체취득 메소드
	public static SingletonService getInstance() {
		//큰 A getInstance에 주소값 abc
		if(instance == null) {
			//객체생성
			instance = new SingletonService();
		}
		
		return instance;
	}
	
		public int a = 10;
		
	
	
}
