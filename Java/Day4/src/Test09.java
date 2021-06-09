
public class Test09 {

	public static void main(String[] args) {
		
		Test09s ts = new Test09s(); //객체생성
		Test09s ts2 = new Test09s(); //객체생성
System.out.println("--------------------");		
		ts.a = 7;
		
		 ts=ts2;//같은 주소값을 갖게된다.
		System.out.println(ts.a); // test09s에 있는 a를 불러서 사용하겠습니다.
		System.out.println(ts2.a); 
		
		ts.a();
		System.out.println(ts.b("보낸 값"));  //리턴 값이 호출된 ts.b("보낸 값") 으로 오는 것
		
		ts.plus(3, 7);
		ts.minus(10, 5);
		ts.multi(10, 3);
		ts.division(10, 2);
		ts.rest(10, 5);
		System.out.println("----------------------");
		System.out.println(ts.plus2(5, 2));
		System.out.println(ts.minus2(3, 1));
		System.out.println(ts.multi2(2, 2));
		System.out.println(ts.division2(4, 2));
		System.out.println(ts.rest2(10, 2));
	
		ts.gugu(10);
	}

}
