package com.gd.test.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Scanner;

public class TestController3 {

	public static void main(String[] args) {
		//Calendar는시스템에서 객체를 취득한다. 컴퓨터에서 가져온다.
		Calendar c = Calendar.getInstance();
	
		
		
		System.out.println(c.get(Calendar.YEAR)); //연
		//서양과 동양의 차이로 인해 숫자로 보기위해서는 +1, 월은 인덱스 기반 0부터 시작
		System.out.println(c.get(Calendar.MONTH)+1); 
		System.out.println(c.get(Calendar.DATE)); //일
		// 0 -AM, 1 - PM  
		System.out.println(c.get(Calendar.AM_PM));
		System.out.println(c.get(Calendar.HOUR)); //12시간 기준
		System.out.println(c.get(Calendar.HOUR_OF_DAY));  //24시간 기준
		System.out.println(c.get(Calendar.MINUTE)); //분
		System.out.println(c.get(Calendar.SECOND)); //초
		System.out.println(c.get(Calendar.MILLISECOND)); // 밀리초
		//언어마다 다름. 1 - 일요일, 2 - 월요일, 3 - 화요일
		//요일을 가져오겠다 의 경우는 0부터 시작
		// 주에 몇번째 날인지의 경우는 1 부터 시작.
		System.out.println(c.get(Calendar.DAY_OF_WEEK)); // 
		
		// y : 연
		// M : 월
		// d : 일
		// a : am/pm
		// H : 24시간 기준 시
		// h : 12시간 기준 시
		// m : 분
		// s : 초
		
		String p = "yyyy-MM-dd HH:mm:ss";
		
		SimpleDateFormat sdf = new SimpleDateFormat(p);
		//현재날짜를 가져와서 해당 포맷으로 변환하여 문자열로 돌려줌.
		String d = sdf.format(new Date());
	
		System.out.println(d);
		
		Scanner sc = new Scanner(System.in);
		
		System.out.println("글자를 입력해주세요");
		String s = sc.nextLine(); //한줄 받을 때 사용
		
		System.out.println(s);
		
		System.out.println("숫자를 입력해주세요");
		
		int a = sc.nextInt();
		System.out.println(a);
		
		//nextLine과 next사용 시 주의사항
		//next는 한글이 터진다.
		//입력 받을 시에는 nextLine을 사용하자
		s = sc.nextLine();  //라인을 사용할 경우 라인을 위에 하나 더 넣어준다.
		System.out.println("글자를 입력해주세요");
		 s = sc.nextLine(); // next의 경우 다음값을 취득, 엔터와 관계없다.
		System.out.println(s);

	
	
	}

}
