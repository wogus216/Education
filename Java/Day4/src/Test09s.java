
public class Test09s {
//어디서든 접근가능 클래스다 !!

	 int a = 10;
	 
	 public Test09s () {
		 System.out.println("기본생성자 실행중.");
	 }
	
	 
	 public Test09s(String str) {//주는 쪽은  타입을 신경써야함
		 System.out.println("추가 생성자 : "+ str);
	 }
	 
	 public void a() {
		 System.out.println("a 메소드 실행"); //출력기능만 있다.
	 }
	 
	 public String b(String str) {
		 return "변경된 내용 : " +str;  
	 }
	 
	 public void plus(int a, int b) {
		 System.out.println("더하기 : "+(a+b));
	 }
	 
	 public int plus2(int a, int b) {
		
		 return a+ b;
	 }

	 public void minus(int a, int b) {
		 System.out.println("마이너스 : "+(a-b));
	 }
	 
	 public int minus2(int a, int b) {
		
		 return a-b;
	 }
	
	 public void multi(int a, int b) {
		 System.out.println("곱하기: "+(a * b));
	 }
	 
	 public int multi2(int a, int b ) {
		 return a*b;
	 }
	 
	 public void division(int a, int b) {
		 System.out.println("나누기 : "+(a / b));
	 }
	 
	 public int division2(int a, int b) {
		 return a/b;
	 }
	 
	 public void rest(int a, int b) {
		 System.out.println("나머지 : "+(a % b));
	 }
	
	 public int rest2(int a, int b) {
		 return a%b;
	 }
	 
	 public void gugu(int dan) {
		 for(int i = 1; i<10; i++) {
			 System.out.println("구구단 결과  " +dan+ " * "+i+" = "+ (dan*i));
		
		 }
		 
	 }
}

