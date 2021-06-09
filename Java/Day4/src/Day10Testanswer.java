
public class Day10Testanswer {
	//i 안건드리고 만들기,for문 두개로도 해보기!!
public static void main(String[] args) {
	//1번
	for(int i = 0; i <5; i++) {
		for(int j =0; j<=i; j++) {
			System.out.print("*");
		}
		System.out.println();
	}
	System.out.println("----------------------------------");
	//2번 k고정
	for(int i =0; i<5; i++) {
		for(int j=0; j<=4-i; j++) {
			System.out.print("*");
		}
		System.out.println();
	}
	System.out.println("----------------------------------");
	//3번 if문 사용 시 4-i 활용, else가 "*"
	for(int i = 0; i<5; i++) {
		for(int j=0; j<4-i; j++) {
			System.out.print(" ");
		}
		for(int k=0; k<=i; k++) {
			System.out.print("*");
		}
		System.out.println();
	}
	System.out.println("----------------------------------");
	//4번
	for(int i=0; i<5; i++) {
		for(int j=0; j<i; j++) {
			System.out.print("@");
		}
		for(int k=0; k<=4-i; k++) {
			System.out.print("*");
		}
		System.out.println();
	}
	System.out.println("----------------------------------");	
	//5번
	for(int i= 0; i< 5; i++) {
		for(int j=0; j<4-i; j++) {
			System.out.print("&");
		}
		for(int k = 0; k<=i; k++) {
			System.out.print("*");
		}
		for(int j= 0; j < i; j++) {
			System.out.print("$");
			
		}
		System.out.println();
		}	
	System.out.println("----------------------------------");	
	//6번
	for(int i=0; i<5; i++) {
		for(int j=0; j<i; j++) {
			System.out.print("&");
		}
		for(int k=0; k<=4-i; k++) {
			System.out.print("*");
		}
		for(int h=0; h<4-i; h++) {
			System.out.print("$");
		}
		System.out.println();
		}
	System.out.println("----------------------------------");	
	//7번 
	for(int i= 4; i>=0; i--) {
		for(int j=0; j<i; j++) {
			System.out.print("&");
		}
		for(int k =5; k>i; k--) {
			System.out.print("*");
		}
		for(int h=4; h>i; h--) {
			System.out.print("*");
			
		}
		System.out.println();
		}	
	for(int i=1; i<=4; i++) {
		for(int j=0; j<i; j++) {
			System.out.print("&");
		}
		for(int k=5; k>i; k--) {
			System.out.print("*");
		}
		for(int h=4; h>i; h--) {
			System.out.print("*");
		}
		System.out.println();
	}
	System.out.println("----------------------------");
	
	//7번 if문 마지막 규칙 쉽게 찾기위해 기준점 0으로 잡고 찾아보기

	for(int i=0 ; i< 9 ; i++) {
		for(int j= 0; j < 9; j++) {
		if( j < 4 -i || j< i -4 || j > 4+ i || j >= 13 -i) {
			System.out.print("@");
		} else {
			System.out.print("*");
			}
		}
		System.out.println();	
		}
			
		
		}
	}



