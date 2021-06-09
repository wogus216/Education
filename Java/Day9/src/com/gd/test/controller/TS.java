package com.gd.test.controller;

import com.gd.test.service.TestService1;

public class TS extends TestService1  {	
	public void t() {
//		System.out.println(a); //private
		System.out.println(b); //protected 상속관계
	}
}
