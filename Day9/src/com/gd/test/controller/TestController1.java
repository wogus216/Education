package com.gd.test.controller;

import com.gd.test.bean.TestBean;
// import : 해당 클래스의 위치정보
import com.gd.test.service.TestService1;

public class TestController1 {

	public static void main(String[] args) {

			TestService1 ts1 = new TestService1();
//			
//		System.out.println(ts1.a);
//		System.out.println(ts1.b);
			
			TestBean tb = new TestBean();
			//값을 넣올때 setter
			tb.setNo(1);
			tb.setName("권재현");
			tb.setAge(300);
			tb.setAddress("관악구");
			//값을  가져올 때 getter
			System.out.println("번호 :"+tb.getNo()+ " 이름 : "+ tb.getName()+" 나이 :"+ tb.getAge()+" 주소 : "+tb.getAddress());

			float f = 3.541529f;
			
			System.out.println(Math.ceil(f)); // ceil(값) : 올림
			System.out.println(Math.round(f)); // round(값) : 반올림
			System.out.println(Math.floor(f)); // floor(값) : 버림
			
			int a = -3;
			
			System.out.println(Math.abs(a)); // abs(값) : 절대값
	
			System.out.println(Math.pow(2, 10)); //pow(숫자 1, 숫자2) : 숫자1의 숫자 2승
			System.out.println(Math.sqrt(4)); //sqrt(숫자) : 숫자의 루트
			
			System.out.println(Math.random());  // random() 0.0이상 1.0미만의 난수 생성 
			// 15 ~ 25 : 큰수 - 작은수 + 1  => 11
			System.out.println(Math.floor(Math.random()*11 + 15));
	}

}
