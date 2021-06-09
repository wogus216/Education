package com.gd.test.controller;

import java.util.Scanner;

import com.gd.test.service.SingletonService;
import com.gd.test.service.TestService6;

public class TestController6 {
	public int a = 10;

	public static void main(String[] args) {

		TestService6.s = "Hi~";

		System.out.println(TestService6.s);

		// TestService6.SF = "Hi~";

//		System.out.println(a);
		TestController6 tc = new TestController6();

		SingletonService ss = SingletonService.getInstance();

		System.out.println(ss.a);

		ss.a = 7;

		TestService6 ts = new TestService6();

		ts.test();
		// 단축키
		// syso
		System.out.println();

		// 라인 이동 Alt+ 방향키

		// 복사 ctrl+Alt+방향키

		// 지우기 ctrl+d

		// 자동정렬
		//ctrl + shift + f
		
		//import ctrl+shift+o 여러개도 한번에 가능
		Scanner sc = new Scanner(System.in);
		
		//alt + shift +a 포인트 영역 설정
	
		
	}
}
