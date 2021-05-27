
public class Test04 {

	public static void main(String[] args) {
		int a = 5; //5
		int b = 7; //7
		int c = 3; //3
		int temp;
		//작업 ,오름 차순 정렬  a<b<c ,기능 하나씩 
		if(a>b) {
			temp = a;
			a = b;
			b = temp;
		}
		
		if(a>c) {
			temp = a; 
			a = c;     
			c = temp;	
		}
		
		if(b>c){
			temp = b;
			b = c;
			c = temp;
		}
		
		//선언 시 변수는 공간을 만드는 것이다. !!!	
		
	System.out.println(a);
	System.out.println(b);
	System.out.println(c);

	}

}
