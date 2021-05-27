
public class Day10Test {
public static void main(String[] args) {
	//1번
	for(int i = 0; i <5; i++) {
		for(int j =0; j<=i; j++) {
			System.out.print("*");
		}
		System.out.println();
	}
	System.out.println("----------------------------------");
	//2번
	for(int k = 5; k>0; k--) {
		for(int k2=0; k2<k; k2++) {
			System.out.print("*");
		}
		System.out.println();
	}
	System.out.println("----------------------------------");
	//3번
	for(int i = 4; i>=0; i--) {
		for(int j=0; j<i; j++) {
			System.out.print("#");
		}
		for(int k=5; k>i; k--) {
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
		for(int k=5; k>i; k--) {
			System.out.print("*");
		}
		System.out.println();
	}
	System.out.println("----------------------------------");	
	//5번
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
	System.out.println("----------------------------------");	
	//6번
	for(int i=0; i<5; i++) {
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
}
}


