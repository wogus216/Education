
public class Test05 {
	public static void main(String[]args) {
		int a = 3;
		
		switch(a) {
		case 1: System.out.println(" 결과 값은 1이다.");
			 	break;
		case 3: System.out.println("결과 값은 3이다.");
				break;
		case 5: System.out.println("결과 값은 5이다.");
				break;
		default : System.out.println("기본이다.");
		}
		
		
		int score = 90;
	
		
		
		//다시 풀어보기 /나가아서 +5인경우
		//성적 출력 A+ 95~100, 
		// a: 90~100, b : 80~ 89, c : 70 ~ 79, d: 60 ~ 69, f:나머지
		//범위 형태인 척 범위 문제는 범위 개수가 나누는 수다.
		switch(score/5) {
		case 20: case 19: case 18:
			System.out.println("성적은 A입니다.");
			
		case 17:case 16:
			System.out.println("성적은 B입니다.");
			break;
		case 15: case 14:
			System.out.println("성적은 C입니다.");
			break;
		case 13: case 12:
			System.out.println("성적은 D입니다.");
			break;
		default:
			System.out.println("성적은 F입니다.");
		}
		if(score <= 100 && score >= 90 ) {
			System.out.println("A이다");
		} else if(score <90  && score >= 80 ) {
				System.out.println("B");
		} else if(score <80  && score >= 70 ) {
			System.out.println("C");
		} 	else if(score <70  && score >= 60 ) {
		System.out.println("D");
		}	else {
			System.out.println("F");
		}
		
		
	}
}
