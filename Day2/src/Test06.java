
public class Test06 {
public static void main(String[]args) {
	int a = 1;
	
	while(a < 10) {
		System.out.println("결과 값 2*"+a+"="+2*a);
		a++;  //끝나야 하니까 증감값 필요
	}
	//거의 안씀!!
	do {
		System.out.println(a);
	} while(a < 5);
	System.out.println("a = 10 이기때문에 do while문을 빠져나와 실행입니다. ");
	for(int i = 1; i < 10 ; i++) {
		if( i % 2 == 1) {
			continue;
		}
		System.out.println(i);
		}
}
}
