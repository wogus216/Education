
public class Day3TestResult {

public static void main(String[] args) {
	
//	int sum= 0;
//	int a = 1;
//	
//	for(int i = 1; i <=5; i++) {
//		a*= i;
//		sum +=a;
		
//	}
//	System.out.println(sum);

//3번  66을 소인수 분해하세요.
/*	int a = 24;
	int result = 0;
	for(int i = 2; i <= a; i++) {
		if(a % i ==0) {
			result = a / i ;
			a=result;
			
			System.out.println(i);
			i--;
			}*/
	int a = 50;
	int i =2 ;
	
	while( i<=a) {
		if(a % i ==0) {
			a /= i;
			System.out.println(i);
		} else {
			i++;
		
		int a1 = 50;
		for(int i1= 2; i1<= a1; i1++) {
			while( a1% i1==0) {
				a1 /= i1;
				System.out.println(i1);
			}
		}
		}
		}
	}
}
