
public class Day3Test {

	// 1~ 100의 합계를 구하시오
	// 1!+2!+3!+4!+5!의결과를 구하시오
	//66을 소인수 분해하시오  소인수분해 
	public static void main(String[] args) {
		
		int sum=0;
		for(int n=1; n<=100 ; n++) {
			sum=n+sum;
		//1번은 답이 5050만 나와야하는 거죠??	
		}
		System.out.println("100의 합계 :"+sum);
	System.out.println("-----------------------------");
//2번  //1+2+6+24+120=153
	int result=1;
	int k =0;
	for(int i =1; i<=5; i++) {
		for(int j=1; j<=i; j++) {
			result=result*j;
		
			}
		k=result+k;
		

	}
	result=1;
	System.out.println(k);
	
	
//	int result=1;
//	int j=0;
//	for(int i=1; i<=5; i++) {
//		result=result*i;
//		j=result+j;
//	}
//	System.out.println(j);

// 3번  66을 소인수 분해하세요.
//	int j=24; 
//	int result = 0;
//	
//	for(int i = 2; i <= j; i++) {
//		if(j %i ==0) {
//		result=j/i;
//		System.out.println(i);
//		}
//		j=result;
//	
//		}
	}
}
