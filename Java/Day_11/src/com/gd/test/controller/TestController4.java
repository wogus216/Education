package com.gd.test.controller;

import java.util.Scanner;

public class TestController4 {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		//while문 사용시 종료 먼저 만드는 습관.
		while(true) {
			System.out.println("메뉴를 선택하시오.");
			System.out.println("1. 계속\t9.종료");
			int input = sc.nextInt();
			sc.hasNextLine();
			
			if(input == 9) {
				break;
			}
		}
		System.out.println("종료되었습니다.");
		
		
	}

}
