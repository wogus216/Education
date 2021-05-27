
public class Test14 {
	
	public static void main(String[] args) {
		Test14C tc = new Test14C();
		
		System.out.println(tc.s);
		System.out.println(tc.getPs());

		tc.p();
		//부모, 부모
		Test14P tp1 = new Test14P();
		// 자식 , 자식
		Test14C tc1 = new Test14C();
		// 부모, 자식
		Test14P tp2 = new Test14C();
		// 자식, 부모
//		Test14C tc2 = new Test14P();
		
		tp2.p();
		// 객체 --> 객체 형변환 시 캐스팅. 일반적으로 상속관계
		System.out.println(((Test14C) tp2).getPs()); //다운캐스팅. 부모의 형태를 자식의 형태로 변환.

	
	
	}
}
		