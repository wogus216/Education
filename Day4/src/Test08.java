
public class Test08 {
	public static void main(String[] args) {
	//2 ~ 100 사이의 소수 구하기.
		int hol = 0;
		for(int a = 1 ; a <= 100 ; a++) {
			if( a% 2 ==1) {
				hol++;
			}
		}
		System.out.println("1에서 100사이의 홀수 개수 :"+ hol );
	System.out.println("*****************************");	
	//2, 3, 5, 7, ,11, 13, 17, 23, 29, 31, 37, 41 ,43, 47, 53 ,59, 61, 67, 71, 73, 79, 83, 89, 97
	int sosucount = 0 ;	
	for(int i = 2; i <= 100; i++) {//대상
			for(int j = 1; j <= i ; j++) {//나누는 수
				if( i % j == 0 ) {
					sosucount++;
				}
		
			}
		if(sosucount == 2) {
			System.out.println(i);
			}
		sosucount=0;
			
		}
	}
}

