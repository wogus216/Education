package com.gd.test.controller;

import com.gd.test.service.TestService5;

public class TestController5 {

	public static void main(String[] args) {
				try {
					String s = "abc";
//					int a = Integer.parseInt(s);
				throw new NumberFormatException();
//				System.out.println("??????"); // dead code
				} catch(NumberFormatException ne) {
					System.out.println("숫자아님");
					ne.printStackTrace();
				} catch(Exception e){
					System.out.println(e.toString());
					e.printStackTrace();
				
				}
				System.out.println("끝난거 맞음.");
				//try와 catch는 한쌍
				TestService5 ts = new TestService5();
				
				try {
					ts.test();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	}

}
