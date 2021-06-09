
public class Day2Test {
	public static void main(String[] args) {
	// 1 1 2 3 5 8 13 21 34 55 출력하기
		int a = 0 ;
		int b = 1 ;
		int c = 0 ;
//				0 + 1 = 1 num1+num2=result;
//				1 + 1 = 2
//				1 + 2 = 3
//				2 + 3 = 5
//				3 + 5 = 8
//				...
//				21 + 34= 55	
		for(int i=0; i<10; i++) {
			c= a + b;
			a=b;
			b=c;
			System.out.println(a);
		}
		
}
}
