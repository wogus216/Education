
public class Test11s {
		int a = 10; //전역변수 
		
		public void a(int  b) {
			for(int i= 0; i < 2; i++) {
				System.out.println(a); //지역변수
			}
			
			int a = 7;
			System.out.println(a);//변수도 가까운 것 부터 찾음
			System.out.println(this.a);//this : 이 클래스
		
			System.out.println((float)a); //숫자 -->숫자
			
			float c = 3.6f; 
			System.out.println((int)c);
			
			String s = Integer.toString(a) ;
			System.out.println(s);
			
			System.out.println(Integer.parseInt("123") * 4);
		
			System.out.println((char)('a'- 32));
		}
}
