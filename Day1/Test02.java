
public class Test02 {

	public static void main(String[]args) {
		
		int a = 4;
		int b = 2;
		System.out.println("더하기결과  :"+(a + b)); //결과 : 6
		System.out.println("뺄셈 결과 :"+(a - b));  //결과 : 2
		System.out.println("곱셈 결과 :"+(a * b));	//결과 : 8
		System.out.println("나눗셈 결과 :"+(a / b)); //결과 : 2
		System.out.println("나머지 결과 :"+ (a % b));	//결과 : 0
		System.out.println("--------------------------------");
		
		a += 1;
		System.out.println(a); //a=5
		a -= 1;					
		System.out.println(a); //a=4
		a *= 1;
		System.out.println(a);  //a=4
		a /= 1;
		System.out.println(a);  //a=4
		a %= 1;
		System.out.println(a); //a=0;
		System.out.println("--------------------------------");

		System.out.println(++a); // +1 후 출력 1
		System.out.println(a++); // a:1 출력 후 2
		System.out.println(--a); // -1 출력 후 1
		System.out.println(a--); // 출력  후-1 그래서 a = 0
		System.out.println(a);   //출력 a= 0
		System.out.println("--------------------------------");
		//a=0, b=2
		System.out.println(a > b);  //false
		System.out.println(a >= b); //false
		System.out.println(a < b); // true
		System.out.println(a <= b); //true
		System.out.println(a == b); //false
		System.out.println(a != b); //ture
		System.out.println("--------------------------------");
 
		String c = "A";
		
		System.out.println(a + b + c); // "02A"
		System.out.println(c + (b + a)); //"A2"
	}
}
