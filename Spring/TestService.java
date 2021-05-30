package com.test.spring.test.service;

import org.springframework.stereotype.Service;

@Service  //스프링이 객체를 만듬 서비스로
public class TestService implements ITestService {

	@Override
	public void test() {

		System.out.println("서비스가 구동 됨.");
	}
	
	@Override
	public String gugu(int num) {
		 String gugu="";
		for(int i =1; i < 10; i++) {
			gugu+=num+ " * "+ i + "="+ (num*i)+"<br/>"; 
		}
		return gugu;
	}

		
}
